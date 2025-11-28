// domain/entities/message.dart
class Message {
  final String text;
  final bool isSent;
  final DateTime timestamp;
  final String? sender;

  Message({
    required this.text,
    required this.isSent,
    required this.timestamp,
    this.sender,
  });
}
