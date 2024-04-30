import 'package:dusty_flutter/game/game_objects/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class TempRect extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, CollisionCallbacks, ActiveObjects {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('target_area');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
  }
}
