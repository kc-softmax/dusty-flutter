import 'dart:ui';

import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/game_objects/active_objects/temp_rect.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:flame/components.dart';

abstract mixin class ActiveObjects implements PositionComponent {
  late ActiveObjectType objectType;

  factory ActiveObjects.temp(ActiveObjectEvent message) => TempRect()
    ..anchor = Anchor.center
    ..x = message.x
    ..y = message.y
    ..size = Vector2.all(24)
    ..priority = Priority.environment;
}

class ActiveObjectsFactory
    extends ObjectFactoryComponent<ActiveObjects, ActiveObjectEvent> {
  @override
  ActiveObjects facotry(ActiveObjectEvent message) {
    assert(message.objectType != null, "objectType is null");
    assert(message.position != null, "position is null");
    switch (message.objectType) {
      default:
        return ActiveObjects.temp(message);
    }
  }

  @override
  void onGenerateObject(ActiveObjectEvent message) {
    final newActiveObject = facotry(message);
    objects[message.objectId] = newActiveObject;
    gameRef.world.add(newActiveObject);
  }

  @override
  void onRemoveObject(ActiveObjectEvent message) {
    final object = objects[message.objectId];
    if (object == null) return;

    object.removeFromParent();
    // 만약 사라지는 애니메이션 등이 있다면
    // 애니메이션 종료 후 실행할 콜백으로 넘길 수 있다.
    objects.remove(message.objectId);
  }

  @override
  void onUpdateObject(ActiveObjectEvent message) {
    ActiveObjects? activeObject = objects[message.objectId];
    if (activeObject != null) {
      activeObject.x = message.x;
      activeObject.y = message.y;
    }
  }
}
