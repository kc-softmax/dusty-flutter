import 'dart:async';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/scenes/hud_scene.dart';
import 'package:flame/components.dart';

class PlayScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = 'play';

  late final Dusty player;

  @override
  FutureOr<void> onLoad() {
    player = Dusty()
      ..x = 500
      ..y = 500;

    gameRef.world.add(gameRef.mapComponent);
    gameRef.world.addAll([player]);
    gameRef.camera.follow(player);
    gameRef.router.pushNamed(HudScene.routerName);
  }
}
