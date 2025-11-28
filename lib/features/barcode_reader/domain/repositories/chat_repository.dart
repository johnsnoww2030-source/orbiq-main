import '../entities/message.dart';
import '../entities/client_info.dart';

abstract class ChatRepository {
  Stream<List<Message>> getMessages();
  Future<void> sendMessage(String message);
  Future<void> startServer();
  Future<void> connectToServer(String serverIP);
  Future<void> disconnect();
  Stream<List<ClientInfo>> getClientConnections(); // تغییر از ClientInfo به List<ClientInfo>
  Future<void> autoConnectToServer(); // Added for auto-connect feature
  Future<void> handleClientDisconnection(String clientId);
}
