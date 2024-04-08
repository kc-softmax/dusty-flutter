import 'dart:async';
import 'dart:math';

import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/ui/buttons/skill_button.dart';
import 'package:dusty_flutter/ui/joystick.dart';
import 'package:dusty_flutter/ui/kill_logs.dart';
import 'package:dusty_flutter/ui/player_kill_logs.dart';
import 'package:dusty_flutter/worlds/play.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Viewport;
import 'package:flutter/services.dart';

class Hud2 extends Component with HasGameRef<DustyIslandGame>, KeyboardHandler {
  final GameConfig gameConfig;
  final Viewport viewport;

  late final Joystick? joystick;
  late final TextComponent informationText;
  late final PlayerKillLogsComponent playerKillLogs;
  late final KillLogsComponent killLogs;
  late final SkillButton defaultSkillButton1;
  late final SkillButton defaultSkillButton2;
  late final SkillButton specialSkillButton1;
  late final SkillButton specialSkillButton2;
  late final SkillButton specialSkillButton3;
  late final SkillButton specialSkillButton4;

  Hud2({
    super.children,
    super.priority,
    super.key,
    required this.gameConfig,
    required this.viewport,
  });

  @override
  FutureOr<void> onLoad() {
    if (!kIsWeb) {
      _setJoystick();
    }
    _setInformationText();
    _setPlayerKillLogs();
    _setKillLogs();
    _setSkillButtons();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (!kIsWeb) return false;

    DustyAction action = DustyAction.idle;

    if (keysPressed.length == 1 &&
        keysPressed.first == LogicalKeyboardKey.arrowUp) {
      action = DustyAction.twelve;
    } else if (keysPressed.length == 2 &&
        keysPressed.containsAll(
            [LogicalKeyboardKey.arrowUp, LogicalKeyboardKey.arrowRight])) {
      action = DustyAction.one;
    } else if (keysPressed.length == 1 &&
        keysPressed.first == LogicalKeyboardKey.arrowRight) {
      action = DustyAction.three;
    } else if (keysPressed.length == 2 &&
        keysPressed.containsAll(
            [LogicalKeyboardKey.arrowRight, LogicalKeyboardKey.arrowDown])) {
      action = DustyAction.five;
    } else if (keysPressed.length == 1 &&
        keysPressed.first == LogicalKeyboardKey.arrowDown) {
      action = DustyAction.six;
    } else if (keysPressed.length == 2 &&
        keysPressed.containsAll(
            [LogicalKeyboardKey.arrowDown, LogicalKeyboardKey.arrowLeft])) {
      action = DustyAction.seven;
    } else if (keysPressed.length == 1 &&
        keysPressed.first == LogicalKeyboardKey.arrowLeft) {
      action = DustyAction.nine;
    } else if (keysPressed.length == 2 &&
        keysPressed.containsAll(
            [LogicalKeyboardKey.arrowLeft, LogicalKeyboardKey.arrowUp])) {
      action = DustyAction.eleven;
    } else {
      action = DustyAction.stop;
    }
    final currentWorld = gameRef.world;
    if (currentWorld is! PlaySceneWorld) throw ('게임 플레이 중이 아닙니다.');
    currentWorld.player!.targetDirectionIndex = action.code;
    Arbiter.liveService.sendByte(action.encode());
    return true;
  }

