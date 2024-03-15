import 'dart:ui';

import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Tree extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, CollisionCallbacks, PassiveObjects {
  List<Dusty> hidingDusty = [];
  List<PassiveObjects> hidingObjects = [];

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('tree');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
    // add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // gameRef.playScene.activeObjectsFactory.objects.forEach((key, value) {});
    gameRef.playScene.passiveObjectsFactory.objects.forEach((key, value) {
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

    gameRef.playScene.dustyFactory.objects.forEach((key, value) {
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
