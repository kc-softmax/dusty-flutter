import 'package:dusty_flutter/atlas/texture_atlas.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:dusty_flutter/worlds/loading.dart';
import 'package:dusty_flutter/worlds/play.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart' hide Text;
import 'package:flutter/material.dart' hide Route, OverlayRoute;

class DustyIslandGame extends FlameGame
    with
        HasCollisionDetection,
        SingleGameInstance,
        HasKeyboardHandlerComponents {
  FocusNode? focusNode;
  late TextureAtlas atlas;
  late TiledComponent mapComponent;
  late bool isVerifiedAuth;

  DustyIslandGame(this.focusNode) : super(world: LoadingSceneWorld()) {
    pauseWhenBackgrounded = false;
  }

  PlaySceneWorld? get playWorld {
    if (world is! PlaySceneWorld) return null;
    return world as PlaySceneWorld;
  }

  double get canvasDiagonal => canvasSize.length;

  @override
  Color backgroundColor() {
    return gameBackgroundColor;
  }
}
