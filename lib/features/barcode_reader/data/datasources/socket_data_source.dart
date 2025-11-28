// data/datasources/socket_data_source.dart
// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:network_info_plus/network_info_plus.dart';

import '../models/message_model.dart';
import '../models/client_info_model.dart';

class SocketDataSource {
  static const int port = 4567;
  static const int maxRetryAttempts = 5;

  ServerSocket? server;
  Socket? client;
  final List<ClientInfoModel> clients = [];
  final utf8Encoder = utf8.encoder;
  final utf8Decoder = utf8.decoder;

  StreamController<MessageModel>? _messageController;
  StreamController<ClientInfoModel>? _clientController;

  Stream<MessageModel> get messageStream {
    _messageController ??= StreamController<MessageModel>.broadcast();
    return _messageController!.stream;
  }

  Stream<ClientInfoModel> get clientStream {
    _clientController ??= StreamController<ClientInfoModel>.broadcast();
    return _clientController!.stream;
  }

  void startServer() async {
    if (server != null) {
      print('Server is already running.');
      return;
    }
    try {
      server = await ServerSocket.bind(
        InternetAddress.anyIPv4,
        port,
      );

      server!.listen((Socket socket) {
        final clientInfo = ClientInfoModel(
          address: socket.remoteAddress.address,
          connectedAt: DateTime.now(),
          socket: socket,
        );
        clients.add(clientInfo);
        _clientController?.add(clientInfo);

        // لاگ اضافه شده برای بررسی اتصال کلاینت جدید
        print('کلاینت جدید متصل شد: ${clientInfo.address}');

        socket.listen(
          (List<int> data) {
            final messageText = utf8Decoder.convert(data);
            final messageModel = MessageModel(
              text: messageText,
              isSent: false,
              timestamp: DateTime.now(),
              sender: clientInfo.address,
            );
            _messageController?.add(messageModel);

            // ارسال پیام به سایر کلاینت‌ها
            for (var client in clients) {
              if (client.address != clientInfo.address) {
                client.socket.add(utf8Encoder.convert(messageText));
              }
            }
          },
          onError: (error) {
            handleClientDisconnection(clientInfo);
          },
          onDone: () {
            handleClientDisconnection(clientInfo);
          },
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  void handleClientDisconnection(ClientInfoModel clientInfo) {
    clients.removeWhere((client) => client.address == clientInfo.address);
    _clientController?.add(clientInfo);
    print('کلاینت قطع شد: ${clientInfo.address}');
    // اینجا یک Callback یا UseCase می‌تواند فراخوانی شود تا به لایه‌های بالاتر اطلاع دهد
  }

  Future<void> connectToServer(String serverIP) async {
    int retryAttempts = 0;
    while (retryAttempts < maxRetryAttempts) {
      try {
        client = await Socket.connect(serverIP, port, timeout: const Duration(seconds: 5));
        client!.listen(
          (List<int> data) {
            final messageText = utf8Decoder.convert(data);
            final messageModel = MessageModel(
              text: messageText,
              isSent: false,
              timestamp: DateTime.now(),
            );
            _messageController?.add(messageModel);
          },
          onError: (error) {
            disconnectClient();
          },
          onDone: () {
            disconnectClient();
          },
        );
        print('اتصال به سرور با موفقیت برقرار شد: $serverIP');
        return;
      } catch (e) {
        retryAttempts++;
        print('تلاش مجدد ($retryAttempts/$maxRetryAttempts) برای اتصال به سرور: $serverIP');
        await Future.delayed(const Duration(seconds: 2));
      }
    }
    throw Exception('اتصال به سرور پس از $maxRetryAttempts تلاش ناموفق بود.');
  }

  Future<void> connectToServerAutomatically() async {
    try {
      final wifiIP = await NetworkInfo().getWifiIP();
      if (wifiIP == null) {
        throw Exception('آدرس IP یافت نشد');
      }

      // استخراج subnet از IP دستگاه
      final subnet = wifiIP.substring(0, wifiIP.lastIndexOf('.'));
      bool connected = false;

      // اسکن موازی IPها با کاهش زمان timeout
      final List<Future<void>> connectFutures = [];
      for (int i = 1; i < 255; i++) {
        final host = '$subnet.$i';
        connectFutures.add(_attemptConnection(host).then((success) {
          if (success && !connected) {
            connected = true;
          }
        }));
        if (connected) break;
      }

      await Future.any(connectFutures).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          if (!connected) {
            throw Exception('سروری در شبکه یافت نشد');
          }
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _attemptConnection(String host) async {
    int retryAttempts = 0;
    while (retryAttempts < maxRetryAttempts) {
      try {
        client = await Socket.connect(host, port, timeout: const Duration(seconds: 2));
        _clientController?.add(ClientInfoModel(address: client!.remoteAddress.address, connectedAt: DateTime.now(), socket: client!));
        client!.listen(
          (List<int> data) {
            final messageText = utf8Decoder.convert(data);
            final messageModel = MessageModel(
              text: messageText,
              isSent: false,
              timestamp: DateTime.now(),
            );
            _messageController?.add(messageModel);
          },
          onError: (error) {
            disconnectClient();
          },
          onDone: () {
            disconnectClient();
          },
        );
        print('اتصال موفق به سرور در آدرس: $host');
        return true;
      } catch (e) {
        retryAttempts++;
        print('تلاش مجدد ($retryAttempts/$maxRetryAttempts) برای اتصال به آدرس: $host');
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    return false;
  }

  void sendMessage(String message) {
    final encodedMessage = utf8Encoder.convert(message);
    if (client != null) {
      client!.add(encodedMessage);
    } else if (clients.isNotEmpty) {
      for (var clientInfo in clients) {
        clientInfo.socket.add(encodedMessage);
      }
    }
    final messageModel = MessageModel(
      text: message,
      isSent: true,
      timestamp: DateTime.now(),
    );
    _messageController?.add(messageModel);
  }

  void disconnectClient() {
    client?.destroy();
    client = null;
  }

  Future<void> dispose() async {
    if (server != null) {
      await server!.close();
      server = null;
    }
    for (var clientInfo in clients) {
      clientInfo.socket.destroy();
    }
    clients.clear();
    client?.destroy();
    _messageController?.close();
    _clientController?.close();
    _messageController = null;
    _clientController = null;
  }
}
