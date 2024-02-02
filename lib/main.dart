import 'dart:async';
import 'package:dusty_flutter/scenes/hud_scene.dart';
import 'package:dusty_flutter/scenes/loading_scene.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart' hide Text;
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/atlas/texture_atlas.dart';
import 'package:dusty_flutter/flame_texturepacker.dart';

class DustyIsland extends FlameGame with HasCollisionDetection {
  late final TiledComponent mapComponent;
  late final TextureAtlas atlas;
  late final RouterComponent router;

  late final PlayScene playScene;
  late final HudScene hudScene;
  late final LoadingScene loadingScene;

  bool isLoadedAtlas = false;
  bool isLoadedMap = false;
  bool get isFinishLoadAllResource => isLoadedAtlas && isLoadedMap;

  @override
  Future<void> onLoad() async {
    add(
      router = RouterComponent(
        routes: {
          HudScene.routerName: Route(buildHudScene),
          PlayScene.routerName: Route(buildPlayScene),
          LoadingScene.routerName: Route(buildLoadingScene),
        },
        initialRoute: LoadingScene.routerName,
      ),
    );

    fromAtlas('images/dusty-island.atlas').then((value) {
      atlas = value;
      isLoadedAtlas = true;
    });

    TiledComponent.load('map.tmx', Vector2.all(64)).then((value) {
      mapComponent = value;
      isLoadedMap = true;
    });
  }

  PlayScene buildPlayScene() {
    playScene = PlayScene();
    return playScene;
  }

  LoadingScene buildLoadingScene() {
    loadingScene = LoadingScene();
    return loadingScene;
  }

  HudScene buildHudScene() {
    hudScene = HudScene();
    return hudScene;
  }
}

void main() {
  runApp(GameWidget(
    game: DustyIsland(),
    overlayBuilderMap: {
      "TestButton": (BuildContext context, DustyIsland game) {
        return FilledButton(
            onPressed: () {
              Arbiter.liveService.on(
                "/di/ws?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDcxMDQyMzYsInN1YiI6IjE1In0.SqJrXhDWl-eQVMyY1m02dm8e1OZqOV1iSY0LSkkP0i0",
                (message) {
                  debugPrint(message.toString());
                },
              );
            },
            child: const Text("TEST"));
      }
    },
  ));
}
