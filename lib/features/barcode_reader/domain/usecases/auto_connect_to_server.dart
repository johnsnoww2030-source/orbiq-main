// domain/usecases/auto_connect_to_server.dart
import '../repositories/chat_repository.dart';

class AutoConnectToServerUseCase {
  final ChatRepository repository;

  AutoConnectToServerUseCase(this.repository);

  Future<void> execute() async {
    return await repository.autoConnectToServer();
  }
}
