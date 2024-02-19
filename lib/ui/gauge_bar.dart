import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class HorizontalGaugeBar extends RectangleComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    scale = Vector2(0, 1);
  }

  void decreaseWithDuration(double duration, Color color) {
    paint = Paint()..color = color;
    scale = Vector2(1, 1);
    add(ScaleEffect.to(
      Vector2(0, 1),
      EffectController(duration: duration),
    ));
  }
}

class VerticalGaugeBar extends RectangleComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    scale = Vector2(1, 0);
  }

  void decreaseWithDuration(double duration, Color color) {
    paint = Paint()..color = color;
    scale = Vector2(1, 1);
    add(ScaleEffect.to(
      Vector2(1, 0),
      EffectController(duration: duration),
    ));
  }
}

// if you want to adjust gaugebar using value, consider using this class 
// class HorizontalGaugeBar extends RectangleComponent {
//   final double max;
//   final double value;
//   final double width;
//   final double height;
//   final double padding;
//   Paint backgroundPaint;
//   Paint valuePaint;

//   HorizontalGaugeBar({
//     required this.max,
//     required this.value,
//     required this.width,
//     required this.height,
//     required this.padding,
//     required this.backgroundPaint,
//     required this.valuePaint,
//   });

//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     canvas.drawRect(
//       Rect.fromLTWH(x, y, width, height),
//       backgroundPaint,
//     );
//     canvas.drawRect(
//       Rect.fromLTWH(x + padding, y + padding,
//           (width - padding * 2) * (value / max), height - padding * 2),
//       valuePaint,
//     );
//   }
// }
