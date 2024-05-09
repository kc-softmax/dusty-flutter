import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/game_objects/passive_objects/passive_objects_factory.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class TrimmedTree extends SpriteAnimationComponent
    with
        HasGameRef<DustyIslandGame>,
        CollisionCallbacks,
        DIObject,
        PassiveObjects {
  TrimmedTree(int objectId) {
    this.objectId = objectId;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('trimmed_tree');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
    anchor = Anchor.bottomCenter;
    scale = Vector2.all(0.5);
    priority = Priority.environment;
  }

  @override
  void idle() {}
}
