import 'dart:async';
import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/atlas/texture_atlas.dart';
import 'package:dusty_flutter/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/flame_texturepacker.dart';
import 'package:dusty_flutter/scenes/loading_scene.dart';
import 'package:dusty_flutter/scenes/lobby_scene.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart' hide Text;
import 'package:flutter/material.dart' hide Route, OverlayRoute;
import 'package:fluttertoast/fluttertoast.dart';
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

  PositionComponent? background;

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
          "login-dialog": OverlayRoute(transparent: false, (context, game) {
            final controller = TextEditingController();
            return Center(
              child: SizedBox(
                width: 400,
                height: 400,
                child: Card(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 48.0),
                        child: Text(
                          'Dusty Island',
                          style: TextStyle(
                            fontFamily: 'ONEMobilePOP',
                            fontSize: 56,
                            shadows: [
                              Shadow(
                                  // bottomLeft
                                  offset: Offset(-1.5, -1.5),
                                  color: Colors.black),
                              Shadow(
                                  // bottomRight
                                  offset: Offset(1.5, -1.5),
                                  color: Colors.black),
                              Shadow(
                                  // topRight
                                  offset: Offset(1.5, 1.5),
                                  color: Colors.black),
                              Shadow(
                                  // topLeft
                                  offset: Offset(-1.5, 1.5),
                                  color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 56,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 240,
                            child: TextField(
                              textAlign: TextAlign.center,
                              maxLength: 10,
                              controller: controller,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Input UserName',
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.white,
                                    )),
                              ),
                              style: const TextStyle(
                                fontFamily: 'ONEMobilePOP',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          FilledButton(
                              style: FilledButton.styleFrom(
                                fixedSize: const Size(96, 22),
                              ),
                              onPressed: () async {
                                try {
                                  final result = await Arbiter.api
                                      .loginByUserName(RequestLoginByUserName(
                                          userName:
                                              controller.value.text.trim()));
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setInt("playerId", result.id);
                                  await prefs.setString(
                                      "token", result.accessToken);
                                  await prefs.setString(
                                      "userName", result.userName);

                                  router.pop();
                                  router.pushReplacementNamed(
                                      LobbyScene.routerName);
                                } catch (e) {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Please try again in a few minutes.');
                                }
                              },
                              child: const Text(
                                "login",
                                style: TextStyle(
                                  fontFamily: 'ONEMobilePOP',
                                ),
                              )),
                        ],
                      ),
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

    TiledComponent.load('ultimate_map.tmx', Vector2.all(32)).then((value) {
      mapComponent = value;
      isLoadedMap = true;
    });
  }

  PlayScene _buildPlayScene() {
    // 맵을 줌할 때 등, 백그라운드 이미지가 보일 때가 있어서
    // 플레이씬에서는 백그라운드 이미지를 제거한다.
    _removeBackground();
    playScene = PlayScene();
    return playScene;
  }

  LoadingScene _buildLoadingScene() {
    _setBackground();
    loadingScene = LoadingScene(isReGame: isReGame);
    return loadingScene;
  }

  LobbyScene _buildLobbyScene() {
    _setBackground();
    lobbyScene = LobbyScene();
    return lobbyScene;
  }

  _setBackground() async {
    if (this.background != null) return;
    final backgroundImage = await Flame.images.load('background.png');
    final backgroundSprite = SpriteComponent.fromImage(backgroundImage);
    final background = PositionComponent(
      position:
          Vector2(gameRef.size.x * 0.5 - backgroundSprite.size.x * 0.5, 0),
      children: [backgroundSprite],
    );
    gameRef.add(background);
    this.background = background;
  }

  _removeBackground() {
    if (background == null) return;
    background!.removeFromParent();
    background = null;
  }
}

class DustyIslandGame extends FlameGame
    with
        HasCollisionDetection,
        SingleGameInstance,
        HasKeyboardHandlerComponents {
  FocusNode? focusNode;
  DustyIslandGame(this.focusNode) : super(world: DustyIslandWorld()) {
    super.pauseWhenBackgrounded = false;
  }

  // 이전 코드들과 호환성을 위한 getters
  PlayScene get playScene => world.playScene;
  LoadingScene get loadingScene => world.loadingScene;
  LobbyScene get lobbyScene => world.lobbyScene;
  RouterComponent get router => world.router;
  TextureAtlas get atlas => world.atlas;
  TiledComponent get mapComponent => world.mapComponent;
  bool get isVerified => world.isVerified;
  bool get isFinishLoadAllResource => world.isLoadedAtlas && world.isLoadedMap;

  double get canvasDiagonal => canvasSize.length;

  @override
  DustyIslandWorld get world => super.world as DustyIslandWorld;

  @override
  Color backgroundColor() {
    return gameBackgroundColor;
  }
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
