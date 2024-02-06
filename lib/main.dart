import 'package:dusty_flutter/scenes/play_scene.dart';
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
  return GameWidget.controlled(
    gameFactory: DustyIslandGame.new,
    overlayBuilderMap: {
      "StartButton": (BuildContext context, DustyIslandGame game) {
        return Center(
          child: FilledButton(
              onPressed: () async {
                game.overlays.remove("StartButton");
                game.router.pushReplacementNamed(PlayScene.routerName);
              },
              child: const Text("시작")),
        );
      },
    },
  );
}

void main() {
  runApp(const DustyIslandApp());
}
