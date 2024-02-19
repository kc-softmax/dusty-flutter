import 'package:dusty_flutter/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class DustyMissaile extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, CollisionCallbacks, ActiveObjects {
  Vector2 direction;
  double stride;
  late double speed;

  DustyMissaile({
    required this.stride,
    required this.direction,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('bm');
    speed = stride * gameRef.playScene.gameConfig!.frameRate;
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(direction * speed * dt);
  }
}

// void launchMissaile() {
//   final missaile = DustyMissaile(
//     missaileType: MissaileType.blue,
//     // direction: joystick.relativeDelta.normalized(),
//     direction: Vector2(1, 0),
//   )
//     ..x = player.x
//     ..y = player.y;
//   // setform?
//   world.add(missaile);
// }
