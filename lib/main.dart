import 'package:dusty_flutter/effects/burn_effect.dart';
import 'package:dusty_flutter/effects/thunder_effect.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart' hide Text;
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:dusty_flutter/atlas/texture_atlas.dart';
import 'package:dusty_flutter/flame_texturepacker.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/characters/const.dart';
import 'package:dusty_flutter/effects/default_explosion.dart';
import 'package:dusty_flutter/effects/const.dart';

class DustyIsland extends FlameGame with HasCollisionDetection {
  late final JoystickComponent joystick;
  late final TiledComponent mapComponent;
  late final TextureAtlas atlas;
  late final Dusty player;

  @override
  Future<void> onLoad() async {
    // set hud camera

    atlas = await fromAtlas('images/dusty-island.atlas');
    mapComponent = await TiledComponent.load('map.tmx', Vector2.all(64));
    final groundLayer = mapComponent.tileMap.getLayer<TileLayer>('ground');
    if (groundLayer == null) {
      throw Exception('ground layer not found');
    }
    // map
    world.add(mapComponent);
    // world.add(RectangleHitbox());
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: atlas.findSpriteByName('knob'),
        size: Vector2.all(40),
      ),
      background: SpriteComponent(
        sprite: atlas.findSpriteByName('joystick_bg'),
        size: Vector2.all(136),
      ),
      margin: const EdgeInsets.only(left: 44, bottom: 44),
    );

    player = Dusty()
      ..x = 500
      ..y = 500;

    final buttonSize = Vector2(56, 59);
    final smallButtonSize = Vector2(44, 46);

    final shieldButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: atlas.findSpriteByName('circle_button'),
        size: buttonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: atlas.findSpriteByName('press_circle_button'),
        size: buttonSize,
      ),
      margin: const EdgeInsets.only(
        right: 68,
        bottom: 65,
      ),
      onPressed: () => {world.add(ThunderEffect.generate(player.position))},
    );

    final boostButton = HudButtonComponent(
        button: SpriteComponent(
          sprite: atlas.findSpriteByName('small_circle_button'),
          size: smallButtonSize,
        ),
        buttonDown: SpriteComponent(
          sprite: atlas.findSpriteByName('press_small_circle_button'),
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
          sprite: atlas.findSpriteByName('small_circle_button'),
          size: smallButtonSize,
        ),
        buttonDown: SpriteComponent(
          sprite: atlas.findSpriteByName('press_small_circle_button'),
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
        sprite: atlas.findSpriteByName('small_circle_button'),
        size: smallButtonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: atlas.findSpriteByName('press_small_circle_button'),
        size: smallButtonSize,
      ),
      margin: const EdgeInsets.only(
        right: 88,
        bottom: 150,
      ),
      onPressed: () => {
        world.add(DefaultExplosion.generate(
            DefaultExplosionType.red, player.position))
      },
    );

    // overlays.add("TestButton");

    world.addAll([player]);
    camera.follow(player);
    camera.viewport.addAll([
      joystick,
      shieldButton,
      boostButton,
      activeButton,
      specialButton,
    ]);
  }
}

void main() {
  runApp(GameWidget(
    game: DustyIsland(),
    overlayBuilderMap: {
      "TestButton": (BuildContext context, DustyIsland game) {
        return FilledButton(
            onPressed: () {
              Arbiter.liveService.on(
                "/di/ws?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDcxMDQyMzYsInN1YiI6IjE1In0.SqJrXhDWl-eQVMyY1m02dm8e1OZqOV1iSY0LSkkP0i0",
                (message) {
                  debugPrint(message.toString());
                },
              );
            },
            child: const Text("TEST"));
      }
    },
  ));
  runApp(GameWidget(game: DustyIsland()));
}
