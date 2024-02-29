import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/effects/ui/const.dart';
import 'package:dusty_flutter/effects/ui/default_explosion.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:dusty_flutter/towers/normal/normal_tower.dart';
import 'package:flame/components.dart';

abstract mixin class Towers implements SpriteAnimationComponent {
  factory Towers.normal() => NormalTower()
    ..size = Vector2(48, 48)
    ..anchor = Anchor.center;
}

class TowerFactory extends ObjectFactoryComponent<Towers, TowerMessage> {
  @override
  Towers facotry(TowerMessage message) {
    assert(message.position != null, "position is null");
    return Towers.normal()
      ..x = message.x
      ..y = message.y;
  }

  @override
  void onGenerateObject(TowerMessage message) {
    final newTower = facotry(message);
    objects[message.towerId] = newTower;
    gameRef.world.add(newTower);
    // 생성과 삭제 소리는 factory에서 하는 것이 좋을까?
    // 현재 더스티는 더스티 안에서 하고 있음.
    DustySoundPool.instance.effectOnInstallTower();
  }

  @override
  void onRemoveObject(TowerMessage message) {
    final tower = objects[message.towerId];
    if (tower != null) {
      switch (message.removeBy) {
        case RemoveBy.missaile:
          gameRef.world.add(DefaultExplosion(DefaultExplosionType.blue)
            ..x = tower.x
            ..y = tower.y
            ..size = tower.size * 2);
          break;
        default:
          gameRef.world.add(DefaultExplosion(DefaultExplosionType.red)
            ..x = tower.x
            ..y = tower.y
            ..size = tower.size * 2);
          break;
      }
      gameRef.world.remove(tower);
      objects.remove(message.towerId);
      DustySoundPool.instance.effectOnRemoveTower();
    }
  }

  @override
  void onUpdateObject(TowerMessage message) {}
}
