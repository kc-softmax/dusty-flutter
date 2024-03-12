import 'dart:async';

import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LobbyScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = "lobby";
  late Dusty trashDusty;
  late Dusty nativeDusty;

  @override
  FutureOr<void> onLoad() {
    trashDusty = Dusty('Trash', Team.alpha)..x = -84;
    nativeDusty = Dusty('Native', Team.beta)..x = 84;

    gameRef.world.add(trashDusty);
    gameRef.world.add(nativeDusty);

    gameRef.overlays.addEntry('StartButton', (context, game) {
      return Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(top: 120.0),
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
                        fixedSize: const Size(96, 22),
                        foregroundColor: Colors.white,
                        backgroundColor: crimsonColor),
                    child: const Text(
                      "select",
                      style: TextStyle(
                        fontFamily: 'ONEMobilePOP',
                      ),
                    ),
                  ),
                  const SizedBox(width: 72),
                  FilledButton(
                    onPressed: () async {
                      gameRef.overlays.remove("StartButton");
                      PlayScene.selectedTeam = Team.beta;
                      gameRef.router.pushReplacementNamed(PlayScene.routerName);
                    },
                    style: FilledButton.styleFrom(
                        fixedSize: const Size(96, 22),
                        foregroundColor: Colors.black,
                        backgroundColor: yellowDusty),
                    child: const Text(
                      "select",
                      style: TextStyle(
                        fontFamily: 'ONEMobilePOP',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
    gameRef.overlays.add('StartButton');
  }

  @override
  void onRemove() {
    nativeDusty.removeFromParent();
    trashDusty.removeFromParent();
  }
}
