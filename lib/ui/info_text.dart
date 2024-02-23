import 'dart:math' as math;
import 'dart:ui';
import 'package:flame/components.dart';

class InfoTextComponent extends PositionComponent {
  Paint paint;
  Timer timer;
  double progress = 0;

  InfoTextComponent({
    required this.timer,
    required this.paint,
  }) : super();

  void start(int duration) {
    timer.limit = duration.toDouble();
    timer.start();
  }

  void stop() {
    timer.stop();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void update(double dt) {
    if (timer.isRunning()) {
      timer.update(dt);
      progress = timer.progress;
    } else {
      progress = 1;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    const startAngle = -math.pi / 2;
    final sweepAngle = math.pi * 2 * progress;
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }
}
