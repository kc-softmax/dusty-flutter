import 'package:dusty_flutter/arbiter/live_service/base.dart';
import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:dusty_flutter/extensions/json.dart';

class ArbiterLiveService extends BaseArbiterLiveService {
  late WebSocket _webSocket;

  ArbiterLiveService({required super.baseSocketUrl});

  @override
  Future<void> on(
    String url,
    Function(Map<String, dynamic> json) onMessage,
    void Function()? onDone,
  ) async {
    _webSocket = WebSocket('$baseSocketUrl$url')..binaryType = 'arraybuffer';
    _webSocket.onClose.listen((event) {
      onDone?.call();
    });
    _webSocket.onMessage.listen(
      (event) {
        final data = event.data;
        if (data is ByteBuffer) {
          onMessage(data.toJson());
        }
      },
    );
  }

  @override
  void sendByte(ByteBuffer message) {
    _webSocket.sendByteBuffer(message);
  }

  @override
  void close() {
    _webSocket.close();
  }
}
