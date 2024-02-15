import 'package:dusty_flutter/active_objects/missaile/dust_ball.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:flame/components.dart';

abstract mixin class ActiveObjects implements SpriteAnimationComponent {
  factory ActiveObjects.missaile({required Vector2 direction}) =>
      DustyMissaile(direction: direction);
}

class ActiveObjectsFactory
    extends ObjectFactoryComponent<ActiveObjects, ActiveObjectMessage> {
  @override
  ActiveObjects facotry(ActiveObjectMessage message) {
    assert(message.objectType != null, "objectType is null");
    assert(message.position != null, "position is null");

    switch (message.objectType) {
      case ActiveObjectType.dustyMissaile:
        return ActiveObjects.missaile(
            direction:
                Vector2(message.directionX! * 0.01, message.directionY! * 0.01))
          ..x = message.x
          ..y = message.y;
      default:
        return ActiveObjects.missaile(direction: Vector2.zero());
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
    assert(message.removeType != null, "removeType is null");

    final object = objects[message.objectId];
    if (object == null) return;

    switch (message.removeType) {
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
