import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class GrenadeTargetArea extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame> {
  bool activated = false;
  ScaleEffect? scaleEffect;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('ellipse_red');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
    anchor = Anchor.center;
    size = Vector2(48, 48);
    scale = Vector2(0, 0);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (!activated) return;
    // draw arc with fill
    final paint = Paint()
      ..color = const Color(0x33FF3333)
      ..style = PaintingStyle.fill;
    const rect = Rect.fromLTWH(0, 8, 48, 32);
    canvas.drawArc(
      rect,
      0,
      pi * 2,
      true,
      paint,
    );
  }

  void setActivated(bool value) {
    if (value == activated) return;
    if (value) {
      scale = Vector2(1, 1);
      scaleEffect = ScaleEffect.to(
        Vector2(1.1, 1.1),
        EffectController(
          duration: 0.25,
          infinite: true,
          alternate: true,
        ),
      );
      add(scaleEffect!);
    } else {
      scaleEffect?.removeFromParent();
      scaleEffect = ScaleEffect.to(
        Vector2(0, 0),
        EffectController(
          duration: 2,
        ),
      );
      add(scaleEffect!);
    }
    activated = value;
  }
}
