import 'dart:collection';

import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/game_objects/active_objects/axe.dart';
import 'package:dusty_flutter/game/game_objects/active_objects/stone.dart';
import 'package:dusty_flutter/mixins/game_mixin.dart';
import 'package:dusty_flutter/models/protocols/parser.dart';
import 'package:flame/components.dart';

abstract mixin class ActiveObjects implements PositionComponent {
  late ActiveObjectType objectType;
  final Queue<Vector2> positions = Queue<Vector2>();
  double currentTime = 0.0;

  void updateState(List<StateData> states) {
    for (StateData stateData in states) {
      switch (stateData.state) {
        case ObjectState.moving:
          positions.add(Vector2(
            PositionParser.x(stateData.value),
            PositionParser.y(stateData.value),
          ));
          break;
        case ObjectState.idle:
        default:
      }
    }
  }

  factory ActiveObjects.axe(ActiveObjectEvent message) => Axe()
    ..x = message.x
    ..y = message.y;

  factory ActiveObjects.stone(ActiveObjectEvent message) => Stone()
    ..x = message.x
    ..y = message.y;
}

class ActiveObjectsFactory
    extends ObjectFactoryComponent<ActiveObjects, ActiveObjectEvent> {
  @override
  ActiveObjects facotry(ActiveObjectEvent message) {
    assert(message.objectType != null, "objectType is null");
    assert(message.position != null, "position is null");
    switch (message.objectType) {
      case ActiveObjectType.axe:
        return ActiveObjects.axe(message);
      case ActiveObjectType.stone:
        return ActiveObjects.stone(message);
      default:
        return ActiveObjects.axe(message);
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
      if (message.states != null) activeObject.updateState(message.states!);
    }
  }
}
