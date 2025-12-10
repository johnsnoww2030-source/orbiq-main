// data/repositories/socket_repository_impl.dart
import 'package:injectable/injectable.dart';
import '../../domain/repositories/socket_repository.dart';
import '../../domain/entities/client_info.dart';
import '../datasources/socket_data_source.dart';

@LazySingleton(as: SocketRepository)
class SocketRepositoryImpl implements SocketRepository {
  final SocketDataSource dataSource;

  SocketRepositoryImpl(this.dataSource);

  // ... existing methods ...

  @override
  Stream<ClientInfo> getClientsStream() {
    return dataSource.clientStream.map((clientInfoModel) {
      // Convert ClientInfoModel to ClientInfo entity if needed
      return ClientInfo(
        address: clientInfoModel.address,
        connectedAt: clientInfoModel.connectedAt,
      );
    });
  }

  @override
  Future<void> handleClientDisconnection(String clientId) async {
    final clientInfo = dataSource.clients.firstWhere(
      (client) => client.address == clientId,
    );
    dataSource.handleClientDisconnection(clientInfo);
  }
}
