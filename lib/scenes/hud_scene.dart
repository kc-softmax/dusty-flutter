import 'dart:async';
import 'package:dusty_flutter/characters/const.dart';
import 'package:dusty_flutter/effects/const.dart';
import 'package:dusty_flutter/effects/default_explosion.dart';
import 'package:dusty_flutter/effects/thunder_effect.dart';
import 'package:dusty_flutter/main.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class HudScene extends Component with HasGameRef<DustyIsland> {
  static const routerName = 'hud';
  static final buttonSize = Vector2(56, 59);
  static final smallButtonSize = Vector2(44, 46);

  late final JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() {
    final player = gameRef.playScene.player;

    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: gameRef.atlas.findSpriteByName('knob'),
        size: Vector2.all(40),
      ),
      background: SpriteComponent(
        sprite: gameRef.atlas.findSpriteByName('joystick_bg'),
        size: Vector2.all(136),
      ),
      margin: const EdgeInsets.only(left: 44, bottom: 44),
    );

    final shieldButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: gameRef.atlas.findSpriteByName('circle_button'),
        size: buttonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: gameRef.atlas.findSpriteByName('press_circle_button'),
        size: buttonSize,
      ),
      margin: const EdgeInsets.only(
        right: 68,
        bottom: 65,
      ),
      onPressed: () =>
          {gameRef.world.add(ThunderEffect.generate(player.position))},
    );

    final boostButton = HudButtonComponent(
        button: SpriteComponent(
          sprite: gameRef.atlas.findSpriteByName('small_circle_button'),
          size: smallButtonSize,
        ),
        buttonDown: SpriteComponent(
          sprite: gameRef.atlas.findSpriteByName('press_small_circle_button'),
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
          sprite: gameRef.atlas.findSpriteByName('small_circle_button'),
          size: smallButtonSize,
        ),
        buttonDown: SpriteComponent(
          sprite: gameRef.atlas.findSpriteByName('press_small_circle_button'),
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
        sprite: gameRef.atlas.findSpriteByName('small_circle_button'),
        size: smallButtonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: gameRef.atlas.findSpriteByName('press_small_circle_button'),
        size: smallButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 88,
        bottom: 150,
      ),
      onPressed: () => {
        add(DefaultExplosion.generate(
            DefaultExplosionType.red, player.position))
      },
    );

    gameRef.camera.viewport.addAll([
      joystick,
      shieldButton,
      boostButton,
      activeButton,
      specialButton,
    ]);
  }
}
