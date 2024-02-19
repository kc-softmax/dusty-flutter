import 'dart:async';
import 'dart:math';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/buttons/dusty_hud_button.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/ui/joystick.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Hud extends Component with HasGameRef<DustyIslandGame> {
  static final buttonSize = Vector2(56, 59);
  static final smallButtonSize = Vector2(44, 46);

  Joystick? joystick;
  DustyHudButton? shieldButton;
  DustyHudButton? boostButton;
  DustyHudButton? activeButton;
  DustyHudButton? specialButton;
  DustyAction lastAction = DustyAction.idle;

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

    shieldButton = DustyHudButton(
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
    boostButton = DustyHudButton(
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

    activeButton = DustyHudButton(
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
    // ..anchor = Anchor.center;

    specialButton = DustyHudButton(
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
    // ..anchor = Anchor.center;

    gameRef.camera.viewport.addAll([
      joystick!,
      shieldButton!,
      boostButton!,
      activeButton!,
      specialButton!,
    ]);

    gameRef.overlays.addEntry('counter', (context, game) {
      return Padding(
          padding: const EdgeInsets.only(
            right: 144,
            bottom: 38,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(width: 64.0, height: 32),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Horizon',
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText(
                      '5',
                      transitionHeight: 32,
                      duration: const Duration(milliseconds: 1000),
                    ),
                    RotateAnimatedText(
                      '4',
                      transitionHeight: 32,
                      duration: const Duration(milliseconds: 1000),
                    ),
                    RotateAnimatedText(
                      '3',
                      transitionHeight: 32,
                      duration: const Duration(milliseconds: 1000),
                    ),
                    RotateAnimatedText(
                      '2',
                      transitionHeight: 32,
                      duration: const Duration(milliseconds: 1000),
                    ),
                    RotateAnimatedText(
                      '1',
                      transitionHeight: 32,
                      duration: const Duration(milliseconds: 1000),
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
    gameRef.overlays.add('counter');
  }

  void updateHud(DustyMessage message) {
    activeButton?.updateAvailable(message.activeAvailable);
    specialButton?.updateAvailable(message.specialAvailable);
    boostButton?.updateAvailable(message.boostAvailable);
    shieldButton?.updateAvailable(message.shieldAvailable);
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
    if (action != DustyAction.idle && action != lastAction) {
      lastAction = action;
      Arbiter.liveService.sendByte(action.encode());
    }
  }

  void _onPressedShieldButton() {
    Arbiter.liveService.sendByte(DustyAction.shield.encode());
    debugPrint("press shield button");
  }

  void _onPressedBoostButton() {
    debugPrint("press boost button");
    Arbiter.liveService.sendByte(DustyAction.boost.encode());
  }

  void _onPressedActiveButton() {
    debugPrint("press active button");
    Arbiter.liveService.sendByte(DustyAction.activeSkill.encode());
  }

  void _onPressedSpecialButton() {
    debugPrint("press special button");
    Arbiter.liveService.sendByte(DustyAction.specialSkill.encode());
  }
}
