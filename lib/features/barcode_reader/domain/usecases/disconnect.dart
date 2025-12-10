// domain/usecases/disconnect.dart
import 'package:injectable/injectable.dart';
import '../repositories/chat_repository.dart';

@injectable
class DisconnectUseCase {
  final ChatRepository repository;

  DisconnectUseCase(this.repository);

  Future<void> call() async {
    return await repository.disconnect();
  }
}
