import 'dart:math';

import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
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
  final String dustyName;
  final Team team;

  Vector2? nextPosition;
  int? targetId;
  int? lockOnId;
  DustyState dustyState = DustyState.normal;
  double speed = 0;
  int hasShield = 0;
  bool isPlayer = false;
  int _isFinishing = 0;

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
      : super(size: Vector2(42, 42), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    priority = 5;
    shieldEffect = SpriteAnimationComponent(
        animation: SpriteAnimation.spriteList(
      gameRef.atlas.findSpritesByName('shield'),
      stepTime: 0.05,
    ))
      ..opacity = 0
      ..size = size * 1.3
      ..x = -7
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
      glasses,
      bodyEffect,
      shieldEffect,
      nameLabel,
      topGaugeBar,
      rightGaugeBar,
      aim
    ]);
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
      final toMoveDirection = (nextPosition! - position).normalized();
      if (remainingDistance < 1) {
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

  void setAim(bool lock) {
    if (lock) {
      aim.opacity = 1;
    } else {
      aim.opacity = 0;
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
          break;
        case FinishType.lightning:
          bodyEffectType = DustyBodyEffectType.electricShock;
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
    }
  }

  void setDustyShield(int shield) {
    if (hasShield == shield) {
      return;
    }
    if (shield > 0) {
      shieldEffect.setOpacity(1);
      rightGaugeBar.setOpacity(1);
      rightGaugeBar.decreaseWithDuration(
          gameRef.playScene.gameConfig!.shieldDuration.toDouble(), shieldColor);
    } else {
      shieldEffect.setOpacity(0);
      rightGaugeBar.setOpacity(0);
    }
    hasShield = shield;
    updateUIState();
  }

  void updateDustyState(DustyState newState) {
    if (newState == dustyState) {
      return;
    }
    switch (newState) {
      case DustyState.boost:
        glassesType = DustyGlassesType.boost;
        rightGaugeBar.decreaseWithDuration(
            gameRef.playScene.gameConfig!.boostDuration.toDouble(), boostColor);
        break;
      case DustyState.normal:
        glassesType = DustyGlassesType.idle;
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

  void dead() {
    removeFromParent();
  }
}
