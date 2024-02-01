import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/main.dart';

class DustyMissaile extends SpriteAnimationComponent
    with HasGameRef<DustyIsland>, CollisionCallbacks {
  Vector2 direction;

  DustyMissaile({
    required this.direction,
  }) : super(scale: Vector2.all(0.5), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('bm');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(direction * 300 * dt);
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
