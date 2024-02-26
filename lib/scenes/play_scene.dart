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
import 'package:flame/experimental.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = 'play';
  static Team? selectedTeam;
  GameConfig? gameConfig;
  Dusty? player;

  final hud = Hud();
  final dustyFactory = DustyFactory();
  final activeObjectsFactory = ActiveObjectsFactory();
  final towerFactory = TowerFactory();
  final tileFactory = TileFactory();
  late final int? followerId;
  late final int? playerId;

  @override
  FutureOr<void> onLoad() async {
    // gameRef.overlays.addEntry("RestartButton", ((context, game) {
    //   return FilledButton(
    //     onPressed: () async {
    //       debugPrint("restart!!");
    //       await _resetGame();
    //     },
    //     child: const Text("다시 시작"),
    //   );
    // }));
    // gameRef.overlays.add("RestartButton");

    _setCameraBound();

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
    // gameRef.overlays.add("RestartButton");
    _startGame();
  }

  @override
  void onRemove() {
    super.onRemove();
    // gameRef.overlays.remove("RestartButton");
    _closeGame();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _setCameraBound();
  }

  void _setCameraBound() {
    final viewportX = gameRef.camera.viewport.size.x;
    final viewportY = gameRef.camera.viewport.size.y;
    final mapWidth = gameRef.world.mapComponent.width;
    final mapHeight = gameRef.world.mapComponent.height;
    gameRef.camera.setBounds(Rectangle.fromLTWH(
      viewportX * 0.5,
      viewportY * 0.5,
      mapWidth - viewportX,
      mapHeight - viewportY,
    ));
  }

  Future<void> _startGame() async {
    assert(PlayScene.selectedTeam != null);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    playerId = (await SharedPreferences.getInstance()).getInt('playerId');
    Arbiter.liveService.on(
      "/di/ws?token=$token&team=${selectedTeam!.code}",
      _parseGameMessage,
    );
  }

  void _closeGame() {
    Arbiter.liveService.close();
  }

  // Future<void> _resetGame() async {
  //   _closeGame();
  //   dustyFactory.clear();
  //   activeObjectsFactory.clear();
  //   towerFactory.clear();
  //   await _startGame();
  // }

  void _parseGameMessage(Map<String, dynamic> json) {
    final gameMessage = GameMessage.fromJson(json);

    // debugPrint(gameMessage.toString());
    if (gameMessage.gameConfig != null) {
      gameConfig = gameMessage.gameConfig!;
      followerId = gameConfig?.playerId;
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

  @override
  void update(double dt) {
    super.update(dt);
    if (player != null) {
      // && player?.targetId != null
      if (player?.targetId != null) {
        if (player!.targetId! > 0) {
          //lock on target
          if (player!.targetId! != player?.lockOnId) {
            final target = dustyFactory.objects[player?.targetId];
            if (target != null) {
              target.setAim(true);
              player?.lockOnId = player?.targetId; //
            }
          }
        } else {
          // release target
          if (player?.lockOnId != null) {
            final lockOnTarget = dustyFactory.objects[player?.lockOnId];
            if (lockOnTarget != null) {
              lockOnTarget.setAim(false);
            }
            player?.lockOnId = null;
          }
        }
      }
    }
  }
}
