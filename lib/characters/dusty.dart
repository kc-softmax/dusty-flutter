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
import 'package:dusty_flutter/ui/grenade_circle.dart';
import 'package:dusty_flutter/ui/name_label.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/characters/const.dart';
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
  late final SpriteAnimationComponent shieldEffect;
  late final HorizontalGaugeBar topGaugeBar;
  late final VerticalGaugeBar rightGaugeBar;
  late final SpriteAnimationComponent aim;
  late final SpriteComponent autoTargetRange;
  late final GrenadeCircle grenadeCircle;
  final String dustyName;
  final Team team;

  PassiveObjects? overLabObject;
  Vector2? nextPosition;
  int throwingPower = 0;
  int? targetId;
  int? lockOnId;
  DustyState dustyState = DustyState.normal;
  double speed = 0;
  int hasShield = 0;
  int _isFinishing = 0;

  // sounds
  // 더스티의 state에 해당되는 사운드가 있다.
  AudioPlayer? finishingStateSound;
  AudioPlayer? shieldSound;
  AudioPlayer? dustyStateSound;
  AudioPlayer? lockOnSound;
  bool _isPlayer = true;
  bool get isPlayer => _isPlayer;
  set isPlayer(bool value) {
    _isPlayer = value;
    // autoTargetRange.setOpacity(isPlayer ? 0.75 : 0);
    autoTargetRange.setOpacity(0);
  }

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
    priority = Priority.normal;

    grenadeCircle = GrenadeCircle()
      ..size = size
      ..x = x
      ..y = y;

    shieldEffect = SpriteAnimationComponent(
        animation: SpriteAnimation.spriteList(
      gameRef.atlas.findSpritesByName('shield'),
      stepTime: 0.05,
    ))
      ..opacity = 0
      ..size = size * 1.3
      ..x = -5
      ..y = -5;
    shieldEffect.animationTicker?.paused = true;
    aim = SpriteAnimationComponent(
        animation: SpriteAnimation.spriteList(
      gameRef.atlas.findSpritesByName('aim'),
      stepTime: 0.05,
    ))
      ..size = size
      ..opacity = 0
      ..y = 4;

    autoTargetRange =
        SpriteComponent(sprite: gameRef.atlas.findSpriteByName('auto_range'))
          ..scale = Vector2.all(0.5)
          ..opacity = 0;
    autoTargetRange.flipHorizontally();
    autoTargetRange.x = autoTargetRange.size.x / 2;
    autoTargetRange.y = -height;

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
    topGaugeBar = HorizontalGaugeBar()
      ..size = Vector2(48, 10)
      ..position = Vector2(0, -10);

    rightGaugeBar = VerticalGaugeBar()
      ..size = Vector2(10, 48)
      ..position = Vector2(-5, 48)
      ..angle = pi;
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

    addAll([
      // grenadeCircle,
      autoTargetRange,
      glasses,
      bodyEffect,
      shieldEffect,
      nameLabel,
      topGaugeBar,
      rightGaugeBar,
      aim
    ]);
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
    // nextposition이 있으면 이동
    if (speed < 1) {
      return;
    }
    if (nextPosition != null) {
      final remainingDistance = (nextPosition! - position).length;
      final toMoveDirection =
          Vector2(nextPosition!.x - x, nextPosition!.y - y).normalized();
      if (remainingDistance < 1 || remainingDistance > 32) {
        // 혹은 너무 멀리 떨어저 있다면 32픽셀 이상?
        // print('force set position');
        position.setFrom(nextPosition!);
        return;
      }
      double currentSpeed = speed * remainingDistance / 180;
      if (remainingDistance > speed * 0.2) {}
      currentSpeed = speed;
      //일정 거리 이하로 가면 멈춤 # 멈추지 않아야
      position.add(toMoveDirection * currentSpeed * dt);

      if (toMoveDirection.screenAngle() >= 0 && isFlippedHorizontally) {
        flipHorizontally();
      }
      if (toMoveDirection.screenAngle() < 0 && !isFlippedHorizontally) {
        flipHorizontally();
      }
    }
  }

  // @override
  // void render(Canvas canvas) {
  //     super.render(canvas);
  //   if(isPlayer) {

  //   }
  //     // final rect =
  //     //     Rect.fromLTWH(-width * 0.5, height * 0.33, width * 2, height);

  //     // canvas.drawOval(rect, aquireBgPaint);

  //     // const startAngle = -math.pi / 2;
  //     // final sweepAngle = math.pi * 2 * aquireProgress;
  //     // canvas.drawArc(rect, startAngle, sweepAngle, true, aquirePaint);
  //   }
  // }

  void updateSpeed() {
    if (gameRef.playScene.gameConfig != null) {
      final remainingDistance = (nextPosition! - position).length;
      if (remainingDistance < 1) {
        speed = 0;
      } else {
        speed = remainingDistance * gameRef.playScene.gameConfig!.frameRate;
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
      topGaugeBar.setOpacity(1);
      topGaugeBar.decreaseWithDuration(
          gameRef.playScene.gameConfig!.finishDuration.toDouble(), boostColor);
    } else {
      bodyEffectType = DustyBodyEffectType.none;
      topGaugeBar.setOpacity(0);
      finishingStateSound?.stop();
    }
  }

  void setDustyShield(int shield) {
    if (hasShield == shield) {
      return;
    }
    if (shield > 0) {
      shieldEffect.setOpacity(1);
      shieldEffect.animationTicker?.paused = false;
      rightGaugeBar.setOpacity(1);
      rightGaugeBar.decreaseWithDuration(
          gameRef.playScene.gameConfig!.shieldDuration.toDouble(), shieldColor);
      DustySoundPool.instance
          .loopOnBoost()
          .then((sound) => shieldSound = sound);
    } else {
      shieldEffect.setOpacity(0);
      shieldEffect.animationTicker?.paused = true;
      rightGaugeBar.setOpacity(0);
      shieldSound?.stop();
    }
    hasShield = shield;
    updateUIState();
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
    topGaugeBar.setOpacity(hide ? hideValue : 1);
    rightGaugeBar.setOpacity(hide ? hideValue : 1);
    if (!visible) {
      nameLabel.text = '';
    } else {
      nameLabel.text = dustyName;
    }
    if (hasShield > 0) {
      shieldEffect.setOpacity(hide ? hideValue : 1);
    }
  }

  void dead() {
    removeFromParent();
    if (isPlayer) {
      DustySoundPool.instance.effectOnPlayerDeath();
    } else {
      DustySoundPool.instance.effectOnDeath();
    }
  }
}
