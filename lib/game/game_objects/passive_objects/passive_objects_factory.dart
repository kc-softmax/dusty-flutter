import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:dusty_flutter/game/game_objects/passive_objects/environment/tree.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:flame/components.dart';

abstract mixin class PassiveObjects implements PositionComponent {
  late PassiveObjectType objectType;

  factory PassiveObjects.tree(PassiveObjectEvent message) => Tree()
    ..objectType = message.objectType!
    ..anchor = Anchor.bottomCenter
    ..scale = Vector2.all(0.5)
    ..x = message.x
    ..y = message.y + 32
    ..priority = Priority.environment;
}

class PassiveObjectsFactory
    extends ObjectFactoryComponent<PassiveObjects, PassiveObjectEvent> {
  @override
  PassiveObjects facotry(PassiveObjectEvent message) {
    assert(message.objectType != null, "objectType is null");
    assert(message.position != null, "position is null");
    switch (message.objectType) {
      default:
        return PassiveObjects.tree(message);
    }
  }

  @override
  void onGenerateObject(PassiveObjectEvent message) {
    final newPassiveObject = facotry(message);
    objects[message.objectId] = newPassiveObject;
    gameRef.world.add(newPassiveObject);
  }

  @override
  void onRemoveObject(PassiveObjectEvent message) {
    final object = objects[message.objectId];
    if (object == null) return;

    object.removeFromParent();
    // 만약 사라지는 애니메이션 등이 있다면
    // 애니메이션 종료 후 실행할 콜백으로 넘길 수 있다.
    objects.remove(message.objectId);
  }

  @override
  void onUpdateObject(PassiveObjectEvent message) {
    print(message);
  }
}
