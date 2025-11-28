// presentation/bloc/chat_state.dart
import '../../domain/entities/message.dart';
import '../../domain/entities/client_info.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatConnected extends ChatState {
  final List<Message> messages;
  final List<ClientInfo> clients;

  ChatConnected({required this.messages, required this.clients});
}

class ChatDisconnected extends ChatState {}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
