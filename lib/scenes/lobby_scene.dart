import 'dart:async';

import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LobbyScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = "lobby";

  @override
  FutureOr<void> onLoad() {
    // final killLogs = KillLogsComponent();
    // // killlogs move to center
    // killLogs.x = gameRef.size.x / 2;
    // killLogs.y = gameRef.size.y / 2 - 24;
    // killLogs.addKillLog('koreakorea', Team.alpha, RemoveBy.missaile);
    // add(killLogs);
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
