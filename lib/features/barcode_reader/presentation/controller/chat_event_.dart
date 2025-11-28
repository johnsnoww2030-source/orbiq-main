// presentation/bloc/chat_event.dart

import '../../domain/entities/client_info.dart';
import '../../domain/entities/message.dart';

abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;

  SendMessageEvent(this.message);
}

class StartServerEvent extends ChatEvent {}

class ConnectToServerEvent extends ChatEvent {
  final String serverIP;

  ConnectToServerEvent(this.serverIP);
}

class AutoConnectToServerEvent extends ChatEvent {}

class DisconnectEvent extends ChatEvent {}

class NewMessageReceivedEvent extends ChatEvent {
  final Message message;

  NewMessageReceivedEvent(this.message);
}

class ClientConnectedEvent extends ChatEvent {
  final ClientInfo clientInfo;

  ClientConnectedEvent(this.clientInfo);
}

class ClientDisconnectedEvent extends ChatEvent {
  final String clientId;
  ClientDisconnectedEvent(this.clientId);
}
