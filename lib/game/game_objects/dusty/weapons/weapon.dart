import 'dart:ui';

import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/game_objects/dusty/weapons/normal_axe.dart';
import 'package:dusty_flutter/game/utils/common.dart';
import 'package:flame/components.dart';

abstract class WeaponConfig extends Component with HasGameRef<DustyIslandGame> {
  double angle = 0;
  bool isWeaponHidden = false;
  List<List<double>> weaponOffsets = [];
  List<SpriteAnimationComponent> casting(DIObject? targetObject, int value);
}

class DustyWeapon extends SpriteGroupComponent<ItemType>
    with HasGameRef<DustyIslandGame> {
  late Map<ItemType, WeaponConfig> configs;
  WeaponConfig? config;
  int _parentAnimationIndex = 0;

  @override
  void update(double dt) {
    super.update(dt);
    if (config != null && angle != config!.angle) {
      angle = config!.angle;
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Image emptyImage = await createEmptyImage(Vector2.all(1));
    sprites = {
      ItemType.none: Sprite(emptyImage),
      ItemType.normalAxe:
          gameRef.atlas.findSpriteByName(ItemType.normalAxe.name) as Sprite
    };
    configs = {
      // ItemType.none: null,
      ItemType.normalAxe: NormalAxeConfig(),
    };
    current = ItemType.none;
  }

  void setWeapon(ItemType item) {
    current = item;
    config = configs[item];
    final weaponOffsets = getWeaponOffsets();
    anchor = weaponOffsets.isEmpty
        ? Anchor.center
        : Anchor(weaponOffsets.first[0], weaponOffsets.first[1]);
  }

  void dropWeapon(ItemType item) {
    if (item != current) return;
    current = ItemType.none;
    config = null;
  }

  void updatePosition(int? parentAnimationIndex) {
    if (parentAnimationIndex == null) return;
    if (parentAnimationIndex == _parentAnimationIndex) return;
    _parentAnimationIndex = parentAnimationIndex;
    final weaponOffsets = getWeaponOffsets();
    if (weaponOffsets.isEmpty) return;
    if (parentAnimationIndex < weaponOffsets.length) {
      final offset = weaponOffsets[parentAnimationIndex];
      anchor = Anchor(offset[0], offset[1]);
    }
  }

  List<List<double>> getWeaponOffsets() {
    if (config == null) return [];
    return config!.weaponOffsets;
  }

  void casting(DIObject? targetObject, int? value) {
    if (config == null) return;
    if (value == null) return;
    final swingAnimations = config!.casting(targetObject, value);
    if (swingAnimations.isEmpty) return;
    if (config!.isWeaponHidden) {
      final originItemType = current;
      swingAnimations.last.animationTicker?.onComplete = () {
        current = originItemType;
      };
      current = ItemType.none;
    }
    for (final swingAnimation in swingAnimations) {
      add(swingAnimation);
    }
  }
}
