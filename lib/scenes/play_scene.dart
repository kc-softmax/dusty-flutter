import 'dart:async';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/factories/dusty_factory.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/ui/hud.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = 'play';

  GameConfig? gameConfig;

  final hud = Hud();
  final dustyFactory = DustyFactory();

  late final Dusty player;

  @override
  FutureOr<void> onLoad() async {
    gameRef.overlays.addEntry("RestartButton", ((context, game) {
      return FilledButton(
        onPressed: () async {
          debugPrint("restart!!");
          await _resetGame();
        },
        child: const Text("다시 시작"),
      );
    }));
    gameRef.overlays.add("RestartButton");

    player = Dusty()
      ..x = 500
      ..y = 500;

    gameRef.world.add(gameRef.mapComponent);
    gameRef.world.addAll([player]);
    gameRef.camera.follow(player);

    await addAll([
      hud,
      dustyFactory,
    ]);
  }

  @override
  void onMount() {
    super.onMount();
    _startGame();
  }

  @override
  void onRemove() {
    super.onRemove();
    _closeGame();
  }

  Future<void> _startGame() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    Arbiter.liveService.on(
      "/di/ws?token=$token",
      _parseGameMessage,
    );
  }

  void _closeGame() {
    Arbiter.liveService.close();
  }

  Future<void> _resetGame() async {
    _closeGame();
    dustyFactory.clear();
    await _startGame();
  }

  void _parseGameMessage(Map<String, dynamic> json) {
    final gameMessage = GameMessage.fromJson(json);

    debugPrint(gameMessage.toString());

    if (gameMessage.gameConfig != null) {
      gameConfig = gameMessage.gameConfig!;
    }
    if (gameMessage.dusties != null) {
      dustyFactory.addMessages(gameMessage.dusties!);
    }
  }
}
