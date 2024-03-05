import 'dart:ui';

import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Bush extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, CollisionCallbacks, PassiveObjects {
  PassiveObjectType objectType;

  Bush({required this.objectType}) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    var spriteName = '';
    switch (objectType) {
      case PassiveObjectType.bush4X4:
        spriteName = 'bush_4x4';
        break;
      case PassiveObjectType.bush8X4:
        spriteName = 'bush_8x4';
        break;
      default:
        break;
    }
    final spriteList = gameRef.atlas.findSpritesByName(spriteName);
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // gameRef.playScene.activeObjectsFactory.objects.forEach((key, value) {});
    gameRef.playScene.passiveObjectsFactory.objects.forEach((key, value) {
      if (value is Bush) return;
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

    // gameRef.playScene.dustyFactory.objects.forEach((key, value) {
    //   // how to find the object is intersected with the tree of life
    //   if (toRect().containsPoint(value.center)) {
    //     if (value.priority == Priority.environmentIntersected) return;
    //     value.overLabObject = this;
    //     value.priority = Priority.environmentIntersected;
    //     value.opacity = 0.5;
    //   } else {
    //     if (value.overLabObject != null && value.overLabObject == this) {
    //       value.overLabObject = null;
    //       value.opacity = 1;
    //       value.priority = Priority.normal;
    //     }
    //   }
    // });
    //
  }
}
