import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/effects/sound/dusty_sound.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DustyIslandApp extends StatelessWidget {
  const DustyIslandApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      // 일시적으로 스플래시 스크린 off
      // home: GameSplashScreen(
      //   gameWidget: buildGame(),
      // )
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png')),
        ),
        child: buildGame(),
      ),
    );
  }
}

GameWidget<DustyIslandGame> buildGame() {
  return const GameWidget.controlled(
    gameFactory: DustyIslandGame.new,
  );
}

Future main() async {
  await dotenv.load(fileName: kDebugMode ? '.debug.env' : '.env');
  DustySoundPool.instance.init();
  runApp(const DustyIslandApp());
}
