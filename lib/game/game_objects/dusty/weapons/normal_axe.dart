import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:dusty_flutter/game/game_objects/dusty/weapons/weapon.dart';

class NormalAxeConfig extends WeaponConfig {
  @override
  bool get isWeaponHidden => true;

  @override
  List<List<double>> get weaponOffsets => [
        [0.75, 0.75],
        [0.7, 0.65],
        [0.65, 0.55],
        [0.6, 0.45],
        [0.65, 0.55],
        [0.7, 0.65],
        [0.75, 0.75],
        [0.7, 0.8],
        [0.65, 0.85],
        [0.7, 0.8],
      ];

  @override
  List<SpriteAnimationComponent> casting(DIObject? targetObject, int value) {
    DustyCastingType castingType = DustyCastingType.parse(value);
    switch (castingType) {
      case DustyCastingType.swingWeapon:
        final swingAnimation = SpriteAnimationComponent(
            animation: SpriteAnimation.spriteList(
                gameRef.atlas.findSpritesByName('axe_swing'),
                stepTime: .033,
                loop: false),
            removeOnFinish: true)
          ..anchor = const Anchor(0.45, 0.45);
        return [swingAnimation];
      case DustyCastingType.throwWeapon:
        break;
    }
    return [];
  }
}
