import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/game/game_objects/characters/dusty/dusty.dart';
import 'package:dusty_flutter/extensions/camera.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/ui/hud/hud.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_tiled/flame_tiled.dart';

class DICamera extends CameraComponent with HasGameRef<DustyIslandGame> {
  TiledComponent gameMap;
  GameInfo gameInfo;
  late final Hud hud;

  DICamera(
      {required this.gameMap,
      required this.gameInfo,
      required double width,
      required double height}) {
    super.viewfinder.anchor = Anchor.center;
    // super.viewfinder.zoom = gameRef.canvasSize.x / width;
    setBoundToMapSize(
      gameMap.width,
      gameMap.height,
      1,
    );
  }

  void setHud() {
    hud = Hud(gameInfo: gameInfo, viewport: viewport, gameMap: gameMap);
    add(hud);
  }

  void start(Dusty player) {
    viewfinder
      ..add(
        MoveEffect.to(
          player.position,
          EffectController(duration: 0.5),
          onComplete: () {},
        ),
      )
      ..add(ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 1),
      ))
      ..add(AnchorEffect.to(
        Anchor.center,
        EffectController(duration: 0.5),
        onComplete: () {
          follow(player);
        },
      ));
  }
}
