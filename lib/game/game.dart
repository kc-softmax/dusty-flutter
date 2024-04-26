import 'dart:async';

import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart'
    hide GameConfig;
import 'package:dusty_flutter/arbiter/live_service/socket.dart';
import 'package:dusty_flutter/game/atlas/texture_atlas.dart';
import 'package:dusty_flutter/game/cameras/camera.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:dusty_flutter/game/ui/overlays/flutter_overlay_dialogs.dart';
import 'package:dusty_flutter/game/worlds/loading.dart';
import 'package:dusty_flutter/game/worlds/lobby.dart';
import 'package:dusty_flutter/game/worlds/play.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart' hide Text;
import 'package:flutter/material.dart' hide Route, OverlayRoute;
import 'package:shared_preferences/shared_preferences.dart';

class DustyIslandGame extends FlameGame
    with
        HasCollisionDetection,
        SingleGameInstance,
        HasKeyboardHandlerComponents {
  FocusNode? focusNode;
  late TextureAtlas atlas;
  late bool isVerifiedAuth;
  late RouterComponent rootRouter;
  late TiledComponent defaultMap;
  //for Map Select Test
  late TiledComponent ultimateMap;

  DustyIslandGame([this.focusNode]) : super(world: LoadingSceneWorld()) {
    pauseWhenBackgrounded = false;
  }

  PlaySceneWorld? get playWorld {
    if (world is! PlaySceneWorld) return null;
    return world as PlaySceneWorld;
  }

  double get canvasDiagonal => canvasSize.length;

  Future<void> Function() get disconnectGame => _disconnectGame;

  DICamera get gameCamera {
    assert(world is PlaySceneWorld, '게임 중이 아닙니다.');
    return super.camera as DICamera;
  }

  @override
  FutureOr<void> onLoad() {
    rootRouter = RouterComponent(
      initialRoute: '/',
      routes: {
        '/': Route(() => Component()),
      },
    );
    add(rootRouter);
  }

  @override
  void onRemove() {
    _disconnectGame();
    super.onRemove();
  }

  @override
  Color backgroundColor() => gameBackgroundColor;

  Future<void> requestGameJoin({
    required Team team,
  }) async {
    final token = (await SharedPreferences.getInstance()).getString('token');
    if (token == null) return;
    final gameInfo =
        await Arbiter.api.joinGame(token, RequestGameJoin(team: team.name));

    await _prepareGame(
      gameInfo: gameInfo,
      team: team,
    );
    await world.loaded;

    final gameConnection = await Arbiter.api
        .readyGame(token, RequestGameReady(gameId: gameInfo.gameId));
    print(gameConnection);
    await _connectGame(connection: gameConnection);
  }

  TiledComponent _getMap(String map) {
    switch (map) {
      case 'ultimate':
        return ultimateMap;
      default:
        return defaultMap;
    }
  }

  Future<void> _prepareGame({
    required GameInfo gameInfo,
    required Team team,
  }) async {
    print('_prepareGame');
    final prefs = await SharedPreferences.getInstance();
    // TODO REMOVE
    // PlaySceneWorld.selectedMap = ultimateMap;
    PlaySceneWorld.selectedMap = _getMap(gameInfo.gameMap);
    PlaySceneWorld.selectedTeam = team;
    PlaySceneWorld.playerId = prefs.getInt('playerId');

    //TODO game config
    // ...
    world = PlaySceneWorld();
  }

  Future<void> _connectGame({
    required GameConnection connection,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    // TODO REMOVE
    // Arbiter.liveService.on(
    //   "/di/ws?token=$token&team=${1}",
    //   _startGame(),
    //   _finishGame(),
    // );
    Arbiter.liveService.on(
      "/di/ws?token=$token",
      _startGame(),
      _finishGame(),
    );
  }

  Future<void> _disconnectGame({String? reason}) async {
    await Arbiter.liveService.close(null, reason);
  }

  MessageCallbackType _startGame() {
    return (Map<String, dynamic> json) async {
      try {
        playWorld?.handleGameMessage(GameMessage.fromJson(json));
      } catch (e) {
        const reason = '게임 소켓 에러';
        _disconnectGame(reason: reason);
        throw Exception(reason);
      }
    };
  }

  DonCallbackType _finishGame() {
    return (String? reason) async {
      // 게임 닫기 다이얼로그를 보여준다.
      // 게임 닫기 다이얼로그는 랭킹 테이블, 다시하기 버튼, 나가기 버튼 으로 구성되어 있다.
      // 리턴값에 따라서 다시하기 로직 또는 나가기 로직을 실행한다.
      final isReGame = await rootRouter.pushAndWait(GameCloseDialog());
      if (isReGame) {
        await requestGameJoin(
          team: PlaySceneWorld.selectedTeam!,
        );
      } else {
        world = LobbySceneWorld();
      }
    };
  }
}
