import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/characters/const.dart';
import 'package:dusty_flutter/main.dart';

class DustyGlasses extends SpriteAnimationGroupComponent<GlassesState>
    with HasGameRef<DustyIsland>, CollisionCallbacks {
  DustyGlasses({
    required Map<GlassesState, SpriteAnimation> animations,
    required GlassesState initialState,
  }) : super(
          animations: animations,
          current: initialState,
          size: Vector2(48, 48),
        );

  void changeState(GlassesState state) {
    current = state;
  }
}

class Dusty extends SpriteAnimationComponent
    with HasGameRef<DustyIsland>, CollisionCallbacks {
  late final DustyGlasses glasses;

  Dusty() : super(size: Vector2(48, 48), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = SpriteAnimation.spriteList(
      gameRef.atlas.findSpritesByName('red_body'),
      stepTime: 0.05,
    );
    glasses = DustyGlasses(
      animations: {
        GlassesState.idle: SpriteAnimation.spriteList(
          gameRef.atlas.findSpritesByName('type_a'),
          stepTime: 0.05,
        ),
        GlassesState.boost: SpriteAnimation.spriteList(
          gameRef.atlas.findSpritesByName('type_a_boost'),
          stepTime: 0.05,
        ),
      },
      initialState: GlassesState.boost,
    );
    add(glasses);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameRef.joystick.delta.isZero() && activeCollisions.isEmpty) {
      position.add(gameRef.joystick.relativeDelta.normalized() * 300 * dt);
      if (gameRef.joystick.relativeDelta.screenAngle() >= 0 &&
          isFlippedHorizontally) {
        flipHorizontally();
      }
      if (gameRef.joystick.relativeDelta.screenAngle() < 0 &&
          !isFlippedHorizontally) {
        flipHorizontally();
      }
    }
  }

  // @override
  // void onCollisionStart(
  //   Set<Vector2> intersectionPoints,
  //   PositionComponent other,
  // ) {
  //   super.onCollisionStart(intersectionPoints, other);
  // }
}
