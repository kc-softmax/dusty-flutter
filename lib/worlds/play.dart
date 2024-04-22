import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:dusty_flutter/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/arbiter/live_service/system_message.dart';
import 'package:dusty_flutter/camera.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/characters/dusty_factory.dart';
import 'package:dusty_flutter/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/tiles/tile_factory.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';

class PlaySceneWorld extends World with HasGameRef<DustyIslandGame> {
  static int? playerId;
  static Team? selectedTeam;
  static TiledComponent? selectedMap;

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
  late final SpriteComponent autoRange;

  bool _isSoundOn = false;
  bool get isSoundOn => _isSoundOn;

  set isSoundOn(bool isSoundOn) {
    if (!isSoundOn) {
      FlameAudio.bgm.audioPlayer.stop();
    } else {
      DustySoundPool.instance.bgmOnGamePlaying();
    }
    _isSoundOn = isSoundOn;
  }

  final Future<void> Function() onReadyGame;

  PlaySceneWorld({required this.onReadyGame});

  @override
  FutureOr<void> onLoad() async {
    assert(playerId != null && selectedTeam != null && selectedMap != null);

    // 카메라 셋팅
    gameRef.camera = DICamera(
      width: PlaySceneWorld.selectedMap!.width,
      height: PlaySceneWorld.selectedMap!.height,
    );

    final snapshot = SnapshotComponent();
    add(snapshot);
    snapshot.add(selectedMap!);

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

    await onReadyGame();
  }

  @override
  void onMount() {
    super.onMount();
    gameRef.focusNode?.requestFocus();
  }

  void handleGameMessage(GameMessage gameMessage) {
    if (gameMessage.gameConfig != null) {
      gameConfig = gameMessage.gameConfig!;
      serverDelta = 1 / gameMessage.gameConfig!.frameRate;
      followerId = gameConfig?.playerId;
      gameRef.gameCamera.setHud(gameConfig!);
    }

    if (gameMessage.system != null) {
      gameRef.gameCamera.hud.updateSystemMessage(gameMessage.system!);
      if (gameMessage.system?.isEnd ?? false) {
        gameRef.disconnectGame();
      }
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

class SnapshotComponent extends PositionComponent with Snapshot {}
