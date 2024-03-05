import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/effects/ui/const.dart';

class DefaultExplosion extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame> {
  final DefaultExplosionType explosionType;

  DefaultExplosion(this.explosionType)
      : super(
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    priority = Priority.environment;
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
      case DefaultExplosionType.grenade:
        animation = SpriteAnimation.spriteList(
            gameRef.atlas.findSpritesByName('grenade_explosion'),
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
