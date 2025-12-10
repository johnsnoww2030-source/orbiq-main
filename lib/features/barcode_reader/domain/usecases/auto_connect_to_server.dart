// domain/usecases/auto_connect_to_server.dart
import 'package:injectable/injectable.dart';
import '../repositories/chat_repository.dart';

@injectable
class AutoConnectToServerUseCase {
  final ChatRepository repository;

  AutoConnectToServerUseCase(this.repository);

  Future<void> execute() async {
    return await repository.autoConnectToServer();
  }
}
