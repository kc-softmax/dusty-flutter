import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:dusty_flutter/flame_texturepacker.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame> {
  Player()
      : super(
          size: Vector2(48, 48),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final atlas = await gameRef.fromAtlas('images/test.atlas');
    final spriteList = atlas.findSpritesByName('yellow_body');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );

    position = game.size / 4;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}

class SpaceShooterGame extends FlameGame with PanDetector {
  late Player player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    player = Player();
    add(player);
    overlays.add("TestButton");
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
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
}
