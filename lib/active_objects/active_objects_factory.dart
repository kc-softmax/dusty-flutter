import 'package:dusty_flutter/active_objects/grenade/normal_grenade.dart';
import 'package:dusty_flutter/active_objects/missaile/dusty_missaile.dart';
import 'package:dusty_flutter/active_objects/punch/normal_punch.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/effects/ui/const.dart';
import 'package:dusty_flutter/effects/ui/default_explosion.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:flame/components.dart';

abstract mixin class ActiveObjects implements SpriteAnimationComponent {
  factory ActiveObjects.missaile(ActiveObjectMessage message) => DustyMissaile(
      speed: message.speed!.toDouble(),
      direction:
          Vector2(message.directionX! * 0.001, message.directionY! * 0.001));

  factory ActiveObjects.grenade(ActiveObjectMessage message) =>
      NormalGrenade(message: message);

  factory ActiveObjects.punch({required ActiveObjectMessage message}) =>
      NormalPunch(message: message);
}

class ActiveObjectsFactory
    extends ObjectFactoryComponent<ActiveObjects, ActiveObjectMessage> {
  @override
  ActiveObjects facotry(ActiveObjectMessage message) {
    assert(message.objectType != null, "objectType is null");
    assert(message.position != null, "position is null");
    switch (message.objectType) {
      case ActiveObjectType.normalMissaile:
        return ActiveObjects.missaile(message)
          ..x = message.x
          ..y = message.y
          ..size = Vector2.all(24);
      case ActiveObjectType.normalGrenade:
        return ActiveObjects.grenade(message)
          ..x = message.x
          ..y = message.y
          ..size = Vector2.all(24);
      case ActiveObjectType.normalPunch:
        return ActiveObjects.punch(message: message)
          ..x = message.x
          ..y = message.y
          ..size = Vector2.all(24);
      default:
        return ActiveObjects.missaile(message);
    }
  }

  @override
  void onGenerateObject(ActiveObjectMessage message) {
    final newActiveObject = facotry(message);
    objects[message.objectId] = newActiveObject;
    gameRef.world.add(newActiveObject);
  }

  @override
  void onRemoveObject(ActiveObjectMessage message) {
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
  void onUpdateObject(ActiveObjectMessage message) {}
}
