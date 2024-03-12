import 'package:dusty_flutter/arbiter/api/client.dart';
import 'package:dusty_flutter/arbiter/live_service/socket.dart';

// env
const baseUrl = 'http://192.168.0.3:9991';
const baseSocketUrl = 'ws://192.168.0.3:9991';

class Arbiter {
  Arbiter._internal();
  static ArbiterApi api = ArbiterApi(baseUrl: baseUrl);
  static ArbiterLiveService liveService =
      ArbiterLiveService(baseSocketUrl: baseSocketUrl);
}
