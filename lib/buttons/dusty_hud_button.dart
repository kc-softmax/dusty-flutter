import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dusty_flutter/ui/arc_animation.dart';

/// HudButtonComponent를 모방해서 만들었다.
class DustyHudButton extends HudButtonComponent {
  static const Color deactivateColor = Color(0xFFC7C1BA);
  static const Color activateColor = Color(0x00ffffff);

  late ArcAnimationComponent reloadAnimation;
  int _available = 1;

  DustyHudButton({
    super.button,
    super.buttonDown,
    super.margin,
    super.onPressed,
    super.onReleased,
    super.onCancelled,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    reloadAnimation = ArcAnimationComponent(
        timer: Timer(1, autoStart: false),
        paint: Paint()
          ..color = activateColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4)
      ..size = Vector2(size.x + 4, size.y + 4)
      ..position = -Vector2.all(2);
    add(reloadAnimation);
  }

  void updateAvailable(int available, int reloadDuration) {
    if (_available == available) {
      return;
    }
    _available = available;
    if (_available > 0) {
      // available
      reloadAnimation.stop();
      button!.add(ColorEffect(
        deactivateColor,
        EffectController(duration: 0.5),
        opacityFrom: 0.8,
        opacityTo: 0,
      ));
    } else {
      // not available
      reloadAnimation.start(reloadDuration);
      button!.add(ColorEffect(
        deactivateColor,
        EffectController(duration: 0.5),
        opacityFrom: 0,
        opacityTo: 0.8,
      ));
    }
  }
}
