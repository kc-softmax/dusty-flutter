import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/base/object_factory.dart';
import 'package:dusty_flutter/game/game_objects/passive_objects/environment/tree.dart';
import 'package:dusty_flutter/game/game_objects/passive_objects/environment/trimmed_tree.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:flame/components.dart';

abstract mixin class PassiveObjects implements DIObject {
  factory PassiveObjects.tree(PassiveObjectEvent message) =>
      Tree(message.objectId, treeType: message.objectType!)
        ..x = message.x
        ..y = message.y;

  factory PassiveObjects.trimmedTree(PassiveObjectEvent message) =>
      TrimmedTree(message.objectId)
        ..x = message.x
        ..y = message.y;
}

class PassiveObjectsFactory
    extends BaseObjectsFactory<PassiveObjects, PassiveObjectEvent> {
  @override
  PassiveObjects facotry(PassiveObjectEvent message) {
    assert(message.objectType != null, "objectType is null");
    assert(message.position != null, "position is null");
    switch (message.objectType) {
      case PassiveObjectType.tree:
        return PassiveObjects.tree(message);
      case PassiveObjectType.trimmedTree:
        return PassiveObjects.trimmedTree(message);
      default:
        return PassiveObjects.tree(message);
    }
  }
}
