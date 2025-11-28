import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbiq/features/barcode_reader/data/datasources/socket_data_source.dart';
import 'package:orbiq/features/barcode_reader/data/repositories/chat_repository_impl.dart';
import 'package:orbiq/features/barcode_reader/data/repositories/socket_repository_impl.dart';
import 'package:orbiq/features/barcode_reader/domain/usecases/auto_connect_to_server.dart';
import 'package:orbiq/features/barcode_reader/domain/usecases/connect_to_server.dart';
import 'package:orbiq/features/barcode_reader/domain/usecases/disconnect.dart';
import 'package:orbiq/features/barcode_reader/domain/usecases/get_clients.dart';
import 'package:orbiq/features/barcode_reader/domain/usecases/get_massage.dart';
import 'package:orbiq/features/barcode_reader/domain/usecases/handle_client_disconnect.dart';
import 'package:orbiq/features/barcode_reader/domain/usecases/send_message.dart';
import 'package:orbiq/features/barcode_reader/domain/usecases/start_server.dart';
import 'package:orbiq/features/barcode_reader/presentation/controller/chat_bloc.dart';

List<BlocProvider> chatBlocProviders() {
  // ایجاد SocketDataSource و ChatRepository
  final socketDataSource = SocketDataSource();
  final chatRepository = ChatRepositoryImpl(socketDataSource);
  final socketRepository = SocketRepositoryImpl(socketDataSource);
  final getClientsUseCase = GetClientsUseCase(socketRepository);

  return [
    BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(
        sendMessageUseCase: SendMessageUseCase(chatRepository),
        startServerUseCase: StartServerUseCase(chatRepository),
        connectToServerUseCase: ConnectToServerUseCase(chatRepository),
        autoConnectToServerUseCase: AutoConnectToServerUseCase(chatRepository),
        disconnectUseCase: DisconnectUseCase(chatRepository),
        getMessagesUseCase: GetMessagesUseCase(chatRepository),
        getClientsUseCase: getClientsUseCase,
        handleClientDisconnectionUseCase: HandleClientDisconnectionUseCase(
          chatRepository,
        ),
      ),
    ),
  ];
}
