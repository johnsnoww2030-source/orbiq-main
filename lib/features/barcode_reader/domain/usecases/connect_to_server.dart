// domain/usecases/connect_to_server.dart
import 'package:injectable/injectable.dart';
import '../repositories/chat_repository.dart';

@injectable
class ConnectToServerUseCase {
  final ChatRepository repository;

  ConnectToServerUseCase(this.repository);

  Future<void> call(String serverIP) async {
    return await repository.connectToServer(serverIP);
  }
}
