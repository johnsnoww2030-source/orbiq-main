import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/client_info.dart';

part 'chat_state.freezed.dart';

enum ConnectionType {
  serverRunning, // سرور فعال است ولی کلاینتی متصل نیست
  connected, // کلاینت‌ها متصل هستند
}

@freezed
class ChatState with _$ChatState {
  const ChatState._();

  const factory ChatState.initial() = ChatInitial;
  const factory ChatState.loading() = ChatLoading;
  const factory ChatState.connected({
    required List<Message> messages,
    required List<ClientInfo> clients,
    required bool isServer,
  }) = ChatConnected;
  const factory ChatState.disconnected() = ChatDisconnected;
  const factory ChatState.error(String message) = ChatError;

  // Helper methods for ChatConnected state
  ConnectionType? get connectionType => mapOrNull(
    connected: (s) => s.isServer && s.clients.isEmpty
        ? ConnectionType.serverRunning
        : ConnectionType.connected,
  );

  bool get canSendMessage =>
      mapOrNull(connected: (s) => !(s.isServer && s.clients.isEmpty)) ?? false;
}
