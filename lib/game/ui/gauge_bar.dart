import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/ui/const.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class HorizontalGaugeBar extends SpriteComponent
    with HasGameRef<DustyIslandGame> {
  late SpriteComponent gauge;

  GaugeBarColor gaugeColor;
  HorizontalGaugeBar({required this.gaugeColor});

  double hpGauge = 10;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = gameRef.atlas.findSpriteByName('gauge_box');
    gauge = SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName(gaugeColor.value),
    );
    addAll([gauge]);
  }

  void hide(bool hide) {
    add(OpacityEffect.to(hide ? 0 : 1, EffectController(duration: 0.2)));
  }

  void updateValue(double value) {
    setOpacity(1);
    hpGauge -= value;
    if (hpGauge < 0) hpGauge = 0;
    gauge.add(ScaleEffect.to(
      Vector2(value / 10, 1),
      EffectController(duration: 0.2),
      onComplete: () {},
    ));
  }
}
