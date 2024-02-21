import 'dart:math';
import 'dart:ui';

import 'package:dusty_flutter/extensions/sync_animation.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:dusty_flutter/ui/gauge_bar.dart';
import 'package:dusty_flutter/ui/name_label.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/characters/const.dart';

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
      DustyBodyEffectType.shield: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('shield'),
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
  late final HorizontalGaugeBar topGaugeBar;
  late final VerticalGaugeBar rightGaugeBar;

  final String dustyName;

  DustyState dustyState = DustyState.normal;
  Vector2? nextPosition;
  double speed = 0;

  DustyBodyType _bodyType = DustyBodyType.red;
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
      case DustyBodyEffectType.shield:
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

  Dusty(this.dustyName) : super(size: Vector2(48, 48), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animations = {
      DustyBodyType.red: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('red_body'),
        stepTime: 0.05,
      ),
      DustyBodyType.blue: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('blue_body'),
        stepTime: 0.05,
      ),
    };
    current = DustyBodyType.red;
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

    addAll([glasses, bodyEffect, nameLabel, topGaugeBar, rightGaugeBar]);
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
      final toMoveDirection = (nextPosition! - position).normalized();
      if (remainingDistance < 1) {
        position.setFrom(nextPosition!);
        return;
      }
      double currentSpeed = speed * remainingDistance / 180;
      if (remainingDistance > speed * 0.2) {}
      currentSpeed = speed;
      //일정 거리 이하로 가면 멈춤
      position.add(toMoveDirection * currentSpeed * dt);
      if (toMoveDirection.screenAngle() >= 0 && isFlippedHorizontally) {
        flipHorizontally();
      }
      if (toMoveDirection.screenAngle() < 0 && !isFlippedHorizontally) {
        flipHorizontally();
      }
    }
  }

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

  @override
  void flipHorizontally() {
    super.flipHorizontally();
    nameLabel.flipHorizontally();
  }

  void updateDustyState(DustyState newState) {
    if (newState == dustyState) {
      return;
    }
    switch (newState) {
      case DustyState.boost:
        glassesType = DustyGlassesType.boost;
<<<<<<< Updated upstream
        topGaugeBar.decreaseWithDuration(
            gameRef.playScene.gameConfig!.boostSkillReloadTime.toDouble(),
=======
        rightGaugeBar.decreaseWithDuration(
            gameRef.playScene.gameConfig!.boostSkillReloadTime as double,
>>>>>>> Stashed changes
            boostColor);
        break;
      case DustyState.shield:
        bodyEffectType = DustyBodyEffectType.shield;
        rightGaugeBar.decreaseWithDuration(
            gameRef.playScene.gameConfig!.shieldSkillReloadTime.toDouble(),
            shieldColor);
        break;
      case DustyState.normal:
        glassesType = DustyGlassesType.idle;
        bodyEffectType = DustyBodyEffectType.none;
        break;
      default:
        break;
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
}
