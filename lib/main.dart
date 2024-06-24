import 'dart:async';

import 'package:dusty_flutter/error/global-error-handler.dart';
import 'package:dusty_flutter/game/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/states/game.dart';
import 'package:dusty_flutter/views/rtc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class DustyIslandApp extends StatelessWidget {
  const DustyIslandApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      navigatorKey: navigatorKey,
      // 일시적으로 스플래시 스크린 off
      // home: GameSplashScreen(
      //   gameWidget: buildGame(),
      // )
      // home: MainGameView(),
      home: const RTCTestScreen(),
    );
  }
}

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: kDebugMode ? '.debug.env' : '.env');
    DustySoundPool.instance.init();
    runApp(
      ChangeNotifierProvider(
        create: (context) => GameModel(),
        child: const DustyIslandApp(),
      ),
    );
  }, (error, stackTrace) {
    GlobalErrorHandler().handleError(error, stackTrace);
  });
}
