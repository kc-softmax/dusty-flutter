import 'dart:math';
import 'package:dusty_flutter/arbiter/live_connection/game_event.dart';
import 'package:dusty_flutter/game/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:dusty_flutter/game/game_objects/dusty/body/body.dart';
import 'package:dusty_flutter/game/game_objects/dusty/const.dart';
import 'package:dusty_flutter/game/game_objects/dusty/glasses/glasses.dart';
import 'package:dusty_flutter/game/game_objects/dusty/weapons/weapon.dart';
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
        PickerObject,
        KnockbackedObject,
        DamagedObject {
  late final DustyGlasses glasses;
  late final DustyBody body;
  late final DustyNameLabel nameLabel;
  late final DustyWeapon weapon;

  final String dustyName;
  DustyState dustyState = DustyState.normal;

  // 더스티의 state에 해당되는 사운드가 있다.
  AudioPlayer? finishingStateSound;
  // AudioPlayer? shieldSound;
  AudioPlayer? dustyStateSound;
  AudioPlayer? lockOnSound;
  bool isPlayer = false;

  int targetDirectionIndex = 0;

  Dusty(this.dustyName, int id) : super(anchor: Anchor.center) {
    objectId = id;
  }

  @override
  Future<void> onLoad() async {
    anchor = Anchor.center;
    priority = Priority.dusty;
    nextPosition = Vector2(x, y);
    direction = Vector2(x, y);
    if (gameRef.playWorld != null) {
      serverDelta = gameRef.playWorld!.serverDelta;
    } else {
      serverDelta = 10;
    }

    glasses = DustyGlasses();
    body = DustyBody();
    weapon = DustyWeapon();
    nameLabel = DustyNameLabel(dustyName);
    hpGaugeBar = HorizontalGaugeBar(gaugeColor: GaugeBarColor.red);
    hpGaugeBar.anchor = const Anchor(0.5, 3.5);
    addAll([
      hpGaugeBar,
      weapon,
      body,
      glasses,
      nameLabel,
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
    weapon.updatePosition(body.animationTicker?.currentIndex);
    glasses.updatePosition(body.animationTicker?.currentIndex);
  }

  @override
  void moveTo(Vector2 currentPosition, Vector2 moveToPosition) {
    super.moveTo(currentPosition, moveToPosition);
    if (nextPosition.x - position.x > 0) {
      // right
      if (isFlippedHorizontally) flipHorizontally();
    } else {
      // left
      if (!isFlippedHorizontally) flipHorizontally();
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
          print('charging!!! ${stateData.value}');
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

  void hide(bool hide, bool visible) {
    // if (!visible) {
    //   nameLabel.text = '';
    // } else {
    //   nameLabel.text = dustyName;
    // }
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
  void casting(DIObject? targetObject, int? value) {
    glasses.current = DustyGlassesType.attack;
    Future.delayed(const Duration(milliseconds: 300), () {
      glasses.current = DustyGlassesType.idle;
    });
    weapon.casting(targetObject, value);
  }

  @override
  void getDamaged(double value) {
    super.getDamaged(value);
    glasses.current = DustyGlassesType.damaged;
    Future.delayed(const Duration(milliseconds: 300), () {
      glasses.current = DustyGlassesType.idle;
    });
    final damagedBodyEffect = OpacityEffect.to(
      0.0,
      EffectController(
        duration: 0.1,
        reverseDuration: 0.1,
        infinite: true,
      ),
    );
    body.add(damagedBodyEffect);
    Future.delayed(const Duration(milliseconds: 500), () {
      body.setOpacity(1);
      damagedBodyEffect.removeFromParent();
    });
  }

  @override
  void drop(ItemType item) {
    weapon.dropWeapon(item);
  }

  @override
  void pickup(ItemType item) {
    switch (item) {
      case ItemType.normalAxe:
        weapon.setWeapon(item);
        break;
      default:
        break;
    }
  }

  @override
  void knockbacked(DIObject? targetObject, int? value) {
    // TODO: implement knockbacked
    if (value == null) return;
    // 방향전환 막아야 한다.
  }
}
