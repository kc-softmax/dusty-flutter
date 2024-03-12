import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:dusty_flutter/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/arbiter/live_service/system_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/characters/dusty_factory.dart';
import 'package:dusty_flutter/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/tiles/tile_factory.dart';
import 'package:dusty_flutter/ui/flutter_overlay_dialogs.dart';
import 'package:dusty_flutter/ui/hud.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/experimental.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = 'play';
  static Team? selectedTeam;
  GameConfig? gameConfig;
  Dusty? player;
  // 더미데이터
  List<GamePlayerRecord>? rankingList = [
    const GamePlayerRecord(
      userId: 1,
      userName: 'softmax',
      team: Team.alpha,
      kill: 20,
      death: 30,
      territory: 100,
    ),
    const GamePlayerRecord(
      userId: 1,
      userName: 'softmax',
      team: Team.alpha,
      kill: 20,
      death: 30,
      territory: 100,
    ),
    const GamePlayerRecord(
      userId: 1,
      userName: 'softmax',
      team: Team.alpha,
      kill: 20,
      death: 30,
      territory: 100,
    ),
  ];
  double serverDelta = 0;
  double playerAngle = 0; // radians

  final dustyFactory = DustyFactory();
  final activeObjectsFactory = ActiveObjectsFactory();
  final passiveObjectsFactory = PassiveObjectsFactory();
  final tileFactory = TileFactory();

  late final int? followerId;
  late final int? playerId;
  late final Hud hud;

  late final SpriteComponent autoRange;

  @override
  FutureOr<void> onLoad() async {
    _setCameraBound();

    gameRef.world.add(gameRef.mapComponent);

    await addAll([
      tileFactory,
      dustyFactory,
      activeObjectsFactory,
      passiveObjectsFactory,
    ]);
    autoRange =
        SpriteComponent(sprite: gameRef.atlas.findSpriteByName('auto_range'))
          ..anchor = Anchor.center
          ..opacity = 0;
    gameRef.world.add(autoRange);
  }

  @override
  void onMount() {
    super.onMount();
    _startGame();
    // TEMP
    // 게임 종료를 위한 타이머
    // Timer(const Duration(seconds: 3), () {
    //   _closeGame();
    // });
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
      serverDelta = 1 / gameMessage.gameConfig!.frameRate;
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
    if (gameMessage.tiles != null) {
      tileFactory.addMessages(gameMessage.tiles!);
    }
  }

  void _restGame(bool isReGame) {
    if (isReGame) {
      gameRef.world = DustyIslandWorld.reGame();
    } else {
      gameRef.world = DustyIslandWorld();
    }
  }

  void _onClosedGame() async {
    // 게임 닫기 다이얼로그를 보여준다.
    // 게임 닫기 다이얼로그는 랭킹 테이블, 다시하기 버튼, 나가기 버튼 으로 구성되어 있다.
    // 리턴값에 따라서 다시하기 로직 또는 나가기 로직을 실행한다.
    final isReGame = await gameRef.router.pushAndWait(GameCloseDialog());
    _restGame(isReGame);
  }

  void lockOnTarget() {
    if (player?.targetId != player?.lockOnId) {
      final target = dustyFactory.objects[player?.targetId];
      if (target != null) {
        target.setAim(true);
        player?.lockOnId = player?.targetId; //
      }
    }
  }

  void releaseTarget() {
    if (player?.lockOnId != null) {
      final lockOnTarget = dustyFactory.objects[player?.lockOnId];
      if (lockOnTarget != null) {
        lockOnTarget.setAim(false);
      }
      player?.lockOnId = null;
    }
  }

  void updatePlayerAngle(double dt) {
    var targetAngle = player!.targetDirectionIndex * pi * 2 / 12;
    final toRotateAngle =
        ((targetAngle - playerAngle + pi) % (2 * pi)) - pi; // -pi ~ pi 범위로 정규화

    var expectedPlayerAngle = playerAngle;
    if (toRotateAngle > 0) {
      // 시계 방향으로 회전해야 함
      if (toRotateAngle > pi) {
        // 실제로는 반시계 방향 회전이 더 짧습니다
        expectedPlayerAngle -= 2 * pi - toRotateAngle; // 반시계 방향으로 최소 회전
      } else {
        expectedPlayerAngle += toRotateAngle; // 시계 방향으로 최소 회전
      }
    } else {
      // 반시계 방향으로 회전해야 함
      if (toRotateAngle < -pi) {
        // 실제로는 시계 방향 회전이 더 짧습니다
        expectedPlayerAngle += 2 * pi + toRotateAngle; // 시계 방향으로 최소 회전
      } else {
        expectedPlayerAngle += toRotateAngle; // 반시계 방향으로 최소 회전
      }
    }

    // 서버 업데이트와 프레임 갱신 사이에서 선형 보간을 사용해 부드러운 회전을 구현
    playerAngle =
        lerpDouble(playerAngle, expectedPlayerAngle, dt / serverDelta)!;
    autoRange.angle = playerAngle;
    playerAngle %= pi * 2;
    // player angle 이 12시 방향 근처에 있을때는 방향 전환을 하지 않는다.
    // player angle 이 6시 방향 근처에 있을때는 방향 전환을 하지 않는다.
    if (playerAngle < pi * 13 / 12 && playerAngle > pi * 11 / 12) {
      return;
    } else if (playerAngle < pi / 12 || playerAngle > pi * 23 / 12) {
      return;
    } else if (playerAngle < pi && player!.isFlippedHorizontally) {
      player!.flipHorizontally();
    } else if (playerAngle > pi && !player!.isFlippedHorizontally) {
      player!.flipHorizontally();
    }
  }

  // bool specialSkillActivate() {
  //   final specialButton1 = hud.specialButton as LongTapDustyHudButton;
  //   final specialButton2 = hud.special2Button as LongTapDustyHudButton;
  //   // gauge가 눌러진다는것은 장비가 있다는 뜻이다.
  //   // 2개다 gauge가 있으면 안된다.
  //   final special1Gauge = specialButton1.gauge;
  //   final special2Gauge = specialButton2.gauge;
  //   // 2개다 gauge가 있으면 버그다
  //   if (special1Gauge > 0 && special2Gauge > 0) {
  //     // player?.topGaugeBar.hide();
  //     return false;
  //   }
  //   if (special1Gauge == 0 && special2Gauge == 0) {
  //     // player?.topGaugeBar.hide();
  //     return false;
  //   }
  //   // grenade area 인지 tower area 인지 확인
  //   var isGrenadeSkill = false;
  //   var targetButton = special1Gauge > 0 ? specialButton1 : specialButton2;
  //   if (targetButton.equipment == PassiveObjectType.coconut) {
  //     isGrenadeSkill = true;
  //   }
  //   if (isGrenadeSkill) {
  //     if (!grenadeTargetArea.activated) {
  //       grenadeTargetArea.setActivated(true);
  //     }
  //     player?.topGaugeBar.updateValue(targetButton.gauge / 100);
  //     // scale = Vector2(targetButton.gauge / 100, 1);
  //     // player.directionIndex to vector
  //     final direction = Vector2(0, -1)..rotate(playerAngle);
  //     final power = targetButton.gauge * gameConfig!.grenadePowerUnit;
  //     grenadeTargetArea.x = player!.x + direction.x * power;
  //     grenadeTargetArea.y = player!.y + direction.y * power;
  //   } else {
  //     grenadeTargetArea.setActivated(false);
  //     player?.topGaugeBar.hide();

  //     // update towerArea;
  //   }
  //   return true;
  // }

  @override
  void update(double dt) {
    super.update(dt);
    if (player == null) {
      return;
    }
    //먼저 플레이어의 방향을 설정한다.
    if (0 < player!.targetDirectionIndex && player!.targetDirectionIndex < 13) {
      updatePlayerAngle(dt);
      autoRange.position = player!.position;
    }

    // 다음 range & area 도움을 주는 그래픽을 설정한다.
    // var isPunchMode = true;
    // // player hud special press gauge
    // if (hud.specialButton != null && hud.special2Button != null) {
    //   isPunchMode = !specialSkillActivate();
    // }

    // if (!isPunchMode) {
    //   releaseTarget();
    //   return;
    // } else {
    //   // punch mode이기 때문에 관련 help area를 없애준다.
    //   //buildTowerArea
    //   grenadeTargetArea.setActivated(false);
    //   player?.topGaugeBar.hide();
    // }
    if (player?.targetId != null) {
      if (player!.targetId! > 0) {
        lockOnTarget();
      } else {
        releaseTarget();
      }
    }
  }
}
