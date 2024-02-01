import 'package:dusty_flutter/arbiter/live_service/base.dart';
import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class ArbiterLiveService extends BaseArbiterLiveService {
  late WebSocket _webSocket;

  ArbiterLiveService({required super.baseSocketUrl});

  @override
  Future<void> on(String url, Function(dynamic) onMessage) async {
    _webSocket = WebSocket('$baseSocketUrl$url')..binaryType = 'arraybuffer';
    _webSocket.onMessage.listen((event) {
      if (event.data is ByteBuffer) {
        onMessage(Uint8List.view(event.data as ByteBuffer));
      }
    });
  }

  @override
  void send(ByteBuffer message) {
    _webSocket.send(message);
  }

  @override
  void close() {
    _webSocket.close();
  }
}
