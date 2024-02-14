import 'dart:async';
import 'dart:typed_data';
import 'dart:math';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/extensions/json.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/ui/joystick.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class Hud extends Component with HasGameRef<DustyIslandGame> {
  static final buttonSize = Vector2(56, 59);
  static final smallButtonSize = Vector2(44, 46);

  Joystick? joystick;
  HudButtonComponent? shieldButton;
  HudButtonComponent? boostButton;
  HudButtonComponent? activeButton;
  HudButtonComponent? specialButton;

  @override
  FutureOr<void> onLoad() {
    joystick = Joystick(
      knob: SpriteComponent(
        sprite: game.atlas.findSpriteByName('knob'),
        size: Vector2.all(40),
      ),
      background: SpriteComponent(
        sprite: game.atlas.findSpriteByName('joystick_bg'),
        size: Vector2.all(136),
      ),
      margin: const EdgeInsets.only(left: 44, bottom: 44),
      onMovedJoystick: _onMovedJoyStick,
    );

    shieldButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('circle_button'),
        size: buttonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: game.atlas.findSpriteByName('press_circle_button'),
        size: buttonSize,
      ),
      margin: const EdgeInsets.only(
        right: 68,
        bottom: 65,
      ),
      onPressed: _onPressedShieldButton,
    );

    boostButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('small_circle_button'),
        size: smallButtonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: game.atlas.findSpriteByName('press_small_circle_button'),
        size: smallButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 144,
        bottom: 38,
      ),
      onPressed: _onPressedBoostButton,
    );

    activeButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('small_circle_button'),
        size: smallButtonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: game.atlas.findSpriteByName('press_small_circle_button'),
        size: smallButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 144,
        bottom: 108,
      ),
      onPressed: _onPressedActiveButton,
    );

    specialButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: game.atlas.findSpriteByName('small_circle_button'),
        size: smallButtonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: game.atlas.findSpriteByName('press_small_circle_button'),
        size: smallButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 88,
        bottom: 150,
      ),
      onPressed: _onPressedSpecialButton,
    );

    gameRef.camera.viewport.addAll([
      joystick!,
      shieldButton!,
      boostButton!,
      activeButton!,
      specialButton!,
    ]);
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

    int action = -1;
    if (delta.isZero()) {
      action = DustyAction.stop;
    } else {
      const double twelveOfPi = pi / 12;
      var knobAngle = delta.screenAngle();
      knobAngle = knobAngle < 0 ? 2 * pi + knobAngle : knobAngle;
      if (knobAngle >= 0 && knobAngle <= twelveOfPi) {
        action = 12; // top
      } else if (knobAngle > 1 * twelveOfPi && knobAngle <= 3 * twelveOfPi) {
        action = 1;
      } else if (knobAngle > 3 * twelveOfPi && knobAngle <= 5 * twelveOfPi) {
        action = 2;
      } else if (knobAngle > 5 * twelveOfPi && knobAngle <= 7 * twelveOfPi) {
        action = 3;
      } else if (knobAngle > 7 * twelveOfPi && knobAngle <= 9 * twelveOfPi) {
        action = 4;
      } else if (knobAngle > 9 * twelveOfPi && knobAngle <= 11 * twelveOfPi) {
        action = 5;
      } else if (knobAngle > 11 * twelveOfPi && knobAngle <= 13 * twelveOfPi) {
        action = 6;
      } else if (knobAngle > 13 * twelveOfPi && knobAngle <= 15 * twelveOfPi) {
        action = 7;
      } else if (knobAngle > 15 * twelveOfPi && knobAngle <= 17 * twelveOfPi) {
        action = 8;
      } else if (knobAngle > 17 * twelveOfPi && knobAngle <= 19 * twelveOfPi) {
        action = 9;
      } else if (knobAngle > 19 * twelveOfPi && knobAngle <= 21 * twelveOfPi) {
        action = 10;
      } else if (knobAngle > 21 * twelveOfPi && knobAngle <= 23 * twelveOfPi) {
        action = 11;
      } else if (knobAngle > 23 * twelveOfPi) {
        action = 12;
      } else {
        action = DustyAction.stop;
      }
    }
    if (action > 0) {
      Arbiter.liveService.sendByte(Uint8List.fromList([action]).buffer);
    }
  }

  void _onPressedShieldButton() {
    Arbiter.liveService
        .sendByte(Uint8List.fromList([DustyAction.shield]).buffer);
    debugPrint("press shield button");
  }

  void _onPressedBoostButton() {
    debugPrint("press boost button");
  }

  void _onPressedActiveButton() {
    debugPrint("press active button");
  }

  void _onPressedSpecialButton() {
    debugPrint("press special button");
  }
}
