import 'package:dusty_flutter/game/active_objects/grenade/normal_grenade.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game/effects/ui/burn_effect.dart';
import 'package:dusty_flutter/game/effects/ui/const.dart';
import 'package:dusty_flutter/game/effects/ui/default_explosion.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:dusty_flutter/game/passive_objects/environment/bush.dart';
import 'package:dusty_flutter/game/passive_objects/environment/trash.dart';
import 'package:dusty_flutter/game/passive_objects/environment/tree.dart';
import 'package:dusty_flutter/game/passive_objects/equipment.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

abstract mixin class PassiveObjects implements PositionComponent {
  late PassiveObjectType objectType;

  factory PassiveObjects.equipment(PassiveObjectMessage message) => Equipment()
    ..objectType = message.objectType!
    ..anchor = Anchor.topLeft
    ..size = Vector2(28, 28)
    ..x = message.x
    ..y = message.y;

  factory PassiveObjects.bush(PassiveObjectMessage message) => Bush()
    ..objectType = message.objectType!
    ..size = Vector2(52, 52)
    ..anchor = Anchor.center
    ..x = message.x
    ..y = message.y;

  factory PassiveObjects.trash(PassiveObjectMessage message) => Trash(message)
    ..objectType = message.objectType!
    ..size = Vector2.all(16)
    ..anchor = Anchor.center;

  factory PassiveObjects.tree(PassiveObjectMessage message) => Tree()
    ..objectType = message.objectType!
    ..anchor = Anchor.bottomCenter
    ..scale = Vector2.all(0.5)
    ..x = message.x
    ..y = message.y + 32
    ..priority = Priority.environment;
}

class PassiveObjectsFactory
    extends ObjectFactoryComponent<PassiveObjects, PassiveObjectMessage> {
  @override
  PassiveObjects facotry(PassiveObjectMessage message) {
    assert(message.objectType != null, "objectType is null");
    assert(message.position != null, "position is null");
    switch (message.objectType) {
      case PassiveObjectType.bush:
        return PassiveObjects.bush(message);
      case PassiveObjectType.trash:
        return PassiveObjects.trash(message)..anchor = Anchor.center;
      case PassiveObjectType.tree || PassiveObjectType.winterTree:
        return PassiveObjects.tree(message);
      default:
        return PassiveObjects.bush(message);
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
    var burn = false;
    switch (message.removeBy) {
      case RemoveBy.flame:
        burn = true;
        gameRef.world
            .add(BurnEffect.generate(object.position)..size = object.size);
      default:
        break;
    }
    final dusty = gameRef.playWorld!.dustyFactory.objects[message.acquireBy];
    if (!burn && dusty != null) {
      // animation 후 remove
      object.add(MoveEffect.to(dusty.position, EffectController(duration: 0.1))
        ..onComplete = () => object.removeFromParent());
    } else {
      object.removeFromParent();
    }
    // 만약 사라지는 애니메이션 등이 있다면
    // 애니메이션 종료 후 실행할 콜백으로 넘길 수 있다.
    objects.remove(message.objectId);
  }

  @override
  void onUpdateObject(PassiveObjectMessage message) {}
}
