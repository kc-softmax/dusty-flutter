import 'dart:convert';
import 'dart:typed_data';
import 'package:dusty_flutter/arbiter/live_service/base.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ArbiterLiveService extends BaseArbiterLiveService {
  late WebSocketChannel _channel;

  ArbiterLiveService({required super.baseSocketUrl});

  @override
  Future<void> on(
      String url, Function(Map<String, dynamic> json) onMessage) async {
    _channel = WebSocketChannel.connect(Uri.parse('$baseSocketUrl$url'));
    await _channel.ready;
    _channel.stream.listen((data) {
      if (data is Uint8List) {
        final decoded = const Utf8Decoder().convert(data);
        final dataJson = jsonDecode(decoded);
        onMessage(dataJson);
      }
    });
  }

  @override
  void sendByte(ByteBuffer message) {
    _channel.sink.add(message.asUint8List());
  }

  @override
  void close() {
    _channel.sink.close();
  }
}
