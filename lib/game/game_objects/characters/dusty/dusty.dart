import 'dart:math';
import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/extensions/sync_animation.dart';
import 'package:dusty_flutter/game/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/body.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/const.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/glasses.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/weapon.dart';
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:dusty_flutter/game/ui/gauge_bar.dart';
import 'package:dusty_flutter/game/ui/name_label.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';

class Dusty extends PositionComponent
    with
        HasGameRef<DustyIslandGame>,
        DIObject,
        MovingObject,
        CastingObject,
        DamagedObject {
  late final DustyGlasses glasses;
  late final DustyBody body;
  late final DustyWeaponEffect weaponEffect;
  late final DustyNameLabel nameLabel;

  final String dustyName;
  final Team team;

  DustyState dustyState = DustyState.normal;

  // sounds
  // 더스티의 state에 해당되는 사운드가 있다.
  AudioPlayer? finishingStateSound;
  // AudioPlayer? shieldSound;
  AudioPlayer? dustyStateSound;
  AudioPlayer? lockOnSound;
  bool isPlayer = false;

  int targetDirectionIndex = 0;

  DustyGlassesType _glassesType = DustyGlassesType.idle;
  DustyGlassesType get glassesType => _glassesType;
  set glassesType(DustyGlassesType type) {
    _glassesType = type;
    updateUIState();
  }

  Dusty(this.dustyName, this.team, int id)
      : super(size: Vector2(36, 36), anchor: Anchor.center) {
    objectId = id;
  }

  @override
  Future<void> onLoad() async {
    priority = Priority.dusty;
    nextPosition = Vector2(x, y);
    direction = Vector2(x, y);
    if (gameRef.playWorld != null) {
      serverDelta = gameRef.playWorld!.serverDelta;
    } else {
      serverDelta = 10;
    }
    DustyBodyType bodyType = DustyBodyType.nature;
    switch (team) {
      case Team.colonists:
        bodyType = DustyBodyType.pollution;
        break;
      case Team.guardians:
        bodyType = DustyBodyType.nature;
        break;
    }

    weaponEffect = DustyWeaponEffect()
      ..x = width * 0.5
      ..y = height * 0.5
      ..anchor = Anchor.center
      ..scale = Vector2(0.5, 0.5);
    glasses = DustyGlasses()..size = size;
    body = DustyBody(bodyType: bodyType)..size = size;
    nameLabel = DustyNameLabel(dustyName);
    hpGaugeBar = HPGaugeBar()..width = width;

    addAll([
      weaponEffect,
      body,
      glasses,
      nameLabel,
      hpGaugeBar,
    ]);
    add(RectangleHitbox());
    await super.onLoad();
    updateUIState();
  }

  @override
  void flipHorizontally() {
    super.flipHorizontally();
    nameLabel.flipHorizontally();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(movement(dt));
    // sound volume update
    if (finishingStateSound?.state == PlayerState.playing) {
      finishingStateSound?.setVolume(getSoundVolume());
    }
    if (dustyStateSound?.state == PlayerState.playing) {
      dustyStateSound?.setVolume(getSoundVolume());
    }
    if (lockOnSound?.state == PlayerState.playing) {
      lockOnSound?.setVolume(getSoundVolume());
    }
  }

  @override
  void moveTo(Vector2 currentPosition, Vector2 moveToPosition) {
    super.moveTo(currentPosition, moveToPosition);
    final nextAngle = (nextPosition - position).screenAngle();
    if (nextAngle != 0) {
      if (nextAngle >= 0 && isFlippedHorizontally) {
        flipHorizontally();
      }
      if (nextAngle < 0 && !isFlippedHorizontally) {
        flipHorizontally();
      }
    }
  }

  @override
  void idle() {
    stop();
  }

  @override
  void updateState(List<StateData> states) {
    super.updateState(states);
    for (var stateData in states) {
      switch (stateData.state) {
        case ObjectState.charging:
          print('charging!!!');
          break;
        default:
          break;
      }
    }
  }

  void stop() {
    speed = 0;
  }

  void updateTargetDirection(int directionIndex) {
    targetDirectionIndex = directionIndex;
  }

  void updateUIState() {
    int? currentIndex = body.animationTicker?.currentIndex;
    if (currentIndex != null) {
      glasses.changeState(DustyGlassesType.idle, currentIndex);
    }
  }

  void hide(bool hide, bool visible) {
    if (!visible) {
      nameLabel.text = '';
    } else {
      nameLabel.text = dustyName;
    }
  }

  void dead() async {
    await finishingStateSound?.stop();
    await dustyStateSound?.stop();
    await lockOnSound?.stop();

    if (isPlayer) {
      DustySoundPool.instance.effectOnPlayerDeath(volume: getSoundVolume());
    } else {
      DustySoundPool.instance.effectOnDeath(volume: getSoundVolume());
    }

    removeFromParent();
  }

  double getDistanceToPlayer() {
    final player = gameRef.playWorld!.player;
    if (player == null) return 0.0;
    return position.distanceTo(player.position);
  }

  double getSoundVolume() {
    if (!gameRef.playWorld!.isSoundOn) return 0.0;
    return min(1 - (getDistanceToPlayer() / gameRef.canvasDiagonal), 1);
  }

  @override
  void removeObject() {
    super.removeObject();
    print('removed');
  }

  @override
  void casting(DIObject? targetObject, int? value) {
    // TODO: implement casting
    // in dusty
    if (value != null) {
      // DustyCastingType castingType = DustyCastingType(value);

      // weaponEffect.angle = targetDirectionIndex * pi * 2 / 16 - pi * 0.5;
      weaponEffect.setOpacity(1);
      weaponEffect.animationTicker?.reset();
      switch (DustyCastingType.parse(value)) {
        case DustyCastingType.verticalAxeSwing:
          weaponEffect.current = DustyWeaponEffectType.axeVerticalSwing;
          break;
        case DustyCastingType.throwStone:
          break;
      }
      weaponEffect.animationTicker?.onComplete = () {
        weaponEffect.add(OpacityEffect.to(
          0,
          LinearEffectController(0.1),
        ));
      };
    }
  }
}
