import 'dart:async';

import 'package:dusty_flutter/arbiter/live_connection/web_rtc/model.dart';

typedef JsonEventCallbackType = void Function(Map<String, dynamic> json);
typedef WebRTCEventCallbackType = void Function(ArbiterWebRTCEvent event);
typedef DoneCallbackType = void Function(String? reason);

abstract class BaseArbiterLiveConnection<T> {
  final String baseSocketUrl;

  BaseArbiterLiveConnection({required this.baseSocketUrl});

  Future<void> on(
    String url,
    T onEvent, {
    DoneCallbackType? onDone,
  });
  Future<void> send(dynamic message);
  Future<void> close();
}
