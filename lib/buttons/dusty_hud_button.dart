import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// HudButtonComponent를 모방해서 만들었다.
class DustyHudButton extends HudButtonComponent {
  static const Color deactivateColor = Color(0xff111736);

  late Timer timer;
  late Paint paint;
  int _available = 1;
  double progress = 0;

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
    timer = Timer(1, autoStart: false);
    paint = Paint()
      ..color = deactivateColor
      ..style = PaintingStyle.fill;
  }

  void updateManual(double progress) {
    this.progress = progress;
  }

  void updateAvailable(int available, int reloadDuration) {
    if (_available == available) {
      return;
    }
    _available = available;
    if (_available > 0) {
      // available
      timer.stop();
    } else {
      // not available
      timer.limit = reloadDuration.toDouble();
      timer.start();
    }
  }

  @override
  void update(double dt) {
    if (timer.isRunning()) {
      timer.update(dt);
      progress = timer.progress;
    } else {
      progress = 0;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (progress == 0) {
      return;
    }
    final startAngle = -math.pi / 2 + math.pi * 2 * progress;
    final sweepAngle = math.pi * 2 - math.pi * 2 * progress;
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }
}
