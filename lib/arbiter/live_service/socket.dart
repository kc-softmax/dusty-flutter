import 'dart:convert';
import 'dart:typed_data';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class BaseArbiterLiveService {
  final String baseSocketUrl;

  BaseArbiterLiveService({required this.baseSocketUrl});

  Future<void> on(
    String url,
    Function(dynamic message) onMessage,
    void Function(String? reason)? onDone,
  );
  void sendByte(ByteBuffer message);
  Future<void> close([int? code, String? reason]);
}

typedef MessageCallbackType = void Function(Map<String, dynamic> json);
typedef DonCallbackType = void Function(String? reason)?;

class ArbiterLiveService extends BaseArbiterLiveService {
  late WebSocketChannel _channel;

  ArbiterLiveService({required super.baseSocketUrl});

  @override
  Future<void> on(
    String url,
    MessageCallbackType onMessage,
    DonCallbackType onDone,
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
      onDone: () => onDone?.call(_channel.closeReason),
    );
  }

  @override
  void sendByte(ByteBuffer message) async {
    if (_channel.closeCode != null) return;
    _channel.sink.add(message.asUint8List());
  }

  @override
  Future<void> close([int? code, String? reason]) async {
    if (_channel.closeCode != null) return;
    await _channel.sink.close(code, reason);
  }
}
