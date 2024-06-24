import 'dart:async';

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

  Map<DustyAction, double> chargeMap = {};

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

  void onPressedDigit1(KeyEvent event);
  void onPressedDigit2(KeyEvent event);

  void _onMovedJoyStick() {
    // TODO refactor this to use a more elegant solution
    // Since screenAngle and angleTo doesn't care about "direction" of the angle
    // we have to use angleToSigned and create an only increasing angle by
    // removing negative angles from 2*pi.
    // final delta = joystick.delta;
    // DustyAction action = DustyAction.stop;
    // if (delta.isZero()) {
    //   action = DustyAction.stop;
    // } else {
    //   const double twelveOfPi = pi / 12;
    //   var knobAngle = delta.screenAngle();
    //   knobAngle = knobAngle < 0 ? 2 * pi + knobAngle : knobAngle;
    //   if (knobAngle >= 0 && knobAngle <= twelveOfPi) {
    //     action = DustyAction.n; // top
    //   } else if (knobAngle > 1 * twelveOfPi && knobAngle <= 3 * twelveOfPi) {
    //     action = DustyAction.ne;
    //   } else if (knobAngle > 3 * twelveOfPi && knobAngle <= 5 * twelveOfPi) {
    //     action = DustyAction.e;
    //   } else if (knobAngle > 5 * twelveOfPi && knobAngle <= 7 * twelveOfPi) {
    //     action = DustyAction.se;
    //   } else if (knobAngle > 7 * twelveOfPi && knobAngle <= 9 * twelveOfPi) {
    //     action = DustyAction.s;
    //   } else if (knobAngle > 9 * twelveOfPi && knobAngle <= 11 * twelveOfPi) {
    //     action = DustyAction.sw;
    //   } else if (knobAngle > 11 * twelveOfPi && knobAngle <= 13 * twelveOfPi) {
    //     action = DustyAction.w;
    //   } else if (knobAngle > 13 * twelveOfPi && knobAngle <= 15 * twelveOfPi) {
    //     action = DustyAction.nw;
    //   } else if (knobAngle > 15 * twelveOfPi && knobAngle <= 17 * twelveOfPi) {
    //     // action = DustyAction.eight;
    //   } else if (knobAngle > 17 * twelveOfPi && knobAngle <= 19 * twelveOfPi) {
    //     // action = DustyAction.nine;
    //   } else if (knobAngle > 19 * twelveOfPi && knobAngle <= 21 * twelveOfPi) {
    //     // action = DustyAction.ten;
    //   } else if (knobAngle > 21 * twelveOfPi && knobAngle <= 23 * twelveOfPi) {
    //     // action = DustyAction.eleven;
    //   } else if (knobAngle > 23 * twelveOfPi) {
    //     // action = DustyAction.twelve;
    //   } else {
    //     action = DustyAction.stop;
    //   }
    // }
    // final currentWorld = gameRef.world;
    // if (currentWorld is! PlaySceneWorld) throw ('게임 플레이 중이 아닙니다.');
    // currentWorld.player!.targetDirectionIndex = action.code;
    // Arbiter.liveService.sendByte(action.encode());
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (!kIsWeb) return false;
    // 미니맵
    if (event is KeyUpEvent && event.physicalKey == PhysicalKeyboardKey.tab) {
      gameRef.gameCamera.hud.minimap.scaleToFull();
    }

    // 스킬 버튼
    if (event.physicalKey == PhysicalKeyboardKey.digit1) {
      onPressedDigit1(event);
    }
    if (event.physicalKey == PhysicalKeyboardKey.digit2) {
      onPressedDigit2(event);
    }

    // 더스티 움직임
    // Dusty
    Direction direction = Direction.none;

    if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.keyW) &&
        !keysPressed.contains(LogicalKeyboardKey.keyD) &&
        !keysPressed.contains(LogicalKeyboardKey.keyA)) {
      direction = Direction.n;
    } else if (keysPressed.isNotEmpty &&
        keysPressed
            .containsAll([LogicalKeyboardKey.keyW, LogicalKeyboardKey.keyD])) {
      direction = Direction.ne;
    } else if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.keyD) &&
        !keysPressed.contains(LogicalKeyboardKey.keyW) &&
        !keysPressed.contains(LogicalKeyboardKey.keyS)) {
      direction = Direction.e;
    } else if (keysPressed.isNotEmpty &&
        keysPressed
            .containsAll([LogicalKeyboardKey.keyD, LogicalKeyboardKey.keyS])) {
      direction = Direction.se;
    } else if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.keyS) &&
        !keysPressed.contains(LogicalKeyboardKey.keyA) &&
        !keysPressed.contains(LogicalKeyboardKey.keyD)) {
      direction = Direction.s;
    } else if (keysPressed.isNotEmpty &&
        keysPressed
            .containsAll([LogicalKeyboardKey.keyS, LogicalKeyboardKey.keyA])) {
      direction = Direction.sw;
    } else if (keysPressed.isNotEmpty &&
        keysPressed.contains(LogicalKeyboardKey.keyA) &&
        !keysPressed.contains(LogicalKeyboardKey.keyW) &&
        !keysPressed.contains(LogicalKeyboardKey.keyS)) {
      direction = Direction.w;
    } else if (keysPressed.isNotEmpty &&
        keysPressed
            .containsAll([LogicalKeyboardKey.keyA, LogicalKeyboardKey.keyW])) {
      direction = Direction.nw;
    }
    final currentWorld = gameRef.world;
    if (currentWorld is! PlaySceneWorld) throw ('게임 플레이 중이 아닙니다.');
    // currentWorld.player!.updateTargetDirection(action.getDirectionIndex());
    gameRef.gameSocketConnection
        .send(ControlAction.immediateControl.encode(value: direction.code));
    return false;
  }
}
