// تعریف UseCase برای مدیریت قطع ارتباط کلاینت
import '../repositories/chat_repository.dart';

class HandleClientDisconnectionUseCase {
  final ChatRepository repository;

  HandleClientDisconnectionUseCase(this.repository);

  Future<void> execute(String clientId) async {
    await repository.handleClientDisconnection(clientId);
  }
}
