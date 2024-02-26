import 'dart:async';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LobbyScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = "lobby";

  @override
  FutureOr<void> onLoad() {
    gameRef.overlays.addEntry('StartButton', (context, game) {
      return Center(
        child: FilledButton(
            onPressed: () async {
              gameRef.overlays.remove("StartButton");
              gameRef.router.pushReplacementNamed(PlayScene.routerName);
            },
            child: const Text("시작")),
      );
    });
    gameRef.overlays.add('StartButton');
  }
}
