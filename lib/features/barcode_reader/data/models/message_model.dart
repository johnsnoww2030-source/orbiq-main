// data/models/message_model.dart

class MessageModel {
  final String text;
  final bool isSent;
  final DateTime timestamp;
  final String? sender;

  MessageModel({
    required this.text,
    required this.isSent,
    required this.timestamp,
    this.sender,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'],
      isSent: json['isSent'],
      timestamp: DateTime.parse(json['timestamp']),
      sender: json['sender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isSent': isSent,
      'timestamp': timestamp.toIso8601String(),
      'sender': sender,
    };
  }
}
