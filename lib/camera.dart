import 'package:dusty_flutter/characters/dusty.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';

class DICamera extends CameraComponent with HasGameRef<DustyIslandGame> {
  DICamera({required double width, required double height}) {
    super.viewfinder.anchor = Anchor.topLeft;
    super.viewfinder.zoom = gameRef.canvasSize.x / width;
  }

  void start(Dusty player) {
    viewfinder
      ..add(ScaleEffect.to(
        Vector2.all(viewport.virtualSize.x / gameRef.canvasSize.x),
        EffectController(duration: 1),
      ))
      ..add(AnchorEffect.to(
        Anchor.center,
        EffectController(duration: 0.5),
        onComplete: () {
          // _setCameraBound();
        },
      ))
      ..add(
        MoveEffect.to(
          player.position,
          EffectController(duration: 0.5),
          onComplete: () {
            follow(player);
          },
        ),
      );
  }

  void _setCameraBound() {
    gameRef.camera.setBounds(Rectangle.fromLTWH(
      960,
      0,
      gameRef.world.mapComponent.width - 1820,
      gameRef.world.mapComponent.height,
    ));
  }
}
