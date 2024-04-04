import 'dart:async';
import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/atlas/texture_atlas.dart';
import 'package:dusty_flutter/scenes/lobby_scene.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:dusty_flutter/worlds/loading.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart' hide Text;
import 'package:flutter/material.dart' hide Route, OverlayRoute;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DustyIslandWorld extends World with HasGameRef<DustyIslandGame> {
  late final RouterComponent router;

  late final PlayScene playScene;
  late final LobbyScene lobbyScene;

  bool isReGame = false;
  bool isVerified = false;

  PositionComponent? background;

  DustyIslandWorld(this.isVerified);
  factory DustyIslandWorld.reGame() => DustyIslandWorld(false)..isReGame = true;

  @override
  Future<void> onLoad() async {
    add(
      router = RouterComponent(
        initialRoute: 'login-dialog',
        routes: {
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
      ),
    );
  }

  PlayScene _buildPlayScene() {
    // 맵을 줌할 때 등, 백그라운드 이미지가 보일 때가 있어서
    // 플레이씬에서는 백그라운드 이미지를 제거한다.
    _removeBackground();
    playScene = PlayScene();
    return playScene;
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
  late TextureAtlas atlas;
  late TiledComponent mapComponent;

  DustyIslandGame(this.focusNode) : super(world: LoadingSceneWorld()) {
    super.pauseWhenBackgrounded = false;
  }

  // 이전 코드들과 호환성을 위한 getters
  PlayScene get playScene => (world as DustyIslandWorld).playScene;
  LobbyScene get lobbyScene => (world as DustyIslandWorld).lobbyScene;
  RouterComponent get router => (world as DustyIslandWorld).router;
  double get canvasDiagonal => canvasSize.length;

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
