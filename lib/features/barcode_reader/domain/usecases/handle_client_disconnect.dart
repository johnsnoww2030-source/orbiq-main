// تعریف UseCase برای مدیریت قطع ارتباط کلاینت
import 'package:injectable/injectable.dart';
import '../repositories/chat_repository.dart';

@injectable
class HandleClientDisconnectionUseCase {
  final ChatRepository repository;

  HandleClientDisconnectionUseCase(this.repository);

  Future<void> execute(String clientId) async {
    await repository.handleClientDisconnection(clientId);
  }
}
