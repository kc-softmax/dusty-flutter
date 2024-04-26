import 'dart:ui';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Bush extends SpriteComponent
    with
        HasGameRef<DustyIslandGame>,
        CollisionCallbacks,
        PassiveObjects,
        Snapshot {
  Bush() : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    var spriteName = '';
    switch (objectType) {
      case PassiveObjectType.bush4X4:
        spriteName = 'bush_4x4';
        break;
      case PassiveObjectType.bush:
        spriteName = 'bush';
        break;
      default:
        break;
    }
    sprite = gameRef.atlas.findSpriteByName(spriteName);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    gameRef.playWorld!.passiveObjectsFactory.objects.forEach((key, value) {
      if (value is Bush) return;
      if (value.toRect().overlaps(toRect())) {
        if (value.priority == Priority.environmentIntersected) return;
        opacity = 0.5;
        priority = Priority.environmentIntersected;
      } else {
        if (value.priority == Priority.environmentIntersected) {
          opacity = 1;
          priority = Priority.normal;
        }
      }
    });
  }
}
