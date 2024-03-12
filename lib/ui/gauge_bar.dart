import 'dart:ui';
import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class GaugeBar extends PositionComponent with HasGameRef<DustyIslandGame> {
  late SpriteComponent background;
  late SpriteComponent gauge;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    background = SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName('gauge_bg'),
    )
      ..size = size
      ..anchor = Anchor.topLeft;
    gauge = SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName('gauge_yellow'),
    )
      ..size = Vector2(size.x - 2, size.y - 2)
      ..x = 1
      ..y = 1
      ..anchor = Anchor.topLeft;

    addAll([background, gauge]);
    hide();
  }

  void hide() {
    background.add(ScaleEffect.to(
      Vector2.zero(),
      EffectController(duration: 0.1),
    ));
    gauge.add(ScaleEffect.to(
      Vector2.zero(),
      EffectController(duration: 0.1),
    ));
  }

  void updateValue(double value) {
    if (value < 0) hide();

    if (background.scale.x == 0) {
      background.add(ScaleEffect.to(
        Vector2(0, 1),
        EffectController(duration: 0.1),
      ));
      scale = Vector2(1, 1);
    }
    gauge.scale = Vector2(value, 1);
  }

  void decreaseWithDuration(double duration, Color color) {
    scale = Vector2(1, 1);
    add(ScaleEffect.to(
      Vector2(0, 1),
      EffectController(duration: duration),
    ));
  }
}
