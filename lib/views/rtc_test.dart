import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_connection/web_rtc/connection.dart';
import 'package:dusty_flutter/arbiter/live_connection/web_rtc/model.dart';
import 'package:flutter/material.dart';

class RTCTestScreen extends StatefulWidget {
  const RTCTestScreen({super.key});

  @override
  State<RTCTestScreen> createState() => _RTCTestScreenState();
}

class _RTCTestScreenState extends State<RTCTestScreen> {
  late ArbiterWebRTCConnection webRTCConnection;
  late TextEditingController textEditingController;
  String chats = '';

  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    isConnected = false;
    chats = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
          ),
          const SizedBox(
            height: 8,
          ),
          if (!isConnected)
            ElevatedButton(onPressed: connect, child: const Text('connect'))
          else
            ElevatedButton(onPressed: send, child: const Text('send')),
          const SizedBox(
            height: 8,
          ),
          if (isConnected)
            ElevatedButton(
                onPressed: disconnect, child: const Text('disconnect')),
          const SizedBox(
            height: 8,
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Text(
              chats,
              style: const TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  void connect() async {
    webRTCConnection =
        Arbiter.createWebRTCConnection(baseSocketUrl: 'ws://192.168.0.66:8000');
    await webRTCConnection.on('/chat', onWebRTCEvent);
  }

  void disconnect() async {
    await webRTCConnection.close();
  }

  void send() async {
    final message = textEditingController.value.text;
    await webRTCConnection.send(message);
    setState(() {
      chats += '\nme: $message';
    });
  }

  void onWebRTCEvent(ArbiterWebRTCEvent event) {
    switch (event) {
      case Connected():
        setState(() {
          isConnected = true;
        });
        print('rtc connected');
        break;
      case DataChannelOpened():
        print('data channel opened');
      case DataChannelMessageReceived(messageData: final message):
        print('message received: $message');
        setState(() {
          chats += '\n${message.userId}: ${message.text}';
        });
        break;
      case Closed(error: final error):
        setState(() {
          isConnected = false;
          textEditingController.clear();
        });
        print('rtc closed!!: $error');
    }
  }
}
