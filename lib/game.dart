import 'dart:async';
import 'package:dusty_flutter/atlas/texture_atlas.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:dusty_flutter/worlds/loading.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart' hide Text;
import 'package:flutter/material.dart' hide Route, OverlayRoute;

class DustyIslandWorld extends World with HasGameRef<DustyIslandGame> {
  late final RouterComponent router;

  late final PlayScene playScene;

  bool isVerified = false;

  PositionComponent? background;

  DustyIslandWorld();

  @override
  Future<void> onLoad() async {
    add(
      router = RouterComponent(
        initialRoute: PlayScene.routerName,
        routes: {
          PlayScene.routerName: Route(_buildPlayScene),
        },
      ),
    );
  }

  PlayScene _buildPlayScene() {
    // 맵을 줌할 때 등, 백그라운드 이미지가 보일 때가 있어서
    // 플레이씬에서는 백그라운드 이미지를 제거한다.
    playScene = PlayScene();
    return playScene;
  }
}

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

  // 이전 코드들과 호환성을 위한 getters
  PlayScene get playScene => (world as DustyIslandWorld).playScene;
  RouterComponent get router => (world as DustyIslandWorld).router;
  double get canvasDiagonal => canvasSize.length;

  @override
  Color backgroundColor() {
    return gameBackgroundColor;
  }
}
