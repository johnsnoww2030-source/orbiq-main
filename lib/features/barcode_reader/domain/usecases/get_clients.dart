// domain/usecases/get_clients.dart

import 'package:injectable/injectable.dart';
import '../entities/client_info.dart';
import '../repositories/socket_repository.dart';

@injectable
class GetClientsUseCase {
  final SocketRepository repository;

  GetClientsUseCase(this.repository);

  Stream<ClientInfo> call() {
    return repository.getClientsStream();
  }
}
