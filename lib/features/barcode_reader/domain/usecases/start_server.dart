// domain/usecases/start_server.dart
import 'package:injectable/injectable.dart';
import '../repositories/chat_repository.dart';

@injectable
class StartServerUseCase {
  final ChatRepository repository;

  StartServerUseCase(this.repository);

  Future<void> call() async {
    return await repository.startServer();
  }
}
