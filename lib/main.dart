import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/widgets/splash_screen.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';

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
      "TestButton": (BuildContext context, DustyIslandGame game) {
        return FilledButton(
            onPressed: () {
              Arbiter.liveService.on(
                "/di/ws?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDcxMDQyMzYsInN1YiI6IjE1In0.SqJrXhDWl-eQVMyY1m02dm8e1OZqOV1iSY0LSkkP0i0",
                (message) {
                  debugPrint(message.toString());
                },
              );
            },
            child: const Text("TEST"));
      }
    },
  );
}

void main() {
  runApp(const DustyIslandApp());
}
