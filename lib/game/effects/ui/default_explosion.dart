import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:flame/components.dart';

class DefaultExplosion extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    priority = Priority.environment;
    animation = SpriteAnimation.spriteList(
        gameRef.atlas.findSpritesByName('default_explosion'),
        stepTime: 0.04,
        loop: false);
    removeOnFinish = true;
  }

  static DefaultExplosion generate(Vector2 position) {
    return DefaultExplosion()
      ..x = position.x
      ..y = position.y - 10;
  }
}
