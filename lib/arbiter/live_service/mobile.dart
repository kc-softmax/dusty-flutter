import 'dart:convert';
import 'dart:typed_data';
import 'package:dusty_flutter/arbiter/live_service/base.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ArbiterLiveService extends BaseArbiterLiveService {
  late WebSocketChannel _channel;

  ArbiterLiveService({required super.baseSocketUrl});

  @override
  Future<void> on(
    String url,
    Function(Map<String, dynamic> json) onMessage,
    void Function()? onDone,
  ) async {
    _channel = WebSocketChannel.connect(Uri.parse('$baseSocketUrl$url'));
    await _channel.ready;
    _channel.stream.listen(
      (data) {
        if (data is Uint8List) {
          final decoded = const Utf8Decoder().convert(data);
          final dataJson = jsonDecode(decoded);
          onMessage(dataJson);
        }
      },
      onDone: onDone,
    );
  }

  @override
  void sendByte(ByteBuffer message) async {
    // NOTE
    // websocket의 연결 상태를 확인 후 처리하고 싶으나
    // 라이브러리에서 연결 상태 값을 가져올 수 없어 try-catch로 처리
    try {
      _channel.sink.add(message.asUint8List());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void close() async {
    try {
      await _channel.sink.close();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
