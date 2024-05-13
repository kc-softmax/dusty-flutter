import 'package:dusty_flutter/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/const.dart';

class DustyWeapon extends SpriteGroupComponent<DustyWeapon>
    with HasGameRef<DustyIslandGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // animations = {
    //   DustyGlassesType.idle: SpriteAnimation.spriteList(
    //     gameRef.atlas.findSpritesByName('type_a'),
    //     stepTime: 0.05,
    //   ),
    // };
    // current = DustyGlassesType.idle;
  }
}

class DustyWeaponEffect
    extends SpriteAnimationGroupComponent<DustyWeaponEffectType>
    with HasGameRef<DustyIslandGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animations = {
      DustyWeaponEffectType.axeVerticalSwing: SpriteAnimation.spriteList(
          gameRef.atlas.findSpritesByName('axe_swing'),
          stepTime: 0.04,
          loop: false),
    };
    autoResetTicker = true;
  }
}
