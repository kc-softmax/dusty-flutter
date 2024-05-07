import 'package:dusty_flutter/game/game_objects/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/base/object.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Stone extends SpriteAnimationComponent
    with
        HasGameRef<DustyIslandGame>,
        CollisionCallbacks,
        DIObject,
        ActiveObjects,
        MovingObject {
  double elapsedDelta = 0;
  double currentSpeed = 0;
  late final Vector2 initialPosition;

  Stone(int objectId) {
    this.objectId = objectId;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('normal_stone');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );

    size = Vector2.all(16);
    anchor = Anchor.center;
    nextPosition = Vector2(x, y);
    direction = Vector2(x, y);
    serverDelta = gameRef.playWorld!.serverDelta;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(movement(dt));
    angle += dt;
  }

  @override
  void idle() {}
}
