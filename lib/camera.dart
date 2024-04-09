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
      gameRef.mapComponent.width - 1820,
      gameRef.mapComponent.height,
    ));
  }
}
