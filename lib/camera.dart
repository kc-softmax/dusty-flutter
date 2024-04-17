import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/ui/hud/hud2.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';

class DICamera extends CameraComponent with HasGameRef<DustyIslandGame> {
  late final Hud2 hud;

  DICamera({required double width, required double height}) {
    super.viewfinder.anchor = Anchor.topLeft;
    super.viewfinder.zoom = gameRef.canvasSize.x / width;
  }

  void setHud(GameConfig gameConfig) {
    hud = Hud2(gameConfig: gameConfig, viewport: viewport);
    add(hud);
  }

  void start(Dusty player) {
    viewfinder
      ..add(ScaleEffect.to(
        Vector2.all(viewport.virtualSize.x / gameRef.canvasSize.x),
        EffectController(duration: 1, startDelay: 0.5),
      ))
      ..add(AnchorEffect.to(
        Anchor.center,
        EffectController(duration: 0.5, startDelay: 0.5),
        onComplete: () {
          // _setCameraBound();
        },
      ))
      ..add(
        MoveEffect.to(
          player.position,
          EffectController(duration: 0.5, startDelay: 0.5),
          onComplete: () {
            follow(player);
          },
        ),
      );
  }

  bool isPositionVisible(Vector2 position) {
    final screenSize = gameRef.canvasSize;
    final cameraCenter = viewport.position;
    double left = cameraCenter.x - screenSize.x / 2 / viewfinder.zoom;
    double right = cameraCenter.x + screenSize.x / 2 / viewfinder.zoom;
    double top = cameraCenter.y - screenSize.y / 2 / viewfinder.zoom;
    double bottom = cameraCenter.y + screenSize.y / 2 / viewfinder.zoom;

    return position.x >= left &&
        position.x <= right &&
        position.y >= top &&
        position.y <= bottom;
  }

  void _setCameraBound() {
    gameRef.camera.setBounds(Rectangle.fromLTWH(
      960,
      0,
      gameRef.mapComponent.width - 1820,
      gameRef.mapComponent.height,
    ));
  }
}
