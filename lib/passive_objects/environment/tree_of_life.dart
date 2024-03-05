import 'dart:ui';

import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class TreeOfLife extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, CollisionCallbacks, PassiveObjects {
  TreeOfLife() : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('tree_of_life');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    gameRef.playScene.activeObjectsFactory.objects.forEach((key, value) {});
    gameRef.playScene.passiveObjectsFactory.objects.forEach((key, value) {
      if (value is TreeOfLife) return;
      if (value.toRect().overlaps(toRect())) {
        if (value.priority == Priority.environmentIntersected) return;
        value.opacity = 0.5;
        value.priority = Priority.environmentIntersected;
      } else {
        if (value.priority == Priority.environmentIntersected) {
          value.opacity = 1;
          value.priority = Priority.normal;
        }
      }
    });

    gameRef.playScene.dustyFactory.objects.forEach((key, value) {
      // how to find the object is intersected with the tree of life
      if (value.toRect().overlaps(toRect())) {
        if (value.priority == Priority.environmentIntersected) return;
        value.opacity = 0.5;
        value.priority = Priority.environmentIntersected;
      } else {
        if (value.priority == Priority.environmentIntersected) {
          value.opacity = 1;
          value.priority = Priority.normal;
        }
      }
    });
    //
  }
}
