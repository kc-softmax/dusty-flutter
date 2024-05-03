import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/base/object_factory.dart';
import 'package:dusty_flutter/game/game_objects/passive_objects/environment/tree.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:flame/components.dart';

abstract mixin class PassiveObjects implements DIObject {
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
    extends BaseObjectsFactory<PassiveObjects, PassiveObjectEvent> {
  @override
  PassiveObjects facotry(PassiveObjectEvent message) {
    assert(message.objectType != null, "objectType is null");
    assert(message.position != null, "position is null");
    switch (message.objectType) {
      default:
        return PassiveObjects.tree(message);
    }
  }
}
