import 'dart:async';
import 'dart:math';

import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/dusty.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:dusty_flutter/game/ui/overlays/pre_start_text.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LobbySceneWorld extends World with HasGameRef<DustyIslandGame> {
  late Dusty trashDusty;
  late Dusty nativeDusty;

  @override
  FutureOr<void> onLoad() {
    gameRef.camera = CameraComponent();

    if (gameRef.isVerifiedAuth) {
      setReadyGame();
    } else {
      setLogin();
    }
  }

  @override
  void onRemove() {
    gameRef.overlays.remove(PreStartText.name);
  }

  void setReadyGame() {
    trashDusty = Dusty('Colonists', Team.colonists, Random().nextInt(100))
      ..x = -84;
    nativeDusty = Dusty('Guardians', Team.guardians, Random().nextInt(100))
      ..x = 84;
    addAll([trashDusty, nativeDusty]);

    gameRef.overlays.addEntry('StartButtons', buildStartButtons);
    gameRef.overlays.add('StartButtons');
  }

  void setLogin() {
    gameRef.overlays.addEntry('LoginPannel', buildLoginPannel);
    gameRef.overlays.add('LoginPannel');
  }

  Widget buildLoginPannel(BuildContext context, Game game) {
    final controller = TextEditingController();
    return Center(
      child: SizedBox(
        width: 400,
        height: 400,
        child: Card(
          color: Colors.transparent,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 48.0),
                child: Text(
                  'Dusty Island',
                  style: TextStyle(
                    fontFamily: 'ONEMobilePOP',
                    fontSize: 56,
                    shadows: [
                      Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.black),
                      Shadow(
                          // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.black),
                      Shadow(
                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: Colors.black),
                      Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 56,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 240,
                    child: TextField(
                      textAlign: TextAlign.center,
                      maxLength: 10,
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Input UserName',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            )),
                      ),
                      style: const TextStyle(
                        fontFamily: 'ONEMobilePOP',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FilledButton(
                      style: FilledButton.styleFrom(
                        fixedSize: const Size(96, 22),
                      ),
                      onPressed: () async {
                        final result = await Arbiter.api.loginByUserName(
                            RequestLoginByUserName(
                                userName: controller.value.text.trim()));
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setInt("playerId", result.id);
                        await prefs.setString("token", result.accessToken);
                        await prefs.setString("userName", result.userName);
                        gameRef.isVerifiedAuth = true;
                        gameRef.overlays.remove('LoginPannel');
                        setReadyGame();
                      },
                      child: const Text(
                        "login",
                        style: TextStyle(
                          fontFamily: 'ONEMobilePOP',
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStartButtons(BuildContext context, Game game) {
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
                    // "잠시 후에 게임을 시작합니다" 문구
                    gameRef.overlays.add(PreStartText.name);
                    gameRef.overlays.remove('StartButtons');
                    await gameRef.requestGameJoin(team: Team.colonists);
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
                    gameRef.overlays.add(PreStartText.name);
                    gameRef.overlays.remove('StartButtons');
                    await gameRef.requestGameJoin(team: Team.guardians);
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
  }
}
