import 'package:dusty_flutter/arbiter/api/client.dart';
import 'package:dusty_flutter/arbiter/live_service/socket.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// env
final baseUrl =
    dotenv.get('ARBITER_BASE_API_URL', fallback: 'http://192.168.0.66:9991');
final baseSocketUrl =
    dotenv.get('ARBITER_BASE_SOCKET_URL', fallback: 'ws://192.168.0.66:9991');

class Arbiter {
  Arbiter._internal();
  static ArbiterApi api = ArbiterApi(baseUrl: baseUrl);
  static ArbiterLiveService liveService =
      ArbiterLiveService(baseSocketUrl: baseSocketUrl);
}
