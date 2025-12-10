// domain/usecases/send_message.dart
import 'package:injectable/injectable.dart';
import '../repositories/chat_repository.dart';

@injectable
class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> call(String message) async {
    return await repository.sendMessage(message);
  }
}
