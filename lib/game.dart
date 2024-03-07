import 'dart:async';
import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/atlas/texture_atlas.dart';
import 'package:dusty_flutter/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/flame_texturepacker.dart';
import 'package:dusty_flutter/scenes/loading_scene.dart';
import 'package:dusty_flutter/scenes/lobby_scene.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart' hide Text;
import 'package:flutter/material.dart' hide Route, OverlayRoute;
import 'package:shared_preferences/shared_preferences.dart';

class DustyIslandWorld extends World with HasGameRef<DustyIslandGame> {
  late final TiledComponent mapComponent;
  late final TextureAtlas atlas;
  late final RouterComponent router;

  late final PlayScene playScene;
  late final LoadingScene loadingScene;
  late final LobbyScene lobbyScene;

  bool isReGame = false;
  bool isVerified = false;
  bool isLoadedAtlas = false;
  bool isLoadedMap = false;

  DustyIslandWorld();
  factory DustyIslandWorld.reGame() => DustyIslandWorld()..isReGame = true;

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
                            await prefs.setInt("playerId", result.id);
                            await prefs.setString("token", result.accessToken);
                            await prefs.setString("userName", result.userName);

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

    await DustySoundPool.instance.load();

    final token = (await SharedPreferences.getInstance()).getString('token');

    isVerified = token != null && await Arbiter.api.verifyToken(token);

    game.fromAtlas('images/dusty-island.atlas').then((value) {
      atlas = value;
      isLoadedAtlas = true;
    });

    TiledComponent.load('beach.tmx', Vector2.all(32)).then((value) {
      mapComponent = value;
      isLoadedMap = true;
    });
  }

  PlayScene _buildPlayScene() {
    playScene = PlayScene();
    return playScene;
  }

  LoadingScene _buildLoadingScene() {
    loadingScene = LoadingScene(isReGame: isReGame);
    return loadingScene;
  }

  LobbyScene _buildLobbyScene() {
    lobbyScene = LobbyScene();
    return lobbyScene;
  }
}

class DustyIslandGame extends FlameGame
    with HasCollisionDetection, SingleGameInstance {
  DustyIslandGame() : super(world: DustyIslandWorld());

  // 이전 코드들과 호환성을 위한 getters
  PlayScene get playScene => world.playScene;
  LoadingScene get loadingScene => world.loadingScene;
  LobbyScene get lobbyScene => world.lobbyScene;
  RouterComponent get router => world.router;
  TextureAtlas get atlas => world.atlas;
  TiledComponent get mapComponent => world.mapComponent;
  bool get isVerified => world.isVerified;
  bool get isFinishLoadAllResource => world.isLoadedAtlas && world.isLoadedMap;

  @override
  DustyIslandWorld get world => super.world as DustyIslandWorld;

  // @override
  // KeyEventResult onKeyEvent(
  //   KeyEvent event,
  //   Set<LogicalKeyboardKey> keysPressed,
  // ) {
  //   final isKeyDown = event is KeyDownEvent;
  //   final isKeyUp = event is KeyUpEvent;
  //   if (isKeyDown) {
  //     if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
  //       Arbiter.liveService.sendByte(DustyAction.forward.encode());
  //     }
  //     if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
  //       Arbiter.liveService.sendByte(DustyAction.rotateLeft.encode());
  //     }
  //     if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
  //       Arbiter.liveService.sendByte(DustyAction.rotateRight.encode());
  //     }
  //     if (keysPressed.contains(LogicalKeyboardKey.digit1)) {
  //       Arbiter.liveService.sendByte(DustyAction.activeSkill.encode());
  //     }

  //     return KeyEventResult.handled;
  //   }
  //   if (isKeyUp) {
  //     if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
  //       Arbiter.liveService.sendByte(DustyAction.stop.encode());
  //     }
  //     if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
  //       Arbiter.liveService.sendByte(DustyAction.stop.encode());
  //     }
  //     if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
  //       Arbiter.liveService.sendByte(DustyAction.stop.encode());
  //     }
  //     return KeyEventResult.handled;
  //   }

  //   return KeyEventResult.ignored;
  // }
}
