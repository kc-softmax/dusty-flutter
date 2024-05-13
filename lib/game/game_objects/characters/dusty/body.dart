import 'package:dusty_flutter/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/const.dart';

class DustyBody extends SpriteAnimationGroupComponent<DustyBodyType>
    with HasGameRef<DustyIslandGame> {
  DustyBodyType bodyType;

  DustyBody({required this.bodyType});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animations = {
      DustyBodyType.nature: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('yellow_body'),
        stepTime: 0.05,
      ),
      DustyBodyType.pollution: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('po_body'),
        stepTime: 0.05,
      ),
      DustyBodyType.neutral: SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('blue_body'),
        stepTime: 0.05,
      ),
    };

    current = bodyType;
  }
}

class DustyBodyEffect extends SpriteAnimationGroupComponent<DustyBodyEffectType>
    with HasGameRef<DustyIslandGame> {
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
