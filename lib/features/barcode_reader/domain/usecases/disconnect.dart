// domain/usecases/disconnect.dart
import '../repositories/chat_repository.dart';

class DisconnectUseCase {
  final ChatRepository repository;

  DisconnectUseCase(this.repository);

  Future<void> call() async {
    return await repository.disconnect();
  }
}
