import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:dusty_flutter/atlas/texture_atlas.dart';
import 'package:dusty_flutter/flame_texturepacker.dart';
import 'package:dusty_flutter/characters/dusty.dart';

// @override
// void onCollisionStart(
//   Set<Vector2> intersectionPoints,
//   PositionComponent other,
// ) {
//   super.onCollisionStart(intersectionPoints, other);
// }

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
    world.add(mapComponent);
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: atlas.findSpriteByName('knob'),
        size: Vector2.all(size.y * 0.15),
      ),
      background: SpriteComponent(
        sprite: atlas.findSpriteByName('joystick_bg'),
        size: Vector2.all(size.y * 0.35),
      ),
      margin: const EdgeInsets.only(left: 44, bottom: 44),
    );

    player = Dusty();

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
      onPressed: player.flipHorizontally,
    );

    @override
    Future<void> onLoad() async {
      await super.onLoad();
      player = Player();
      add(player);
      overlays.add("TestButton");
    }

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
      // onPressed: player.flipHorizontally,
    );

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
      // onPressed:  ,
    );

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
      onPressed: player.flipHorizontally,
    );

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
    game: SpaceShooterGame(),
    overlayBuilderMap: {
      "TestButton": (BuildContext context, SpaceShooterGame game) {
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
