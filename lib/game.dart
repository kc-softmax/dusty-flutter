import 'dart:async';
import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/atlas/texture_atlas.dart';
import 'package:dusty_flutter/flame_texturepacker.dart';
import 'package:dusty_flutter/scenes/loading_scene.dart';
import 'package:dusty_flutter/scenes/lobby_scene.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart' hide Text;
import 'package:flutter/material.dart' hide Route, OverlayRoute;
import 'package:shared_preferences/shared_preferences.dart';

class DustyIslandGame extends FlameGame with HasCollisionDetection {
  late final TiledComponent mapComponent;
  late final TextureAtlas atlas;
  late final RouterComponent router;

  late final PlayScene playScene;
  late final LoadingScene loadingScene;
  late final LobbyScene lobbyScene;

  bool isLoadedAtlas = false;
  bool isLoadedMap = false;
  bool get isFinishLoadAllResource => isLoadedAtlas && isLoadedMap;

  bool isVerified = false;

  @override
  Future<void> onLoad() async {
    add(
      router = RouterComponent(
        routes: {
          LoadingScene.routerName: Route(_buildLoadingScene),
          LobbyScene.routerName: Route(_buildLobbyScene),
          PlayScene.routerName: Route(_buildPlayScene),
          "login-dialog": OverlayRoute((context, game) {
            final controller = TextEditingController();
            return Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 36,
                        child: TextField(
                          controller: controller,
                        ),
                      ),
                      FilledButton(
                          onPressed: () async {
                            final result = await Arbiter.api.loginByUserName(
                                RequestLoginByUserName(
                                    userName: controller.value.text));
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString("token", result.accessToken);
                            router.pop();
                            router.pushReplacementNamed(LobbyScene.routerName);
                          },
                          child: const Text("로그인")),
                    ],
                  ),
                ),
              ),
            );
          }),
        },
        initialRoute: LoadingScene.routerName,
      ),
    );

    final token = (await SharedPreferences.getInstance()).getString('token');
    isVerified = token != null && await Arbiter.api.verifyToken(token);

    fromAtlas('images/dusty-island.atlas').then((value) {
      atlas = value;
      isLoadedAtlas = true;
    });

    TiledComponent.load('single_map.tmx', Vector2.all(64)).then((value) {
      mapComponent = value;
      isLoadedMap = true;
    });
  }

  PlayScene _buildPlayScene() {
    playScene = PlayScene();
    return playScene;
  }

  LoadingScene _buildLoadingScene() {
    loadingScene = LoadingScene();
    return loadingScene;
  }

  LobbyScene _buildLobbyScene() {
    lobbyScene = LobbyScene();
    return lobbyScene;
  }
}
