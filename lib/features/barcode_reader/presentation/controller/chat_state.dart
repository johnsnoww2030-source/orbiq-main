// presentation/bloc/chat_state.dart
import '../../domain/entities/message.dart';
import '../../domain/entities/client_info.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

enum ConnectionType {
  serverRunning, // سرور فعال است ولی کلاینتی متصل نیست
  connected, // کلاینت‌ها متصل هستند
}

class ChatConnected extends ChatState {
  final List<Message> messages;
  final List<ClientInfo> clients;
  final bool isServer;

  ChatConnected({
    required this.messages,
    required this.clients,
    required this.isServer,
  });

  // Helper method to get connection type
  ConnectionType get connectionType {
    if (isServer && clients.isEmpty) {
      return ConnectionType.serverRunning;
    }
    return ConnectionType.connected;
  }

  // Helper to check if send is allowed
  bool get canSendMessage {
    if (isServer && clients.isEmpty) {
      return false; // سرور فعال ولی کلاینتی نیست
    }
    return true;
  }
}

class ChatDisconnected extends ChatState {}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
