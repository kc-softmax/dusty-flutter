import 'package:dusty_flutter/game/game.dart';
import 'package:flame/components.dart';

class ThunderEffect extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame> {
  ThunderEffect()
      : super(
          anchor: Anchor.bottomCenter,
          size: Vector2(64, 256),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('thunder'),
        stepTime: 0.04,
        loop: false);
    animationTicker!.onComplete = () {
      removeFromParent();
    };
    final falloutAnimation = SpriteAnimation.spriteList(
      gameRef.atlas.findSpritesByName('thunder_fallout'),
      stepTime: 0.04,
      loop: false,
    );
    final fallout = SpriteAnimationComponent()
      ..animation = falloutAnimation
      ..anchor = Anchor.topCenter
      ..size = Vector2(128, 64)
      ..x = x
      ..y = y - 84;
    fallout.animationTicker!.onComplete = () {
      fallout.removeFromParent();
    };
    gameRef.world.add(fallout);
  }

  static ThunderEffect generate(Vector2 position) {
    return ThunderEffect()
      ..x = position.x - 2
      ..y = position.y + 48;
  }
}
