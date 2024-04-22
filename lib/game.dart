import 'dart:async';

import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart'
    hide GameConfig;
import 'package:dusty_flutter/arbiter/live_service/socket.dart';
import 'package:dusty_flutter/atlas/texture_atlas.dart';
import 'package:dusty_flutter/camera.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:dusty_flutter/ui/flutter_overlay_dialogs.dart';
import 'package:dusty_flutter/worlds/loading.dart';
import 'package:dusty_flutter/worlds/lobby.dart';
import 'package:dusty_flutter/worlds/play.dart';
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

  DustyIslandGame(this.focusNode) : super(world: LoadingSceneWorld()) {
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
    Arbiter.liveService.close();
    super.onRemove();
  }

  @override
  Color backgroundColor() => gameBackgroundColor;

  Future<void> requestGameJoin({
    required Team team,
  }) async {
    // TODO ADD Team class
    final gameInfo =
        await Arbiter.api.joinGame(RequestGameJoin(team: team.name));
    await _prepareGame(
      map: gameInfo.map,
      team: team,
      config: gameInfo.gameConfig,
    );
    await _readyGame(
      team: team,
    );
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
    required String map,
    required Team team,
    required GameConfig config,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    PlaySceneWorld.selectedMap = _getMap(map);
    PlaySceneWorld.selectedTeam = team;
    PlaySceneWorld.playerId = prefs.getInt('playerId');

    //TODO game config
  }

  Future<void> _readyGame({
    required Team team,
  }) async {
    world = PlaySceneWorld(
      onReadyGame: () async {
        final connectAddress = await Arbiter.api.readyGame();
        await _connectGame(
          address: connectAddress,
          team: team,
        );
      },
    );
  }

  Future<void> _connectGame({
    required String address,
    required Team team,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    Arbiter.liveService.on(
      "/di/ws?token=$token&team=${team.code}",
      _startGame(),
      _finishGame(),
    );
  }

  Future<void> _disconnectGame() async {
    await Arbiter.liveService.close();
  }

  MessageCallbackType _startGame() {
    return (Map<String, dynamic> json) async {
      (world as PlaySceneWorld).handleGameMessage(GameMessage.fromJson(json));
    };
  }

  DonCallbackType _finishGame() {
    return (String? reason) async {
      // 에러로 인한 종료
      if (reason != null) {
        world = LobbySceneWorld();
        // 에러로 인한 게임 종료 시 처리 및 알람 처리
        return;
      }
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
