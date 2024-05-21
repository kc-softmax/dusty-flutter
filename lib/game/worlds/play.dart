import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/cameras/camera.dart';
import 'package:dusty_flutter/game/game_objects/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/game/game_objects/dusty/dusty.dart';
import 'package:dusty_flutter/game/game_objects/dusty/dusty_factory.dart';
import 'package:dusty_flutter/game/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/game_objects/passive_objects/passive_objects_factory.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';

class PlaySceneWorld extends World with HasGameRef<DustyIslandGame> {
  GameInfo gameinfo;
  TiledComponent gameMap;
  Dusty? player;
  double serverDelta = 0;
  double playerAngle = 0; // radians

  final dustyFactory = DustyFactory();
  final activeObjectsFactory = ActiveObjectsFactory();
  final passiveObjectsFactory = PassiveObjectsFactory();

  late final int? followerId;
  // late final SpriteComponent autoRange;

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

  PlaySceneWorld({required this.gameinfo, required this.gameMap}) {
    serverDelta = 1 / gameinfo.frameRate;
  }

  @override
  FutureOr<void> onLoad() async {
    print('Play World onLoad!!');
    addAll([
      gameMap,
      // autoRange =
      //     SpriteComponent(sprite: gameRef.atlas.findSpriteByName('auto_range'))
      //       ..anchor = Anchor.center
      //       ..opacity = 0,
      // tileFactory,
      dustyFactory,
      activeObjectsFactory,
      passiveObjectsFactory,
    ]);
    // 카메라 셋팅
    gameRef.camera = DICamera(
      gameMap: gameMap,
      gameInfo: gameinfo,
      width: gameMap.width,
      height: gameMap.height,
    );
    gameRef.gameCamera.setHud();
  }

  @override
  void onMount() {
    super.onMount();
    gameRef.focusNode?.requestFocus();
  }

  void handleGameEvent(GameEvent gameEvent) {
    // if (gameEvent.system != null) {
    //   gameRef.gameCamera.hud.updateSystemEvent(gameEvent.system!);
    //   if (gameEvent.system?.isEnd ?? false) {
    //     gameRef.disconnectGame();
    //   }
    // }
    // if (gameEvent.sys)

    if (gameEvent.dusties != null) {
      dustyFactory.addEvents(gameEvent.dusties!);
    }
    if (gameEvent.activeObjects != null) {
      activeObjectsFactory.addEvents(gameEvent.activeObjects!);
    }
    if (gameEvent.passiveObjects != null) {
      passiveObjectsFactory.addEvents(gameEvent.passiveObjects!);
    }
  }

  void updatePlayerAngle(double dt) {
    var targetAngle = player!.targetDirectionIndex * pi * 2 / 16;
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
    // autoRange.angle = playerAngle;
    // player?.throwIndicator.angle = playerAngle - pi * 0.5;

    playerAngle %= pi * 2;
    // player angle 이 12시 방향 근처에 있을때는 방향 전환을 하지 않는다.
    // player angle 이 6시 방향 근처에 있을때는 방향 전환을 하지 않는다.
    // if (playerAngle < pi * 17 / 16 && playerAngle > pi * 15 / 16) {
    //   return;
    // } else if (playerAngle < pi / 16 || playerAngle > pi * 31 / 16) {
    //   return;
    // } else if (playerAngle < pi && player!.isFlippedHorizontally) {
    //   player!.flipHorizontally();
    // } else if (playerAngle > pi && !player!.isFlippedHorizontally) {
    //   player!.flipHorizontally();
    // }
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
      // autoRange.position = player!.position;
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
    // if (player?.targetId != null) {
    //   if (player!.targetId! > 0) {
    //     lockOnTarget();
    //   } else {
    //     releaseTarget();
    //   }
    // }
  }
}

class SnapshotComponent extends PositionComponent with Snapshot {}
