import 'dart:math' as math;
import 'dart:math';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// HudButtonComponent를 모방해서 만들었다.
class DustyHudButton extends HudButtonComponent {
  static const Color deactivateColor = Color(0xff111736);

  late SpriteComponent buttonIcon;
  late Timer timer;
  late Paint paint;
  int _available = 1;
  int reloadDuration;
  double progress = 0;
  Function(double)? handleButtonAction;
  PassiveObjectType _equipment = PassiveObjectType.idle;

  DustyHudButton({
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
    required this.reloadDuration,
    this.handleButtonAction,
  }) {
    super.onPressed = () {
      handleButtonAction?.call(progress);
    };
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    timer = Timer(1, autoStart: false);
    paint = Paint()
      ..color = deactivateColor
      ..style = PaintingStyle.fill;
    // addimage
  }

  void setEquipment(PassiveObjectType equipment) {
    if (_equipment == equipment) {
      return;
    }
    switch (equipment) {
      case PassiveObjectType.coconut:
        break;
      case PassiveObjectType.normalSeed:
        break;
      default:
        // button =
        break;
    }
    _equipment = equipment;
  }

  void updateManual(double progress) {
    this.progress = progress;
  }

  void updateAvailable(int available) {
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

  @mustCallSuper
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

class LongTapDustyHudButton extends DustyHudButton {
  int longTapMaxTime = 0;
  bool _isPressing = false;
  double _pressedTime = 0;
  // TEMP 게이지는 int형
  double _guage = 0;
  Function(double, int) handleLongTapButtonAction;

  LongTapDustyHudButton({
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
    required super.reloadDuration,
    required this.longTapMaxTime,
    required this.handleLongTapButtonAction,
  });

  @override
  void onTapUp(TapUpEvent event) {
    handleLongTapButtonAction(progress, _guage.toInt());
    _clearGuage();
    super.onTapUp(event);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    if (progress != 0) return;
    _isPressing = true;
  }

  @override
  void update(double dt) {
    if (_isPressing && _guage < 100) {
      _pressedTime += dt;
      _guage = min((_pressedTime / longTapMaxTime) * 100, 100);
      print('preesedTime: $_pressedTime, guage: $_guage');
    }
    super.update(dt);
  }

  void _clearGuage() {
    _guage = 0;
    _pressedTime = 0;
    _isPressing = false;
  }
}
