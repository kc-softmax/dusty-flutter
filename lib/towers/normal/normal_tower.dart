import 'dart:async';

import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/towers/tower_factory.dart';
import 'package:flame/components.dart';

class NormalTower extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, Towers {
  @override
  FutureOr<void> onLoad() {
    final spriteList = gameRef.atlas.findSpritesByName('bm');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
  }
}
