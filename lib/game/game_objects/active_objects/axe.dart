import 'package:dusty_flutter/game/game_objects/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/utils/vector.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Axe extends SpriteAnimationComponent
    with
        HasGameRef<DustyIslandGame>,
        CollisionCallbacks,
        DIObject,
        ActiveObjects,
        MovingObject {
  late Vector2 initialPosition;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('normal_axe');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
    initialPosition = Vector2(x, y);
    nextPosition = Vector2(x, y);
    direction = Vector2(x, y);
    serverDelta = gameRef.playWorld!.serverDelta;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(movement(dt));
    angle = (position - initialPosition).screenAngle();
  }

  @override
  void idle() {}
}
