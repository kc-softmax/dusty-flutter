import 'dart:async';

import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
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
  late TiledComponent mapComponent;
  late bool isVerifiedAuth;
  late RouterComponent rootRouter;

  DustyIslandGame(this.focusNode) : super(world: LoadingSceneWorld()) {
    pauseWhenBackgrounded = false;
  }

  PlaySceneWorld? get playWorld {
    if (world is! PlaySceneWorld) return null;
    return world as PlaySceneWorld;
  }

  double get canvasDiagonal => canvasSize.length;

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
  Color backgroundColor() => gameBackgroundColor;

  void connectGame({
    required Team selectedTeam,
    bool isRegame = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final playerId = prefs.getInt('playerId');
    Arbiter.liveService.on(
      "/di/ws?token=$token&team=${selectedTeam.code}",
      _startGame(selectedTeam, playerId!, isRegame),
      _finishGame,
    );
  }

  void disconnectGame() {
    Arbiter.liveService.close();
  }

  MessageCallbackType _startGame(Team team, int playerId, bool isRegame) {
    PlaySceneWorld.playerId = playerId;
    PlaySceneWorld.selectedTeam = team;
    return (Map<String, dynamic> json) async {
      // 맵 이름에 따라 맵 컴포넌트를 월드에 전달하여 게임 시작
      // 지금은 임시로 world의 타입을 검사하여 시작
      if (world is! PlaySceneWorld || isRegame) {
        // 게임 맵 이름 파싱
        // ..
        PlaySceneWorld.selectedMap = mapComponent;
        world = PlaySceneWorld();

        //world가 교체되는데 시간이 필요한데 반해, 메시지는 바로 온다.
        //지금 상황에서는 약간의 텀이 필요함.
        //또는 준비됨 메시지를 서버에게 보내준다.
      }
      (world as PlaySceneWorld).handleGameMessage(GameMessage.fromJson(json));
    };
  }

  void _finishGame(String? reason) async {
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
      // temp
      connectGame(
        selectedTeam: PlaySceneWorld.selectedTeam!,
        isRegame: true,
      );
    } else {
      world = LobbySceneWorld();
    }
  }
}
