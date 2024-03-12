import 'dart:math';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/effects/ui/const.dart';
import 'package:dusty_flutter/effects/ui/default_explosion.dart';
import 'package:dusty_flutter/extensions/sync_animation.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:dusty_flutter/ui/gauge_bar.dart';
import 'package:dusty_flutter/ui/name_label.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/characters/const.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';

class DustyBodyEffect extends SpriteAnimationGroupComponent<DustyBodyEffectType>
    with HasGameRef<DustyIslandGame>, CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animations = {
      DustyBodyEffectType.electricShock: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('electric_shock'),
        stepTime: 0.05,
      ),
      DustyBodyEffectType.fire: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('electric_shock'),
        stepTime: 0.05,
      ),
    };
  }
}

class DustyGlasses extends SpriteAnimationGroupComponent<DustyGlassesType>
    with HasGameRef<DustyIslandGame>, CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animations = {
      DustyGlassesType.idle: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('type_a'),
        stepTime: 0.05,
      ),
      DustyGlassesType.boost: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('type_a_boost'),
        stepTime: 0.05,
      ),
    };
    current = DustyGlassesType.idle;
  }
}

class Dusty extends SpriteAnimationGroupComponent<DustyBodyType>
    with HasGameRef<DustyIslandGame> {
  late final DustyGlasses glasses;
  late final DustyBodyEffect bodyEffect;
  late final DustyNameLabel nameLabel;
  late final OpacityEffect shieldEffect;
  // late final GaugeBar topGaugeBar;
  late final GaugeBar rightGaugeBar;
  late final SpriteAnimationComponent aim;
  late Vector2 lastPosition;
  final String dustyName;
  final Team team;

  PassiveObjects? overLabObject;
  late Vector2 _nextPosition;
  int throwingPower = 0;
  int? targetId;
  int? lockOnId;
  DustyState dustyState = DustyState.normal;
  double speed = 0;
  double timeSinceLastUpdate = 0;
  int hasShield = 0;
  int _isFinishing = 0;

  // sounds
  // 더스티의 state에 해당되는 사운드가 있다.
  AudioPlayer? finishingStateSound;
  // AudioPlayer? shieldSound;
  AudioPlayer? dustyStateSound;
  AudioPlayer? lockOnSound;
  bool isPlayer = false;

  int targetDirectionIndex = 0;
  int directionIndex = 0;
  double lastMoveAngle = 0;

  DustyBodyType _bodyType = DustyBodyType.yellow;
  DustyBodyType get bodyType => _bodyType;
  set bodyType(DustyBodyType type) {
    _bodyType = type;
    updateUIState();
  }

  DustyBodyEffectType _bodyEffectType = DustyBodyEffectType.none;
  DustyBodyEffectType get bodyEffectType => _bodyEffectType;
  set bodyEffectType(DustyBodyEffectType type) {
    switch (type) {
      case DustyBodyEffectType.electricShock:
        bodyEffect.position.x = -5;
        bodyEffect.position.y = -5;
        break;
      case DustyBodyEffectType.fire:
        bodyEffect.position.x = -7;
        bodyEffect.position.y = -10;
        break;
      default:
        bodyEffect.position.x = 0;
        bodyEffect.position.y = 0;
        break;
    }
    _bodyEffectType = type;
    updateUIState();
  }

  DustyGlassesType _glassesType = DustyGlassesType.idle;
  DustyGlassesType get glassesType => _glassesType;
  set glassesType(DustyGlassesType type) {
    _glassesType = type;
    updateUIState();
  }

  Dusty(this.dustyName, this.team)
      : super(size: Vector2(36, 36), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    priority = Priority.dusty;
    lastPosition = position;
    _nextPosition = position;
    // shieldEffect = SpriteAnimationComponent(
    //     animation: SpriteAnimation.spriteList(
    //   gameRef.atlas.findSpritesByName('shield'),
    //   stepTime: 0.05,
    // ))
    //   ..opacity = 0
    //   ..size = size * 1.3
    //   ..x = -5
    //   ..y = -5;
    // shieldEffect.animationTicker?.paused = true;
    aim = SpriteAnimationComponent(
        animation: SpriteAnimation.spriteList(
      gameRef.atlas.findSpritesByName('aim'),
      stepTime: 0.05,
    ))
      ..size = size
      ..opacity = 0
      ..y = 4;

    animations = {
      DustyBodyType.red: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('red_body'),
        stepTime: 0.05,
      ),
      DustyBodyType.blue: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('blue_body'),
        stepTime: 0.05,
      ),
      DustyBodyType.sea: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('sea_body'),
        stepTime: 0.05,
      ),
      DustyBodyType.green: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('green_body'),
        stepTime: 0.05,
      ),
      DustyBodyType.deepGreen: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('deep_green_body'),
        stepTime: 0.05,
      ),
      DustyBodyType.yellow: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('yellow_body'),
        stepTime: 0.05,
      ),
    };
    glasses = DustyGlasses()..size = size;
    bodyEffect = DustyBodyEffect()..size = size * 1.3;
    nameLabel = DustyNameLabel(dustyName);
    // topGaugeBar = GaugeBar()
    //   ..size = Vector2(36, 10)
    //   ..position = Vector2(0, -10);

    rightGaugeBar = GaugeBar()
      ..size = Vector2(36, 10)
      ..position = Vector2(0, 0)
      ..angle = pi / 2;
    switch (team) {
      case Team.alpha:
        bodyType = DustyBodyType.yellow;
        break;
      case Team.beta:
        bodyType = DustyBodyType.sea;
        break;
      default:
        bodyType = DustyBodyType.red;
        break;
    }
    shieldEffect = OpacityEffect.to(
        0.2, EffectController(duration: 0.3, infinite: true, alternate: true));
    shieldEffect.pause();
    addAll([glasses, bodyEffect, shieldEffect, nameLabel, rightGaugeBar, aim]);
    add(RectangleHitbox());
    await super.onLoad();
  }

  @override
  void flipHorizontally() {
    super.flipHorizontally();
    nameLabel.flipHorizontally();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // sound volume update
    finishingStateSound?.setVolume(getSoundVolume());
    dustyStateSound?.setVolume(getSoundVolume());
    lockOnSound?.setVolume(getSoundVolume());

    // nextposition이 있으면 이동
    if (speed < 1) {
      return;
    }

    final toMoveDirection =
        Vector2(_nextPosition.x - x, _nextPosition.y - y).normalized();

    //일정 거리 이하로 가면 멈춤 # 멈추지 않아야
    position.add(toMoveDirection * speed * dt / gameRef.playScene.serverDelta);

    lastMoveAngle = toMoveDirection.screenAngle();
  }

  @override
  void remove(Component component) {
    finishingStateSound?.stop();
    dustyStateSound?.stop();
    lockOnSound?.stop();
  }

  void updateTargetDirection(int directionIndex) {
    targetDirectionIndex = directionIndex;
  }

  void updateNextPosition(Vector2 nextPosition) {
    if (gameRef.playScene.gameConfig != null) {
      _nextPosition = nextPosition; // 새로운 목표 위치 설정
      timeSinceLastUpdate = 0; // 타이머 리셋
      final remainingDistance = (nextPosition - position).length;
      if (remainingDistance < 1) {
        speed = 0;
      } else {
        speed = remainingDistance; // server speed per tick
      }
    }
  }

  void setAim(bool lock) async {
    if (lock) {
      aim.opacity = 1;
      if (!isPlayer) {
        // 락온 사운드는 루프와 동시에 단발성이기도 함.
        // 락온이 유지되고 있는 동안 사운드가 재생되어야 하고, 락온이 풀리면 스탑.
        // 다른 사운드들과 같이 콜백으로 AudioPlayer를 받으면
        // 순식간에 락온이 풀리는 경우, 스탑을 실행해야할 때 lockOnSound가 null일 수 있다.
        // 그것을 방지하기 위해 await 사용.
        lockOnSound = await DustySoundPool.instance.loopOnLockOn();
      }
    } else {
      aim.opacity = 0;
      if (!isPlayer) {
        lockOnSound?.stop();
      }
    }
  }

  void setFinishState(int isFinishing, FinishType finishType) {
    if (_isFinishing == isFinishing) {
      return;
    }
    _isFinishing = isFinishing;
    if (isFinishing > 0) {
      switch (finishType) {
        case FinishType.fire:
          bodyEffectType = DustyBodyEffectType.fire;
          DustySoundPool.instance
              .loopOnFinishingFire()
              .then((sound) => finishingStateSound = sound);
          break;
        case FinishType.lightning:
          bodyEffectType = DustyBodyEffectType.electricShock;
          DustySoundPool.instance
              .loopOnFinishingLightning()
              .then((sound) => finishingStateSound = sound);
          break;
        default:
          break;
      }
      // topGaugeBar.setOpacity(1);
      // topGaugeBar.decreaseWithDuration(
      //     gameRef.playScene.gameConfig!.finishDuration.toDouble(), boostColor);
    } else {
      bodyEffectType = DustyBodyEffectType.none;
      // topGaugeBar.setOpacity(0);
      finishingStateSound?.stop();
    }
  }

  void setDustyShield(int shield) {
    if (hasShield == shield) {
      return;
    }

    if (shield > 0) {
      shieldEffect.resume();

      //   shieldEffect.setOpacity(1);
      //   shieldEffect.animationTicker?.paused = false;
      //   DustySoundPool.instance
      //       .loopOnBoost()
      //       .then((sound) => shieldSound = sound);
    } else {
      shieldEffect.pause();
      setOpacity(1);

      //   shieldEffect.setOpacity(0);
      //   shieldEffect.animationTicker?.paused = true;
      //   shieldSound?.stop();
    }
    hasShield = shield;
  }

  void updateDustyState(DustyState newState, int visible) {
    if (newState == dustyState) {
      if (opacity == 0 && visible > 0) {
        // 원래 안보이다가 이제는 보여야 한다.
      } else if (opacity > 0 && visible == 0) {
        // 이제는 안보여야 한다.
      } else {
        return;
      }
    }

    switch (newState) {
      case DustyState.invincible:
        gameRef.world.add(DefaultExplosion(DefaultExplosionType.blue)
          ..x = x
          ..y = y
          ..size = size);
        hide(true, visible > 0);
        DustySoundPool.instance
            .loopOnBoost()
            .then((value) => dustyStateSound = value);
        break;
      case DustyState.invisible:
        hide(true, visible > 0);
        break;
      case DustyState.normal:
        glassesType = DustyGlassesType.idle;
        dustyStateSound?.stop();
        break;
      default:
        break;
    }
    if (dustyState != DustyState.normal && newState == DustyState.normal) {
      if (dustyState == DustyState.invincible) {
        gameRef.world.add(DefaultExplosion(DefaultExplosionType.blue)
          ..x = x
          ..y = y
          ..size = size);
      }
      hide(false, true);
    }
    dustyState = newState;
  }

  void updateUIState() {
    // using animation sync
    int? currentIndex = animationTickers?[bodyType]?.currentIndex;
    glasses.changeState(glassesType, currentIndex);
    if (bodyEffectType != DustyBodyEffectType.none) {
      bodyEffect.animationTicker?.paused = false;
      bodyEffect.changeState(bodyEffectType, currentIndex);
      bodyEffect.setOpacity(1);
    } else {
      bodyEffect.animationTicker?.paused = true;
      bodyEffect.setOpacity(0);
    }
    changeState(bodyType, currentIndex);
  }

  void hide(bool hide, bool visible) {
    final hideValue = visible ? 0.5 : 0.0;
    setOpacity(hide ? hideValue : 1);
    bodyEffect.setOpacity(hide ? hideValue : 1);
    glasses.setOpacity(hide ? hideValue : 1);

    // topGaugeBar.hide();
    rightGaugeBar.hide();
    if (!visible) {
      nameLabel.text = '';
    } else {
      nameLabel.text = dustyName;
    }
  }

  void dead() {
    removeFromParent();
    if (isPlayer) {
      DustySoundPool.instance.effectOnPlayerDeath(volume: getSoundVolume());
    } else {
      DustySoundPool.instance.effectOnDeath(volume: getSoundVolume());
    }
  }

  double getDistanceToPlayer() {
    final player = gameRef.playScene.player;
    if (player == null) return 0.0;
    return position.distanceTo(player.position);
  }

  double getSoundVolume() {
    return min(1 - (getDistanceToPlayer() / gameRef.canvasDiagonal), 1);
  }
}
