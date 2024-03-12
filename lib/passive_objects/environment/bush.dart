import 'dart:ui';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Bush extends PositionComponent
    with HasGameRef<DustyIslandGame>, CollisionCallbacks, PassiveObjects {
  PassiveObjectType objectType;

  late SpriteComponent bushSprites;

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
    bushSprites =
        SpriteComponent(sprite: gameRef.atlas.findSpriteByName(spriteName));
    add(bushSprites);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    gameRef.playScene.passiveObjectsFactory.objects.forEach((key, value) {
      if (value is Bush) return;
      if (value.toRect().overlaps(toRect())) {
        if (value.priority == Priority.environmentIntersected) return;
        bushSprites.opacity = 0.5;
        bushSprites.priority = Priority.environmentIntersected;
      } else {
        if (value.priority == Priority.environmentIntersected) {
          bushSprites.opacity = 1;
          bushSprites.priority = Priority.normal;
        }
      }
    });
  }
}