  void _setJoystick() {
    joystick = Joystick(
      knob: SpriteComponent(
        sprite: game.atlas.findSpriteByName('knob'),
        size: Vector2.all(gameRef.size.y * 0.1),
      ),
      background: SpriteComponent(
        sprite: game.atlas.findSpriteByName('joystick_bg'),
        size: Vector2.all(gameRef.size.y * 0.45),
      ),
      margin: const EdgeInsets.only(left: 66, bottom: 22),
      onMovedJoystick: _onMovedJoyStick,
    );
    viewport.add(joystick!);
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

    defaultSkillButton1 = SkillButton(
      skillButtonSize: SkillButtonSize.big,
      cooltime: 3,
      onClick: () {
        print('click!!');
      },
    );
    defaultSkillButton2 = SkillButton(
      skillButtonSize: SkillButtonSize.big,
      cooltime: 3,
      onClick: () {
        print('click!!');
      },
    );
    specialSkillButton1 = SkillButton(
      cooltime: 3,
      showCount: true,
      onClick: () {
        print('click!!');
      },
    );
    specialSkillButton2 = SkillButton(
      cooltime: 3,
      showCount: true,
      onClick: () {
        print('click!!');
        // test change skill icon
        defaultSkillButton2.skillIcon = 'raft';
      },
    );
    specialSkillButton3 = SkillButton(
      cooltime: 3,
      showCount: true,
      onClick: () {
        print('click!!');
      },
    );
    specialSkillButton4 = SkillButton(
      cooltime: 3,
      showCount: true,
      onClick: () {
        print('click!!');
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

  void _onMovedJoyStick() {
    // TODO refactor this to use a more elegant solution
    // Since screenAngle and angleTo doesn't care about "direction" of the angle
    // we have to use angleToSigned and create an only increasing angle by
    // removing negative angles from 2*pi.
    final delta = joystick?.delta;
    if (delta == null) {
      return;
    }

    DustyAction action = DustyAction.idle;
    if (delta.isZero()) {
      action = DustyAction.stop;
    } else {
      const double twelveOfPi = pi / 12;
      var knobAngle = delta.screenAngle();
      knobAngle = knobAngle < 0 ? 2 * pi + knobAngle : knobAngle;
      if (knobAngle >= 0 && knobAngle <= twelveOfPi) {
        action = DustyAction.twelve; // top
      } else if (knobAngle > 1 * twelveOfPi && knobAngle <= 3 * twelveOfPi) {
        action = DustyAction.one;
      } else if (knobAngle > 3 * twelveOfPi && knobAngle <= 5 * twelveOfPi) {
        action = DustyAction.two;
      } else if (knobAngle > 5 * twelveOfPi && knobAngle <= 7 * twelveOfPi) {
        action = DustyAction.three;
      } else if (knobAngle > 7 * twelveOfPi && knobAngle <= 9 * twelveOfPi) {
        action = DustyAction.four;
      } else if (knobAngle > 9 * twelveOfPi && knobAngle <= 11 * twelveOfPi) {
        action = DustyAction.five;
      } else if (knobAngle > 11 * twelveOfPi && knobAngle <= 13 * twelveOfPi) {
        action = DustyAction.six;
      } else if (knobAngle > 13 * twelveOfPi && knobAngle <= 15 * twelveOfPi) {
        action = DustyAction.seven;
      } else if (knobAngle > 15 * twelveOfPi && knobAngle <= 17 * twelveOfPi) {
        action = DustyAction.eight;
      } else if (knobAngle > 17 * twelveOfPi && knobAngle <= 19 * twelveOfPi) {
        action = DustyAction.nine;
      } else if (knobAngle > 19 * twelveOfPi && knobAngle <= 21 * twelveOfPi) {
        action = DustyAction.ten;
      } else if (knobAngle > 21 * twelveOfPi && knobAngle <= 23 * twelveOfPi) {
        action = DustyAction.eleven;
      } else if (knobAngle > 23 * twelveOfPi) {
        action = DustyAction.twelve;
      } else {
        action = DustyAction.stop;
      }
    }
    final currentWorld = gameRef.world;
    if (currentWorld is! PlaySceneWorld) throw ('게임 플레이 중이 아닙니다.');
    currentWorld.player!.targetDirectionIndex = action.code;
    Arbiter.liveService.sendByte(action.encode());
  }

  void updateSystemMessage(SystemMessage message) {}

  void updateHud(DustyMessage message) {}
}
