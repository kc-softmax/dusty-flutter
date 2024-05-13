import 'package:dusty_flutter/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/const.dart';

class DustyGlasses extends SpriteAnimationGroupComponent<DustyGlassesType>
    with HasGameRef<DustyIslandGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animations = {
      DustyGlassesType.idle: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('type_a'),
        stepTime: 0.05,
      ),
    };
    current = DustyGlassesType.idle;
  }
}

class DustyGlassesEffect
    extends SpriteAnimationGroupComponent<DustyGlassesEffectType>
    with HasGameRef<DustyIslandGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animations = {
      DustyGlassesEffectType.fire: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('type_fire'),
        stepTime: 0.05,
      ),
      DustyGlassesEffectType.electricShock: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('type_lightning'),
        stepTime: 0.05,
      ),
    };
  }
}
