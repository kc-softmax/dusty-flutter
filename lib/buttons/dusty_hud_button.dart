import 'dart:ui';

import 'package:flame/input.dart';
import 'package:flame/effects.dart';

/// HudButtonComponent를 모방해서 만들었다.
class DustyHudButton extends HudButtonComponent {
  static const Color deactivateColor = Color(0xFFC7C1BA);
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

  void updateAvailable(int available) {
    if (_available == available) {
      return;
    }
    _available = available;
    if (_available > 0) {
      // available
      button!.add(ColorEffect(
        deactivateColor,
        EffectController(duration: 0.5),
        opacityFrom: 0.8,
        opacityTo: 0,
      ));
    } else {
      button!.add(ColorEffect(
        deactivateColor,
        EffectController(duration: 0.5),
        opacityFrom: 0,
        opacityTo: 0.8,
      ));
    }
  }
}
