import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';

class GrenadeCircle extends PositionComponent {
  late final Paint paint;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    paint = Paint()
      ..color = const Color(0xFFFF0000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
    // const startAngle = -math.pi / 2;
    // final sweepAngle = math.pi * 2 * progress;
    // final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    // canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }
}
