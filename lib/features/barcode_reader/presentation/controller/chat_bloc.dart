import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_clients.dart';
import '../../domain/usecases/get_massage.dart';
import '../../domain/usecases/handle_client_disconnect.dart';
import 'chat_event_.dart';
import 'chat_state.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/start_server.dart';
import '../../domain/usecases/connect_to_server.dart';
import '../../domain/usecases/auto_connect_to_server.dart';
import '../../domain/usecases/disconnect.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/client_info.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final StartServerUseCase startServerUseCase;
  final ConnectToServerUseCase connectToServerUseCase;
  final AutoConnectToServerUseCase autoConnectToServerUseCase;
  final DisconnectUseCase disconnectUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final GetClientsUseCase getClientsUseCase;
  final HandleClientDisconnectionUseCase handleClientDisconnectionUseCase;
  bool isConnected = false;
  bool isServer = false; // Track if we're in server mode

  StreamSubscription<Message>? _messagesSubscription;
  StreamSubscription<ClientInfo>? _clientSubscription;
  StreamSubscription<ClientInfo>? _clientDisconnectionSubscription;

  List<Message> messages = [];
  List<ClientInfo> clients = [];

  ChatBloc({
    required this.sendMessageUseCase,
    required this.startServerUseCase,
    required this.connectToServerUseCase,
    required this.autoConnectToServerUseCase,
    required this.disconnectUseCase,
    required this.getMessagesUseCase,
    required this.getClientsUseCase,
    required this.handleClientDisconnectionUseCase,
  }) : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<StartServerEvent>(_onStartServer);
    on<ConnectToServerEvent>(_onConnectToServer);
    on<AutoConnectToServerEvent>(_onAutoConnectToServer);
    on<DisconnectEvent>(_onDisconnect);
    on<NewMessageReceivedEvent>(_onNewMessageReceived);
    on<ClientConnectedEvent>(_onClientConnected);
    on<ClientDisconnectedEvent>(_onClientDisconnected);
  }

  Future<void> _onClientDisconnected(
    ClientDisconnectedEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // حذف کلاینت با clientId از لیست کلاینت‌ها
      clients.removeWhere((client) => client.address == event.clientId);

      // چاپ لاگ برای بررسی وضعیت کلاینت‌ها

      // به‌روزرسانی وضعیت در UI
      emit(
        ChatConnected(
          messages: List.from(messages),
          clients: List.from(clients),
          isServer: isServer,
        ),
      );
    } catch (e) {
      emit(ChatError('خطا در مدیریت قطع ارتباط کلاینت: $e'));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await sendMessageUseCase(event.message);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onStartServer(
    StartServerEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      isConnected = true;
      isServer = true; // We're starting as server
      await startServerUseCase();
      // Start listening to messages and clients
      _listenToMessages(emit);
      _listenToClients();
      _listenToClientDisconnections(); // اضافه کردن گوش دادن به قطع ارتباط

      emit(
        ChatConnected(messages: messages, clients: clients, isServer: isServer),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onConnectToServer(
    ConnectToServerEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    await Future.delayed(const Duration(seconds: 1));

    try {
      isServer = false; // We're connecting as client
      await connectToServerUseCase(event.serverIP);

      // Start listening to messages and clients
      _listenToMessages(emit);
      _listenToClients();
      _listenToClientDisconnections(); // اضافه کردن گوش دادن به قطع ارتباط

      emit(
        ChatConnected(messages: messages, clients: clients, isServer: isServer),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onAutoConnectToServer(
    AutoConnectToServerEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      isServer = false; // Auto-connect is for client
      await autoConnectToServerUseCase.execute();

      // Start listening to messages and clients
      _listenToMessages(emit);
      _listenToClients();
      _listenToClientDisconnections(); // اضافه کردن گوش دادن به قطع ارتباط

      isConnected = true;
      emit(
        ChatConnected(messages: messages, clients: clients, isServer: isServer),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onDisconnect(
    DisconnectEvent event,
    Emitter<ChatState> emit,
  ) async {
    if (isConnected) {
      isConnected = false;
      // Cancel subscriptions
      await _messagesSubscription?.cancel();
      _messagesSubscription = null;
      await _clientSubscription?.cancel();
      _clientSubscription = null;
      await _clientDisconnectionSubscription?.cancel();
      _clientDisconnectionSubscription = null;

      // Clear stored messages and clients
      messages.clear();
      clients.clear();

      // Disconnect use case
      await disconnectUseCase();

      emit(ChatDisconnected());
    }
  }

  void _onNewMessageReceived(
    NewMessageReceivedEvent event,
    Emitter<ChatState> emit,
  ) {
    messages.add(event.message);
    emit(
      ChatConnected(
        messages: List.from(messages),
        clients: List.from(clients),
        isServer: isServer,
      ),
    );
  }

  void _onClientConnected(ClientConnectedEvent event, Emitter<ChatState> emit) {
    clients.add(event.clientInfo);
    isConnected = true;
    emit(
      ChatConnected(
        messages: List.from(messages),
        clients: List.from(clients),
        isServer: isServer,
      ),
    );
  }

  void _listenToMessages(Emitter<ChatState> emit) async {
    // Cancel existing subscription
    await _messagesSubscription?.cancel();
    _messagesSubscription = null;

    _messagesSubscription = getMessagesUseCase()
        .expand((messages) => messages)
        .listen((message) {
          add(NewMessageReceivedEvent(message));
        });
  }

  void _listenToClients() async {
    // Cancel existing subscription
    await _clientSubscription?.cancel();
    _clientSubscription = null;

    _clientSubscription = getClientsUseCase().listen((clientInfo) {
      add(ClientConnectedEvent(clientInfo));
    });
  }

  void _listenToClientDisconnections() async {
    // Cancel existing subscription
    await _clientDisconnectionSubscription?.cancel();
    _clientDisconnectionSubscription = null;

    _clientDisconnectionSubscription = getClientsUseCase().listen((clientInfo) {
      if (clients.any((client) => client.address == clientInfo.address)) {
        add(ClientDisconnectedEvent(clientInfo.address));
      }
    });
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _messagesSubscription = null;
    _clientSubscription?.cancel();
    _clientSubscription = null;
    _clientDisconnectionSubscription?.cancel();
    _clientDisconnectionSubscription = null;
    return super.close();
  }
}
