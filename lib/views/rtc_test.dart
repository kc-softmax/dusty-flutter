import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_connection/web_rtc/connection.dart';
import 'package:dusty_flutter/arbiter/live_connection/web_rtc/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

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
    webRTCConnection =
        Arbiter.createWebRTCConnection(baseSocketUrl: 'ws://192.168.0.66:8000');
    webRTCConnection.readyLocalMediaStream();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    webRTCConnection.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    // RTCVideoView까지 추상화해야하는가
                    child: RTCVideoView(
                      webRTCConnection.localVideoRenderer,
                    ),
                  ),
                  Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: RTCVideoView(
                        webRTCConnection.remoteVideoRenderer,
                      )),
                ],
              ),
            ),
            TextField(
              controller: textEditingController,
            ),
            const SizedBox(
              height: 8,
            ),
            if (!isConnected)
              ElevatedButton(
                onPressed: connect,
                child: const Text('connect'),
              )
            else
              ElevatedButton(
                onPressed: send,
                child: const Text('message send'),
              ),
            const SizedBox(
              height: 8,
            ),
            if (isConnected) ...[
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: disconnect,
                child: const Text('disconnect'),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Text(
                  chats,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  void connect() async {
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
