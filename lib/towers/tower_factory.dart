import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/effects/const.dart';
import 'package:dusty_flutter/effects/default_explosion.dart';
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
    }
  }

  @override
  void onUpdateObject(TowerMessage message) {}
}
