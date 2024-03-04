import 'dart:async';
import 'package:dusty_flutter/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/characters/dusty_factory.dart';
import 'package:dusty_flutter/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/tiles/tile_factory.dart';
import 'package:dusty_flutter/towers/tower_factory.dart';
import 'package:dusty_flutter/ui/game_close_dialog.dart';
import 'package:dusty_flutter/ui/hud.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/experimental.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = 'play';
  static Team? selectedTeam;
  GameConfig? gameConfig;
  Dusty? player;
  List<TempRankingData>? rankingList;

  final dustyFactory = DustyFactory();
  final activeObjectsFactory = ActiveObjectsFactory();
  final passiveObjectsFactory = PassiveObjectsFactory();
  final towerFactory = TowerFactory();
  final tileFactory = TileFactory();
  late final int? followerId;
  late final int? playerId;
  late final Hud hud;

  @override
  FutureOr<void> onLoad() async {
    _setCameraBound();

    gameRef.world.add(gameRef.mapComponent);

    await addAll([
      tileFactory,
      dustyFactory,
      activeObjectsFactory,
      passiveObjectsFactory,
      towerFactory,
    ]);
  }

  @override
  void onMount() {
    super.onMount();
    _startGame();

    // TODO TEMP
    // 게임 조기 종료를 위한 타이머
    // 원래는 게임 엔진에서 종료시켜줘야함.
    Timer(const Duration(seconds: 3), () {
      rankingList = [
        const TempRankingData(1, 100, 10, 20),
        const TempRankingData(1, 100, 10, 20),
        const TempRankingData(1, 100, 10, 20),
        const TempRankingData(1, 100, 10, 20),
        const TempRankingData(1, 100, 10, 20),
        const TempRankingData(1, 100, 10, 20),
        const TempRankingData(1, 100, 10, 20),
        const TempRankingData(1, 100, 10, 20),
      ];
      _closeGame();
    });
  }

  @override
  void onRemove() {
    super.onRemove();
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
      _onClosedGame,
    );

    DustySoundPool.instance.bgmOnGamePlaying();
  }

  void _closeGame() {
    Arbiter.liveService.close();
  }

  void _parseGameMessage(Map<String, dynamic> json) {
    final gameMessage = GameMessage.fromJson(json);

    if (gameMessage.gameConfig != null) {
      hud = Hud(gameConfig: gameMessage.gameConfig!);
      gameConfig = gameMessage.gameConfig!;
      followerId = gameConfig?.playerId;
      add(hud);
    }

    if (gameMessage.dusties != null) {
      dustyFactory.addMessages(gameMessage.dusties!);
    }
    if (gameMessage.actives != null) {
      activeObjectsFactory.addMessages(gameMessage.actives!);
    }
    if (gameMessage.passives != null) {
      passiveObjectsFactory.addMessages(gameMessage.passives!);
    }
    if (gameMessage.towers != null) {
      towerFactory.addMessages(gameMessage.towers!);
    }
    if (gameMessage.tiles != null) {
      // tileFactory.addMessages(gameMessage.tiles!);
    }
  }

  void _restGame() {
    gameRef.world = DustyIslandWorld();
  }

  void _onClosedGame() async {
    // 게임 닫기 다이얼로그를 보여준다.
    // 게임 닫기 다이얼로그는 랭킹 테이블, 다시하기 버튼, 나가기 버튼 으로 구성되어 있다.
    // 리턴값에 따라서 다시하기 로직 또는 나가기 로직을 실행한다.
    final isReGame = await gameRef.router.pushAndWait(GameCloseDialog());
    if (isReGame) {
    } else {
      _restGame();
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
