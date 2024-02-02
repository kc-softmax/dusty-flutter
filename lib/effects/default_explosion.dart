import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/effects/const.dart';

class DefaultExplosion extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame> {
  final DefaultExplosionType explosionType;

  DefaultExplosion(this.explosionType)
      : super(
          anchor: Anchor.center,
          size: Vector2(96, 96),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    switch (explosionType) {
      case DefaultExplosionType.red:
        animation = SpriteAnimation.spriteList(
            gameRef.atlas.findSpritesByName('red_explosion'),
            stepTime: 0.05,
            loop: false);
      case DefaultExplosionType.blue:
        animation = SpriteAnimation.spriteList(
            gameRef.atlas.findSpritesByName('blue_explosion'),
            stepTime: 0.05,
            loop: false);
        break;
    }

    animationTicker!.onComplete = () {
      removeFromParent();
    };
  }

  static DefaultExplosion generate(
      DefaultExplosionType explosionType, Vector2 position) {
    return DefaultExplosion(explosionType)
      ..x = position.x + 2
      ..y = position.y - 10;
  }
}
