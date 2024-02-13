import 'package:dusty_flutter/arbiter/live_service/base.dart';
import 'package:dusty_flutter/extensions/json.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:typed_data';

class ArbiterLiveService extends BaseArbiterLiveService {
  late WebSocketChannel _channel;

  ArbiterLiveService({required super.baseSocketUrl});

  @override
  Future<void> on(
      String url, Function(Map<String, dynamic> json) onMessage) async {
    _channel = WebSocketChannel.connect(Uri.parse('$baseSocketUrl$url'));
    await _channel.ready;
    _channel.stream.listen((data) {
      if (data is ByteBuffer) {
        onMessage(data.toJson());
      }
    });
  }

  @override
  void sendByte(ByteBuffer message) {
    _channel.sink.add(message);
  }

  @override
  void close() {
    _channel.sink.close();
  }
}
