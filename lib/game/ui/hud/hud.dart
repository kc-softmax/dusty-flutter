import 'dart:async';

import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_connection/game_event.dart';
import 'package:dusty_flutter/game/ui/hud/minimap.dart';
import 'package:dusty_flutter/game/ui/hud/skill_button.dart';
import 'package:dusty_flutter/game/ui/hud/controller_handler.dart';
import 'package:dusty_flutter/game/ui/hud/kill_logs.dart';
import 'package:dusty_flutter/game/ui/hud/player_kill_logs.dart';
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Viewport;
import 'package:flutter/services.dart';

class Hud extends ControllerHandler {
  final GameInfo gameInfo;
  final Viewport viewport;
  final TiledComponent gameMap;

  late final TextComponent informationText;
  late final PlayerKillLogsComponent playerKillLogs;
  late final KillLogsComponent killLogs;
  late final DefaultSkillButton defaultSkillButton1;
  late final DefaultSkillButton defaultSkillButton2;
  late final SkillButton specialSkillButton1;
  late final SkillButton specialSkillButton2;
  late final SkillButton specialSkillButton3;
  late final SkillButton specialSkillButton4;
  late final Minimap minimap;

  Hud({
    required this.gameInfo,
    required this.viewport,
    required this.gameMap,
  });

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    if (!kIsWeb) {
      _setJoystick();
    }
    _setInformationText();
    _setPlayerKillLogs();
    _setKillLogs();
    _setSkillButtons();
    _setMinimap();
  }

  @override
  void onPressedDigit1(KeyEvent event) {
    if (event is KeyDownEvent) {
      gameRef.gameSocketConnection.send(
          ControlAction.active.encode(value: DustyAction.activeSkillDown.code));
    } else if (event is KeyUpEvent) {
      gameRef.gameSocketConnection.send(
          ControlAction.active.encode(value: DustyAction.activeSkillUp.code));
    }
    // specialSkillButton1.onPressed?.call();
  }

  @override
  void onPressedDigit2(KeyEvent event) {
    if (event is KeyDownEvent) {
      gameRef.gameSocketConnection.send(ControlAction.active
          .encode(value: DustyAction.specialSkillDown.code));
      gameRef.playWorld?.dustyFactory.addUserIngameUpdateEvent(
        [const StateData(state: ObjectState.charging)],
      );
    } else if (event is KeyUpEvent) {
      gameRef.gameSocketConnection.send(
          ControlAction.active.encode(value: DustyAction.specialSkillUp.code));
    }
  }

  void updateSystemEvent(SystemEvent message) {}

  void updateHud(DustyEvent message) {}

  void _setJoystick() {
    viewport.add(joystick);
  }

  void _setInformationText() {
    informationText = TextComponent(
      text: "",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(1, 1),
              blurRadius: 1,
            ),
          ],
        ),
      ),
    )
      ..position = gameRef.size / 2
      ..anchor = Anchor.center;
    viewport.add(informationText);
  }

  void _setPlayerKillLogs() {
    playerKillLogs = PlayerKillLogsComponent()
      ..x = gameRef.size.x / 2
      ..y = gameRef.size.y / 2 - 48;
    viewport.add(playerKillLogs);
  }

  void _setKillLogs() {
    killLogs = KillLogsComponent(
      margin: const EdgeInsets.only(left: 44, top: 22),
    );
    viewport.add(killLogs);
  }

  void _setSkillButtons() {
    final container = PositionComponent();

    defaultSkillButton1 = DefaultSkillButton(
      cooltime: 3,
      skillIcon: 'skill_icon',
      onClick: () {
        print('default button1 click!!');
      },
    );
    defaultSkillButton2 = DefaultSkillButton(
      cooltime: 5,
    );

    specialSkillButton1 = SkillButton(
      showCount: true,
      onClick: () {
        defaultSkillButton2.delegate = specialSkillButton1;
      },
      action: () {
        print('special skill 1 used!');
      },
    );
    specialSkillButton2 = SkillButton(
      showCount: true,
      onClick: () {
        defaultSkillButton2.delegate = specialSkillButton2;
      },
      action: () {
        print('special skill 2 used!');
      },
    );
    specialSkillButton3 = SkillButton(
      showCount: true,
      onClick: () {
        defaultSkillButton2.delegate = specialSkillButton3;
      },
      action: () {
        print('special skill 3 used!');
      },
    );
    specialSkillButton4 = SkillButton(
      showCount: true,
      onClick: () {
        defaultSkillButton2.delegate = specialSkillButton4;
      },
      action: () {
        print('special skill 4 used!');
      },
    );

    container.addAll([
      defaultSkillButton1,
      specialSkillButton1,
      specialSkillButton2,
      specialSkillButton3,
      specialSkillButton4,
      defaultSkillButton2,
    ]);

    specialSkillButton1.position = Vector2(
      defaultSkillButton1.width + 11,
      (defaultSkillButton1.height - specialSkillButton1.height) * 0.5,
    );
    specialSkillButton2.position = Vector2(
      specialSkillButton1.toRect().right,
      (defaultSkillButton1.height - specialSkillButton2.height) * 0.5,
    );
    specialSkillButton3.position = Vector2(
      specialSkillButton2.toRect().right,
      (defaultSkillButton1.height - specialSkillButton3.height) * 0.5,
    );
    specialSkillButton4.position = Vector2(
      specialSkillButton3.toRect().right,
      (defaultSkillButton1.height - specialSkillButton4.height) * 0.5,
    );
    defaultSkillButton2.position = Vector2(
      specialSkillButton4.toRect().right + 11,
      0,
    );

    viewport.add(
      container
        ..size = Vector2(
            defaultSkillButton2.toRect().right, defaultSkillButton2.height)
        ..center = Vector2(viewport.size.x * 0.5, viewport.size.y - 85),
    );
  }

  void _setMinimap() {
    viewport.add(minimap = Minimap(
      size: Vector2.all(240),
      position: Vector2(gameRef.canvasSize.x - 240 - 10, 10),
      range: 1,
    ));
  }
}
