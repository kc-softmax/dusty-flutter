import 'package:dusty_flutter/game/game.dart';
import 'package:flame/components.dart';

class DustyBody extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame> {
  late String _bodyName;

  DustyBody({String bodyName = 'default_body'}) {
    _bodyName = bodyName;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = SpriteAnimation.spriteList(
      gameRef.atlas.findSpritesByName(_bodyName),
      stepTime: 0.05,
    );
    anchor = Anchor.center;
  }
}
