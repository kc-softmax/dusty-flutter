import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:dusty_flutter/towers/normal/normal_tower.dart';
import 'package:flame/components.dart';

abstract mixin class Towers implements SpriteAnimationComponent {
  factory Towers.normal() => NormalTower()
    ..size = Vector2(64, 64)
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
  void onRemoveObject(TowerMessage message) {}

  @override
  void onUpdateObject(TowerMessage message) {}
}
