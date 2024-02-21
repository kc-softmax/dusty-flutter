import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game.dart';

class Minimap extends PositionComponent with HasGameRef<DustyIslandGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  // @override
  // void update(double dt) {
  //   if (timer.isRunning()) {
  //     timer.update(dt);
  //     progress = timer.progress;
  //   } else {
  //     progress = 1;
  //   }
  // }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   const startAngle = -math.pi / 2;
  //   final sweepAngle = math.pi * 2 * progress;
  //   final rect = Rect.fromLTWH(0, 0, size.x, size.y);
  //   canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  // }
}
