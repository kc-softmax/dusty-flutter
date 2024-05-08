import 'dart:async';
import 'dart:math';

import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/game/ui/hud/joystick.dart';
import 'package:dusty_flutter/game/worlds/play.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

abstract class ControllerHandler extends Component
    with KeyboardHandler, HasGameRef<DustyIslandGame> {
  late final Joystick joystick;

  void onPressedDigit1();
  void onPressedDigit2();
  void onPressedDigit3();
  void onPressedDigit4();

  @mustCallSuper
  @override
  FutureOr<void> onLoad() {
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
  }

  void _onMovedJoyStick() {
    // TODO refactor this to use a more elegant solution
    // Since screenAngle and angleTo doesn't care about "direction" of the angle
    // we have to use angleToSigned and create an only increasing angle by
    // removing negative angles from 2*pi.
    final delta = joystick.delta;
    DustyAction action = DustyAction.stop;
    if (delta.isZero()) {
      action = DustyAction.stop;
    } else {
      const double twelveOfPi = pi / 12;
      var knobAngle = delta.screenAngle();
      knobAngle = knobAngle < 0 ? 2 * pi + knobAngle : knobAngle;
      if (knobAngle >= 0 && knobAngle <= twelveOfPi) {
        action = DustyAction.n; // top
      } else if (knobAngle > 1 * twelveOfPi && knobAngle <= 3 * twelveOfPi) {
        action = DustyAction.ne;
      } else if (knobAngle > 3 * twelveOfPi && knobAngle <= 5 * twelveOfPi) {
        action = DustyAction.e;
      } else if (knobAngle > 5 * twelveOfPi && knobAngle <= 7 * twelveOfPi) {
        action = DustyAction.se;
      } else if (knobAngle > 7 * twelveOfPi && knobAngle <= 9 * twelveOfPi) {
        action = DustyAction.s;
      } else if (knobAngle > 9 * twelveOfPi && knobAngle <= 11 * twelveOfPi) {
        action = DustyAction.sw;
      } else if (knobAngle > 11 * twelveOfPi && knobAngle <= 13 * twelveOfPi) {
        action = DustyAction.w;
      } else if (knobAngle > 13 * twelveOfPi && knobAngle <= 15 * twelveOfPi) {
        action = DustyAction.nw;
      } else if (knobAngle > 15 * twelveOfPi && knobAngle <= 17 * twelveOfPi) {
        // action = DustyAction.eight;
      } else if (knobAngle > 17 * twelveOfPi && knobAngle <= 19 * twelveOfPi) {
        // action = DustyAction.nine;
      } else if (knobAngle > 19 * twelveOfPi && knobAngle <= 21 * twelveOfPi) {
        // action = DustyAction.ten;
      } else if (knobAngle > 21 * twelveOfPi && knobAngle <= 23 * twelveOfPi) {
        // action = DustyAction.eleven;
      } else if (knobAngle > 23 * twelveOfPi) {
        // action = DustyAction.twelve;
      } else {
        action = DustyAction.stop;
      }
    }
    final currentWorld = gameRef.world;
    if (currentWorld is! PlaySceneWorld) throw ('게임 플레이 중이 아닙니다.');
    currentWorld.player!.targetDirectionIndex = action.code;
    Arbiter.liveService.sendByte(action.encode());
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (!kIsWeb) return false;
    // 스킬 버튼
    if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.digit1)) {
      onPressedDigit1();
    } else if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.digit2)) {
      onPressedDigit2();
    } else if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.digit3)) {
      onPressedDigit3();
    } else if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.digit4)) {
      onPressedDigit4();
    }

    if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.space)) {
      final isKeyDown = event is KeyDownEvent;
      final isKeyUp = event is KeyUpEvent;

      if (isKeyDown) {
        Arbiter.liveService.sendByte(DustyAction.activeSkillDown.encode());
      } else if (isKeyUp) {
        Arbiter.liveService.sendByte(DustyAction.activeSkillUp.encode());
      }
    }

    // 더스티 움직임
    DustyAction action = DustyAction.stop;

    if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.keyW) &&
        !keysPressed.contains(LogicalKeyboardKey.keyD) &&
        !keysPressed.contains(LogicalKeyboardKey.keyA)) {
      action = DustyAction.n;
    } else if (keysPressed.isNotEmpty &&
        keysPressed
            .containsAll([LogicalKeyboardKey.keyW, LogicalKeyboardKey.keyD])) {
      action = DustyAction.ne;
    } else if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.keyD) &&
        !keysPressed.contains(LogicalKeyboardKey.keyW) &&
        !keysPressed.contains(LogicalKeyboardKey.keyS)) {
      action = DustyAction.e;
    } else if (keysPressed.isNotEmpty &&
        keysPressed
            .containsAll([LogicalKeyboardKey.keyD, LogicalKeyboardKey.keyS])) {
      action = DustyAction.se;
    } else if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.keyS) &&
        !keysPressed.contains(LogicalKeyboardKey.keyA) &&
        !keysPressed.contains(LogicalKeyboardKey.keyD)) {
      action = DustyAction.s;
    } else if (keysPressed.isNotEmpty &&
        keysPressed
            .containsAll([LogicalKeyboardKey.keyS, LogicalKeyboardKey.keyA])) {
      action = DustyAction.sw;
    } else if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.keyA) &&
        !keysPressed.contains(LogicalKeyboardKey.keyW) &&
        !keysPressed.contains(LogicalKeyboardKey.keyS)) {
      action = DustyAction.w;
    } else if (keysPressed.isNotEmpty &&
        keysPressed
            .containsAll([LogicalKeyboardKey.keyA, LogicalKeyboardKey.keyW])) {
      action = DustyAction.nw;
    } else {
      action = DustyAction.stop;
    }

    final currentWorld = gameRef.world;
    if (currentWorld is! PlaySceneWorld) throw ('게임 플레이 중이 아닙니다.');
    currentWorld.player!.targetDirectionIndex = action.getDirectionIndex();

    Arbiter.liveService.sendByte(action.encode());
    return false;
  }
}
