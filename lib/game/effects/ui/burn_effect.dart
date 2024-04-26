import 'package:dusty_flutter/game/game.dart';
import 'package:flame/components.dart';

class BurnEffect extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame> {
  BurnEffect()
      : super(
          anchor: Anchor.center,
          size: Vector2(84, 84),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('burn'),
        stepTime: 0.03,
        loop: false);
    animationTicker!.onComplete = () {
      removeFromParent();
    };
  }

  static BurnEffect generate(Vector2 position) {
    return BurnEffect()
      ..x = position.x + 2
      ..y = position.y - 10;
  }
}
