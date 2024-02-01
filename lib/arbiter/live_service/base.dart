import 'dart:typed_data';

abstract class BaseArbiterLiveService {
  final String baseSocketUrl;

  BaseArbiterLiveService({required this.baseSocketUrl});

  Future<void> on(String url, Function(dynamic message) onMessage);
  void send(ByteBuffer message);
  void close();
}
