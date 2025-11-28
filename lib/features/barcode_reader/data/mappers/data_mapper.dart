// data/mappers/data_mappers.dart
import '../models/message_model.dart';
import '../../domain/entities/message.dart';
import '../models/client_info_model.dart';
import '../../domain/entities/client_info.dart';
import 'dart:io'; // برای استفاده از Socket

class DataMappers {
  // تبدیل MessageModel به Message
  static Message messageModelToEntity(MessageModel model) {
    return Message(
      text: model.text,
      isSent: model.isSent,
      timestamp: model.timestamp,
      sender: model.sender,
    );
  }

  // تبدیل Message به MessageModel
  static MessageModel messageEntityToModel(Message entity) {
    return MessageModel(
      text: entity.text,
      isSent: entity.isSent,
      timestamp: entity.timestamp,
      sender: entity.sender,
    );
  }

  // تبدیل ClientInfoModel به ClientInfo (Model to Entity)
  static ClientInfo clientInfoModelToEntity(ClientInfoModel model) {
    return ClientInfo(
      address: model.address,
      connectedAt: model.connectedAt,
    );
  }

  // تبدیل ClientInfo به ClientInfoModel (Entity to Model) با دریافت Socket
  static ClientInfoModel clientInfoEntityToModel(ClientInfo entity, Socket socket) {
    return ClientInfoModel(
      socket: socket,
      address: entity.address,
      connectedAt: entity.connectedAt,
    );
  }
}
