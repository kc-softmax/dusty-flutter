import 'package:dusty_flutter/main.dart';
import 'package:dusty_flutter/views/global_error.dart';
import 'package:flutter/material.dart';

class GlobalErrorHandler {
  static final GlobalErrorHandler _instance = GlobalErrorHandler._internal();

  factory GlobalErrorHandler() {
    return _instance;
  }

  GlobalErrorHandler._internal();

  void handleError(Object error, StackTrace stackTrace) {
    debugPrint('$error');
    debugPrint('$stackTrace');
    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => const GlobalErrorView(),
    ));
  }
}
