// domain/usecases/start_server.dart
import '../repositories/chat_repository.dart';

class StartServerUseCase {
  final ChatRepository repository;

  StartServerUseCase(this.repository);

  Future<void> call() async {
    return await repository.startServer();
  }
}
