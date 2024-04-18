import 'dart:async';

import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/ui/hud/minimap.dart';
import 'package:dusty_flutter/ui/hud/skill_button.dart';
import 'package:dusty_flutter/ui/hud/controller_handler.dart';
import 'package:dusty_flutter/ui/hud/kill_logs.dart';
import 'package:dusty_flutter/ui/hud/player_kill_logs.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Viewport;

class Hud2 extends ControllerHandler {
  final GameConfig gameConfig;
  final Viewport viewport;

  late final TextComponent informationText;
  late final PlayerKillLogsComponent playerKillLogs;
  late final KillLogsComponent killLogs;
  late final DefaultSkillButton defaultSkillButton1;
  late final DefaultSkillButton defaultSkillButton2;
  late final SkillButton specialSkillButton1;
  late final SkillButton specialSkillButton2;
  late final SkillButton specialSkillButton3;
  late final SkillButton specialSkillButton4;
  late final MinimapCamera minimapCamera;

  Hud2({
    required this.gameConfig,
    required this.viewport,
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
  void onPressedDigit1() {
    specialSkillButton1.onPressed?.call();
  }

  @override
  void onPressedDigit2() {
    specialSkillButton2.onPressed?.call();
  }

  @override
  void onPressedDigit3() {
    specialSkillButton3.onPressed?.call();
  }

  @override
  void onPressedDigit4() {
    specialSkillButton4.onPressed?.call();
  }

  void updateSystemMessage(SystemMessage message) {}

  void updateHud(DustyMessage message) {}

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
    minimapCamera = MinimapCamera(
      position: Vector2(
        gameRef.canvasSize.x - 240 - 20,
        20,
      ),
      width: 240,
      height: 240,
    );
    viewport.add(minimapCamera);
  }
}
