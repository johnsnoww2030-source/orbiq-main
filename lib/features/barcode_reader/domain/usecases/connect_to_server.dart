// domain/usecases/connect_to_server.dart
import '../repositories/chat_repository.dart';

class ConnectToServerUseCase {
  final ChatRepository repository;

  ConnectToServerUseCase(this.repository);

  Future<void> call(String serverIP) async {
    return await repository.connectToServer(serverIP);
  }
}
