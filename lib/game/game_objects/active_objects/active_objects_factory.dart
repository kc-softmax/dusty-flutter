import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/base/object_factory.dart';
import 'package:dusty_flutter/game/game_objects/active_objects/throwing_normal_axe.dart';
import 'package:dusty_flutter/game/base/object.dart';

abstract mixin class ActiveObjects implements DIObject {
  late ActiveObjectType objectType;

  factory ActiveObjects.throwingNormalAxe(ActiveObjectEvent message) =>
      ThrowingNormalAxe(message.objectId)
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
      case ActiveObjectType.throwingNormalAxe:
        return ActiveObjects.throwingNormalAxe(message);
      default:
        return ActiveObjects.throwingNormalAxe(message);
    }
  }
}
