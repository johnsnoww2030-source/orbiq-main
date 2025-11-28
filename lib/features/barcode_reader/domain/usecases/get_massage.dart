// domain/usecases/get_messages.dart
import '../repositories/chat_repository.dart';
import '../entities/message.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  Stream<List<Message>> call() {
    return repository.getMessages();
  }
}
