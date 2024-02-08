import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:dusty_flutter/game.dart';

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
      home: buildGame(),
    );
  }
}

GameWidget<DustyIslandGame> buildGame() {
  return const GameWidget.controlled(
    gameFactory: DustyIslandGame.new,
  );
}

void main() {
  runApp(const DustyIslandApp());
}
