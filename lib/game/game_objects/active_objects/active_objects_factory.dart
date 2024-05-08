import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/base/object_factory.dart';
import 'package:dusty_flutter/game/game_objects/active_objects/axe.dart';
import 'package:dusty_flutter/game/game_objects/active_objects/stone.dart';
import 'package:dusty_flutter/game/base/object.dart';

abstract mixin class ActiveObjects implements DIObject {
  late ActiveObjectType objectType;

  factory ActiveObjects.axe(ActiveObjectEvent message) =>
      Axe(message.objectId, initialAngle: message.angle!)
        ..x = message.x
        ..y = message.y;

  factory ActiveObjects.stone(ActiveObjectEvent message) =>
      Stone(message.objectId)
        ..x = message.x
        ..y = message.y;
}

class ActiveObjectsFactory
    extends BaseObjectsFactory<ActiveObjects, ActiveObjectEvent> {
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
}
