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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () async {
                gameRef.overlays.remove("StartButton");
                PlayScene.selectedTeam = Team.alpha;
                gameRef.router.pushReplacementNamed(PlayScene.routerName);
              },
              style: FilledButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue),
              child: const Text("블루팀 시작"),
            ),
            FilledButton(
              onPressed: () async {
                gameRef.overlays.remove("StartButton");
                PlayScene.selectedTeam = Team.beta;
                gameRef.router.pushReplacementNamed(PlayScene.routerName);
              },
              style: FilledButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              child: const Text("레드팀 시작"),
            ),
          ],
        ),
      );
    });
    gameRef.overlays.add('StartButton');
  }
}
