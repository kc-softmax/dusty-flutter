import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dusty_flutter/arbiter/live_connection/base/connection.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ArbiterWebSocketConnection
    extends BaseArbiterLiveConnection<JsonEventCallbackType> {
  late WebSocketChannel _channel;

  ArbiterWebSocketConnection({required super.baseSocketUrl});

  @override
  Future<void> on(
    String url,
    JsonEventCallbackType onEvent, {
    DoneCallbackType? onDone,
  }) async {
    _channel = WebSocketChannel.connect(Uri.parse('$baseSocketUrl$url'));
    await _channel.ready;
    _channel.stream.listen(
      (data) {
        if (data is Uint8List) {
          final decoded = const Utf8Decoder().convert(data);
          final dataJson = jsonDecode(decoded);
          onEvent(dataJson);
        }
        if (data is String) {
          onEvent(jsonDecode(jsonDecode(data)));
        }
      },
      onDone: () => onDone?.call(_channel.closeReason),
    );
  }

  @override
  Future<void> send(dynamic message) async {
    if (message is ByteBuffer) {
      _channel.sink.add(message.asUint8List());
      return;
    }
    _channel.sink.add(message);
  }

  @override
  Future<void> close([int? code, String? reason]) async {
    if (_channel.closeCode != null) return;
    await _channel.sink.close(code, reason);
  }
}
