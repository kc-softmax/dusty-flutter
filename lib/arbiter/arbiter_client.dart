import 'package:dusty_flutter/arbiter/api/client.dart';
import 'package:dusty_flutter/arbiter/live_connection/web_rtc/connection.dart';
import 'package:dusty_flutter/arbiter/live_connection/web_socket/connection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// env
final defaultBaseUrl =
    dotenv.get('ARBITER_BASE_API_URL', fallback: 'http://192.168.0.66:9991');
final defaultBaseSocketUrl =
    dotenv.get('ARBITER_BASE_SOCKET_URL', fallback: 'ws://192.168.0.66:9991');

class Arbiter {
  Arbiter._internal();
  static ArbiterApi api = ArbiterApi(baseUrl: defaultBaseUrl);

  static ArbiterWebSocketConnection createWebSocketConnection(
      {String? baseSocketUrl}) {
    return ArbiterWebSocketConnection(
        baseSocketUrl: baseSocketUrl ?? defaultBaseSocketUrl);
  }

  static ArbiterWebRTCConnection createWebRTCConnection(
      {String? baseSocketUrl}) {
    return ArbiterWebRTCConnection(
        baseSocketUrl: baseSocketUrl ?? defaultBaseSocketUrl);
  }
}
