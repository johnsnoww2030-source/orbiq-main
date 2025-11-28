// domain/usecases/get_clients.dart

import '../entities/client_info.dart';
import '../repositories/socket_repository.dart';

class GetClientsUseCase {
  final SocketRepository repository;

  GetClientsUseCase(this.repository);

  Stream<ClientInfo> call() {
    return repository.getClientsStream();
  }
}
