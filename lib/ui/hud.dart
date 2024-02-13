import 'dart:async';
import 'package:dusty_flutter/game.dart';
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
    debugPrint("jostick moved!!! ${joystick?.direction}");
  }

  void _onPressedShieldButton() {
    // Arbiter.liveService.sendByte('{"hello": 2}'.toByteBuffer());
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
