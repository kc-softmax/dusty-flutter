import 'package:dusty_flutter/active_objects/grenade/normal_grenade.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/effects/ui/const.dart';
import 'package:dusty_flutter/effects/ui/default_explosion.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:dusty_flutter/passive_objects/environment/bush.dart';
import 'package:dusty_flutter/passive_objects/environment/tree_of_life.dart';
import 'package:dusty_flutter/passive_objects/equipment/normal_seed.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';

abstract mixin class PassiveObjects implements SpriteAnimationComponent {
  factory PassiveObjects.normalSeed(PassiveObjectMessage message) =>
      NormalSeed()
        ..anchor = Anchor.center
        ..size = Vector2(24, 24)
        ..x = message.x
        ..y = message.y;

  factory PassiveObjects.treeOfLife(PassiveObjectMessage message) =>
      TreeOfLife()
        ..anchor = Anchor.bottomCenter
        ..scale = Vector2.all(0.5)
        ..x = message.x
        ..y = message.y
        ..priority = Priority.environment;

  factory PassiveObjects.bush4X4(PassiveObjectMessage message) =>
      Bush(objectType: message.objectType!)
        ..scale = Vector2.all(0.5)
        ..x = message.x
        ..y = message.y;
  factory PassiveObjects.bush8X8(PassiveObjectMessage message) =>
      Bush(objectType: message.objectType!)
        ..scale = Vector2.all(0.5)
        ..x = message.x
        ..y = message.y;
  // ..priority = Priority.environment;
  // factory PassiveObjects.fruit(
  //         {required double stride, required Vector2 direction}) =>
  //     NormalGrenade(stride: stride, direction: direction);
}

class PassiveObjectsFactory
    extends ObjectFactoryComponent<PassiveObjects, PassiveObjectMessage> {
  @override
  PassiveObjects facotry(PassiveObjectMessage message) {
    assert(message.objectType != null, "objectType is null");
    assert(message.position != null, "position is null");
    switch (message.objectType) {
      case PassiveObjectType.normalSeed:
        return PassiveObjects.normalSeed(message);
      case PassiveObjectType.middleTreeOfLife:
        return PassiveObjects.treeOfLife(message);
      case PassiveObjectType.bush4X4:
        return PassiveObjects.bush4X4(message);
      case PassiveObjectType.bush8X4:
        return PassiveObjects.bush4X4(message);
      default:
        return PassiveObjects.normalSeed(message);
    }
  }

  @override
  void onGenerateObject(PassiveObjectMessage message) {
    final newPassiveObject = facotry(message);
    objects[message.objectId] = newPassiveObject;
    gameRef.world.add(newPassiveObject);
  }

  @override
  void onRemoveObject(PassiveObjectMessage message) {
    assert(message.removeBy != null, "removeType is null");

    final object = objects[message.objectId];
    if (object == null) return;
    if (object is NormalGrenade) {
      gameRef.world.add(DefaultExplosion(DefaultExplosionType.grenade)
        ..x = object.x
        ..y = object.y
        ..size = Vector2(64, 64));
    }
    switch (message.removeBy) {
      default:
        break;
    }
    // 만약 사라지는 애니메이션 등이 있다면
    // 애니메이션 종료 후 실행할 콜백으로 넘길 수 있다.
    objects.remove(message.objectId);
    object.removeFromParent();
  }

  @override
  void onUpdateObject(PassiveObjectMessage message) {}
}
