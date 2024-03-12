import 'dart:math' as math;
import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DustyHudFinishButton extends HudButtonComponent {
  static const Color deactivateColor = Color(0xff111736);
  final percentTextStyle = TextPaint(
    style: TextStyle(
      fontSize: 16.0,
      color: BasicPalette.white.color,
      shadows: [
        Shadow(
          color: BasicPalette.black.color,
          offset: const Offset(2, 2),
          blurRadius: 1,
        ),
      ],
    ),
  );

  late Timer timer;
  late Paint paint;
  late TextComponent percentText;
  late TextComponent tempText;

  int _available = 1;
  int _finishGauge = 0;
  FinishType? _finishType;
  int finishDuration;
  double _progress = 0;
  bool set = false;
  Function(bool)? handleFinishButtonAction;

  DustyHudFinishButton({
    super.button,
    super.buttonDown,
    super.margin,
    super.onReleased,
    super.onCancelled,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
    required this.finishDuration,
    this.handleFinishButtonAction,
  }) {
    super.onPressed = () {
      handleFinishButtonAction?.call(_available >= 1);
    };
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    timer = Timer(1, autoStart: false);
    paint = Paint()
      ..color = deactivateColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    percentText = TextComponent(
        text: '0%',
        textRenderer: percentTextStyle,
        position: Vector2(size.x / 2, size.y / 2 - 8))
      ..anchor = Anchor.center;

    tempText = TextComponent(
        text: '',
        textRenderer: percentTextStyle,
        position: Vector2(size.x / 2, size.y - 12))
      ..anchor = Anchor.center;

    add(tempText);
    add(percentText);
  }

  void setFinishType(FinishType finishType) {
    switch (finishType) {
      case FinishType.fire:
        tempText.text = 'F';
        break;
      case FinishType.lightning:
        tempText.text = 'L';
        break;
      default:
    }
    _finishType = finishType;
  }

  void updateManual(int progress) {
    _progress = progress / 100;
  }

  void updateAvailable(int available, int finishGauge, FinishType finishType) {
    if (_finishType != finishType) {
      setFinishType(finishType);
    }
    if (_available == available) {
      if (available < 1) {
        if (_finishGauge != finishGauge) {
          percentText.text = '$finishGauge%';
          updateManual(finishGauge);
        }
        _finishGauge = finishGauge;
      }
      return;
    }

    if (available > 0) {
      paint.style = PaintingStyle.fill;
      percentText.text = '';
      switch (finishType) {
        case FinishType.fire:
          // DustySoundPool.instance.effectOnActivateFireFinishing();
          break;
        case FinishType.lightning:
        // DustySoundPool.instance.effectOnActivateLightningFinishing();
        default:
      }

      // available
      // timer.stop();
    } else {
      paint.style = PaintingStyle.stroke;
      // not available
      // timer.limit = finishDuration.toDouble();
      // timer.start();
    }
    _available = available;
  }

  @override
  void update(double dt) {
    // if (timer.isRunning()) {
    //   timer.update(dt);
    //   _progress = timer.progress;
    // } else {
    //   _progress = 0;
    // }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_progress == 0) {
      return;
    }
    Rect rect;
    if (_available < 1) {
      const startAngle = -math.pi / 2;
      final sweepAngle = math.pi * 2 * _progress;
      rect = Rect.fromLTWH(0, 0, size.x, size.y);
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    } else {
      rect = Rect.fromLTWH(0, 0, size.x, size.y);
      canvas.drawArc(rect, 0, math.pi * 2, true, paint);
    }
  }
}
