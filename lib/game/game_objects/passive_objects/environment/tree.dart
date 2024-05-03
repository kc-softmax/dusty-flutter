import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/dusty.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/game_objects/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:dusty_flutter/game/ui/gauge_bar.dart';
import 'package:dusty_flutter/mixins/object_mixin.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_noise/flame_noise.dart';
import 'package:flame/extensions.dart';

class Tree extends SpriteAnimationComponent
    with
        HasGameRef<DustyIslandGame>,
        CollisionCallbacks,
        DIObject,
        PassiveObjects,
        HpObject {
  List<Dusty> hidingDusty = [];
  List<PassiveObjects> hidingObjects = [];

  Tree();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final treeName =
        objectType == PassiveObjectType.tree ? 'tree' : 'winter_tree';
    final spriteList = gameRef.atlas.findSpritesByName(treeName);
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
    hpGaugeBar = HPGaugeBar()
      ..width = width * 0.5
      ..x = width * 0.25
      ..y = width * 0.25;
    add(hpGaugeBar);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    gameRef.playWorld!.passiveObjectsFactory.objects.forEach((key, value) {
      if (value is Tree) return;
      // if treeh
      if (value.toRect().overlaps(toRect())) {
        if (!hidingObjects.contains(value)) {
          hidingObjects.add(value);
        }
      } else {
        if (hidingObjects.contains(value)) {
          hidingObjects.remove(value);
        }
      }
    });

    gameRef.playWorld!.dustyFactory.objects.forEach((key, value) {
      // how to find the object is intersected with the tree of life
      if (toRect().containsPoint(value.center)) {
        // if (value.toRect().overlaps(toRect())) {
        if (value.priority == Priority.environmentIntersected) return;
        hidingDusty.add(value);
        value.opacity = 0.5;
        value.priority = Priority.environmentIntersected;
        for (var object in hidingObjects) {
          object.priority = Priority.environmentIntersected;
        }
      } else {
        if (hidingDusty.contains(value) &&
            value.priority == Priority.environmentIntersected) {
          value.opacity = 1;
          value.priority = Priority.normal;
          for (var object in hidingObjects) {
            object.priority = Priority.normal;
          }

          hidingDusty.remove(value);
        }
      }
    });
    //
  }

  @override
  void getDamaged(double value) {
    super.getDamaged(value);
    add(SequenceEffect(
      [
        MoveEffect.by(
          Vector2(-10, 10),
          NoiseEffectController(duration: 1, noise: PerlinNoise(frequency: 20)),
        ),
        MoveEffect.by(Vector2.zero(), LinearEffectController(2)),
      ],
      repeatCount: 3,
    ));
  }

  @override
  void idle() {}

  // @override
  // void onCollisionStart(
  //   Set<Vector2> intersectionPoints,
  //   PositionComponent other,
  // ) {
  //   // if (other is! Dusty) return;
  //   print(other);
  //   // if (other.team == Team.alpha) return;
  //   // // renderSnapshot = true;
  //   // aquireTimer.start();
  //   super.onCollisionStart(intersectionPoints, other);
  // }

  // @override
  // void onCollisionEnd(PositionComponent other) {
  //   super.onCollisionEnd(other);
  //   print('end');
  //   print(other);

  //   if (!isColliding) {
  //     // renderSnapshot = false;
  //     // aquireTimer.stop();
  //     // aquireProgress = 0;
  //   }
  // }
}
