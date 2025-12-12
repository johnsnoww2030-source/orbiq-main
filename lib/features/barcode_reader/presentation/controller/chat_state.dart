import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/client_info.dart';

enum ConnectionType {
  serverRunning, // سرور فعال است ولی کلاینتی متصل نیست
  connected, // کلاینت‌ها متصل هستند
}

sealed class ChatState extends Equatable {
  const ChatState();

  // Helper methods for ChatConnected state
  ConnectionType? get connectionType {
    final state = this;
    if (state is ChatConnected) {
      return state.isServer && state.clients.isEmpty
          ? ConnectionType.serverRunning
          : ConnectionType.connected;
    }
    return null;
  }

  bool get canSendMessage {
    final state = this;
    if (state is ChatConnected) {
      return !(state.isServer && state.clients.isEmpty);
    }
    return false;
  }
}

class ChatInitial extends ChatState {
  const ChatInitial();

  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {
  const ChatLoading();

  @override
  List<Object?> get props => [];
}

class ChatConnected extends ChatState {
  final List<Message> messages;
  final List<ClientInfo> clients;
  final bool isServer;

  const ChatConnected({
    required this.messages,
    required this.clients,
    required this.isServer,
  });

  @override
  List<Object?> get props => [messages, clients, isServer];
}

class ChatDisconnected extends ChatState {
  const ChatDisconnected();

  @override
  List<Object?> get props => [];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
