import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/widgets/splash_screen.dart';

class DustyIslandApp extends StatelessWidget {
  const DustyIslandApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: GameSplashScreen(
        gameWidget: buildGame(),
      ),
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
                await game.startGame();
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
