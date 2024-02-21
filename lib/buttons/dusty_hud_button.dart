import 'package:flame/timer.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/effects.dart';
import 'package:flutter/widgets.dart';

/// HudButtonComponent를 모방해서 만들었다.
class DustyHudButton extends HudButtonComponent {
  static const Color deactivateColor = Color(0xFFC7C1BA);
  late TextBoxComponent reloadCountLabel;
  int _available = 1;
  TimerComponent? reloadTimer;

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
  Future<void> onLoad() {
    reloadCountLabel = TextBoxComponent(
        text: '',
        boxConfig: TextBoxConfig(
          maxWidth: 16,
          // margins: const EdgeInsets.only(top: 20),
        ),
        textRenderer: TextPaint(
          style: const TextStyle(fontSize: 24),
        ),
        priority: 2)
      ..anchor = Anchor.center
      ..x = size.x / 2
      ..y = size.y / 2;
    add(reloadCountLabel);
    return super.onLoad();
  }

  void updateAvailable(int available, int reloadDuration) {
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
      // not available
      reloadCountLabel.text = reloadDuration.toString();
      reloadTimer = TimerComponent(
          period: 1,
          repeat: true,
          onTick: () {
            reloadDuration--;
            reloadCountLabel.text = reloadDuration.toString();
            if (reloadDuration <= 0) {
              reloadCountLabel.text = '';
              reloadTimer!.removeFromParent();
              reloadTimer = null;
            }
          });
      add(reloadTimer!);
      button!.add(ColorEffect(
        deactivateColor,
        EffectController(duration: 0.5),
        opacityFrom: 0,
        opacityTo: 0.8,
      ));
    }
  }
}
