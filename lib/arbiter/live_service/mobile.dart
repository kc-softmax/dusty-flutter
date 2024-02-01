import 'package:dusty_flutter/arbiter/live_service/base.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:typed_data';

class ArbiterLiveService extends BaseArbiterLiveService {
  late WebSocketChannel _channel;

  ArbiterLiveService({required super.baseSocketUrl});

  @override
  Future<void> on(String url, Function(dynamic message) onMessage) async {
    _channel = WebSocketChannel.connect(Uri.parse('$baseSocketUrl$url'));
    await _channel.ready;
    _channel.stream.listen(onMessage);
  }

  @override
  void send(ByteBuffer message) {
    _channel.sink.add(message);
  }

  @override
  void close() {
    _channel.sink.close();
  }
}
