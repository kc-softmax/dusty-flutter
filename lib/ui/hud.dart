import 'dart:async';

import 'package:dusty_flutter/characters/const.dart';
import 'package:dusty_flutter/effects/const.dart';
import 'package:dusty_flutter/effects/default_explosion.dart';
import 'package:dusty_flutter/effects/thunder_effect.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/ui/joystick.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class Hud extends Component with HasGameRef<DustyIslandGame> {
  static final buttonSize = Vector2(56, 59);
  static final smallButtonSize = Vector2(44, 46);

  JoystickComponent? joystick;

  @override
  FutureOr<void> onLoad() {
    final player = gameRef.playScene.player;

    joystick = NotifiableJoyStick(
      knob: SpriteComponent(
        sprite: game.atlas.findSpriteByName('knob'),
        size: Vector2.all(40),
      ),
      background: SpriteComponent(
        sprite: game.atlas.findSpriteByName('joystick_bg'),
        size: Vector2.all(136),
      ),
      margin: const EdgeInsets.only(left: 44, bottom: 44),
    );

    final shieldButton = HudButtonComponent(
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
      onPressed: () =>
          {game.world.add(ThunderEffect.generate(player.position))},
    );

    final boostButton = HudButtonComponent(
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
        onPressed: () => {
              if (player.bodyEffectType == DustyBodyEffectType.none)
                player.bodyEffectType = DustyBodyEffectType.electricShock
              else
                player.bodyEffectType = DustyBodyEffectType.none
            });

    final activeButton = HudButtonComponent(
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
        onPressed: () => {
              if (player.glassesType == DustyGlassesType.idle)
                player.glassesType = DustyGlassesType.boost
              else
                player.glassesType = DustyGlassesType.idle
            });

    final specialButton = HudButtonComponent(
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
      onPressed: () => {
        game.playScene.add(
          DefaultExplosion.generate(
            DefaultExplosionType.red,
            player.position,
          ),
        )
      },
    );

    gameRef.camera.viewport.addAll([
      joystick!,
      shieldButton,
      boostButton,
      activeButton,
      specialButton,
    ]);
  }
}
