import 'package:dusty_flutter/widgets/pre_start_text.dart';
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
    FocusNode focusNode = FocusNode();
    return MaterialApp(
      theme: ThemeData.dark(),
      // 일시적으로 스플래시 스크린 off
      // home: GameSplashScreen(
      //   gameWidget: buildGame(),
      // )
      home: buildGame(focusNode),
    );
  }
}

GameWidget<DustyIslandGame> buildGame(FocusNode focusNode) {
  return GameWidget.controlled(
    gameFactory: () => DustyIslandGame(focusNode),
    overlayBuilderMap: {
      PreStartText.name: (context, game) => const PreStartText(),
    },
    focusNode: focusNode,
  );
}

Future main() async {
  await dotenv.load(fileName: kDebugMode ? '.debug.env' : '.env');
  DustySoundPool.instance.init();
  runApp(const DustyIslandApp());
}
