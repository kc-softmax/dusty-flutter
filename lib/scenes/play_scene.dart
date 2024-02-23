import 'dart:async';
import 'package:dusty_flutter/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/characters/dusty_factory.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/tiles/tile_factory.dart';
import 'package:dusty_flutter/towers/tower_factory.dart';
import 'package:dusty_flutter/ui/hud.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = 'play';

  GameConfig? gameConfig;

  final hud = Hud();
  final dustyFactory = DustyFactory();
  final activeObjectsFactory = ActiveObjectsFactory();
  final towerFactory = TowerFactory();
  final tileFactory = TileFactory();
  late final Dusty? player;
  late final int? followerId;

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

    gameRef.world.add(gameRef.mapComponent);

    await addAll([
      hud,
      dustyFactory,
      activeObjectsFactory,
      towerFactory,
      tileFactory,
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
    activeObjectsFactory.clear();
    towerFactory.clear();
    await _startGame();
  }

  void _parseGameMessage(Map<String, dynamic> json) {
    final gameMessage = GameMessage.fromJson(json);

    // debugPrint(gameMessage.toString());
    if (gameMessage.gameConfig != null) {
      gameConfig = gameMessage.gameConfig!;
      followerId = gameConfig?.playerId;
      print(followerId);
    }

    if (gameMessage.dusties != null) {
      dustyFactory.addMessages(gameMessage.dusties!);
    }
    if (gameMessage.actives != null) {
      activeObjectsFactory.addMessages(gameMessage.actives!);
    }
    if (gameMessage.towers != null) {
      towerFactory.addMessages(gameMessage.towers!);
    }
    if (gameMessage.tiles != null) {
      tileFactory.addMessages(gameMessage.tiles!);
    }
  }
}
