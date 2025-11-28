// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../../domain/entities/message.dart';
import '../../domain/entities/client_info.dart';
import '../controller/chat_bloc.dart';
import '../controller/chat_event_.dart';
import '../controller/chat_state.dart';

class DataTransferScreen extends StatefulWidget {
  const DataTransferScreen({super.key});

  @override
  DataTransferScreenState createState() => DataTransferScreenState();
}

class DataTransferScreenState extends State<DataTransferScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();
  bool isServer = true;
  String? serverIpAddress;

  @override
  void initState() {
    super.initState();
    _initializeServerIpAddress();
  }

  Future<void> _initializeServerIpAddress() async {
    try {
      final wifiIP = await NetworkInfo().getWifiIP();
      setState(() {
        serverIpAddress = wifiIP;
      });
    } catch (e) {
      print('خطا در دریافت آدرس IP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'انتقال داده',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          Row(
            children: [
              Switch(
                value: isServer,
                onChanged: (value) {
                  if (!isServer) {
                    context.read<ChatBloc>().add(DisconnectEvent());
                  }
                  setState(() {
                    isServer = value;
                  });
                },
                activeThumbColor: Colors.white,
                activeTrackColor: Colors.indigo[300],
              ),
              Text(
                isServer ? 'سرور' : 'کلاینت',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red[400],
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is ChatDisconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('ارتباط با موفقیت قطع شد'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.indigo),
            );
          } else if (state is ChatConnected) {
            _messageController.text = state.messages.isNotEmpty
                ? state.messages.last.text
                : '';
            return _buildChatUI(context, state.messages, state.clients);
          } else {
            return _buildInitialUI(context);
          }
        },
      ),
    );
  }

  Widget _buildInitialUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: isServer
          ? Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<ChatBloc>().add(StartServerEvent());
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'شروع سرور',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _ipController,
                  decoration: InputDecoration(
                    labelText: 'IP سرور',
                    hintText: 'مثال: 192.168.1.100',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.computer,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<ChatBloc>().add(
                      ConnectToServerEvent(_ipController.text),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'اتصال به سرور',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<ChatBloc>().add(AutoConnectToServerEvent());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'اتصال خودکار به سرور',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildChatUI(
    BuildContext context,
    List<Message> messages,
    List<ClientInfo> clients,
  ) {
    return Column(
      children: [
        if (isServer)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.indigo[50],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.computer, color: Colors.indigo),
                    const SizedBox(width: 8),
                    Text(
                      'آدرس سرور: ${serverIpAddress ?? 'در حال تعیین'}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                if (clients.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people, color: Colors.indigo),
                      const SizedBox(width: 8),
                      Text(
                        'تعداد کلاینت‌های متصل: ${clients.length}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  ...clients.map(
                    (client) => Padding(
                      padding: const EdgeInsets.only(right: 32, top: 4),
                      child: Text(
                        'کلاینت: ${client.address}',
                        style: TextStyle(color: Colors.indigo[700]),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Align(
                  alignment: message.isSent
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: message.isSent ? Colors.indigo : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: message.isSent
                            ? const Radius.circular(0)
                            : null,
                        bottomLeft: !message.isSent
                            ? const Radius.circular(0)
                            : null,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: message.isSent ? Colors.white : Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'پیام خود را وارد کنید',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.indigo,
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    context.read<ChatBloc>().add(
                      SendMessageEvent(_messageController.text),
                    );
                    _messageController.clear();
                  },
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.red,
                child: IconButton(
                  icon: const Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.read<ChatBloc>().add(DisconnectEvent());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
