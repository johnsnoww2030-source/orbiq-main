// data/repositories/chat_repository_impl.dart

import 'package:injectable/injectable.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/client_info.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/socket_data_source.dart';
import '../mappers/data_mapper.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final SocketDataSource dataSource;

  ChatRepositoryImpl(this.dataSource);

  @override
  Stream<List<Message>> getMessages() {
    return dataSource.messageStream.map((messageModel) {
      return [DataMappers.messageModelToEntity(messageModel)];
    });
  }

  @override
  Future<void> sendMessage(String message) async {
    dataSource.sendMessage(message);
  }

  @override
  Future<void> startServer() async {
    dataSource.startServer();
  }

  @override
  Future<void> connectToServer(String serverIP) async {
    await dataSource.connectToServer(serverIP);
  }

  @override
  Future<void> disconnect() async {
    dataSource.disconnectClient();
  }

  @override
  Stream<List<ClientInfo>> getClientConnections() {
    return dataSource.clientStream.map((clientModel) {
      return [DataMappers.clientInfoModelToEntity(clientModel)];
    }).asBroadcastStream();
  }

  @override
  Future<void> autoConnectToServer() async {
    await dataSource.connectToServerAutomatically();
  }

  // متد جدید برای مدیریت قطع ارتباط کلاینت‌ها
  @override
  Future<void> handleClientDisconnection(String clientId) async {
    final clientInfo = dataSource.clients.firstWhere(
      (client) => client.address == clientId,
    );
    dataSource.handleClientDisconnection(clientInfo);
  }
}
