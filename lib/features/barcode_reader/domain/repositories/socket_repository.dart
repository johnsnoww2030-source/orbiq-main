// domain/repositories/socket_repository.dart
import 'dart:async';
import '../entities/client_info.dart';

abstract class SocketRepository {
  // ... existing methods ...
  Stream<ClientInfo> getClientsStream();
  Future<void> handleClientDisconnection(String clientId);
}
