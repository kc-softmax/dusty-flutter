import 'dart:math' as math;
import 'dart:math';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// HudButtonComponent를 모방해서 만들었다.
class DustyHudButton extends HudButtonComponent
    with HasGameRef<FlameGame<World>> {
  static const Color deactivateColor = Color(0xff111736);

  final quantityTextPaint = TextPaint(
    style: TextStyle(
      fontSize: 14.0,
      fontFamily: 'ONEMobilePOP',
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
  late TextComponent quantityText;
  late SpriteComponent? buttonIcon;
  late Timer timer;
  late Paint paint;
  int _available = 1;
  int _quantity = 0;
  int reloadDuration;
  double progress = 0;
  Function(double)? handleButtonAction;
  PassiveObjectType _equipment = PassiveObjectType.idle;
  PassiveObjectType get equipment => _equipment;

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
    final game = gameRef as DustyIslandGame;

    buttonIcon = SpriteComponent(
      sprite: game.atlas.findSpriteByName('raft') as Sprite,
      size: size / 2,
    )
      ..anchor = Anchor.center
      ..scale = Vector2.all(0)
      ..x = size.x / 2
      ..y = size.y / 2;

    quantityText = TextComponent(
      text: '',
      textRenderer: quantityTextPaint,
      position: Vector2(size.x / 2, size.y / 2),
    )..anchor = Anchor.topLeft;
    // addimage
    add(buttonIcon!);
    add(quantityText);
  }

  void setEquipment(PassiveObjectType equipment, int quantity) {
    if (_quantity != quantity) {
      _quantity = quantity;
      if (_quantity == 0) {
        quantityText.text = '';
        buttonIcon!.add(ScaleEffect.to(
          Vector2.all(0),
          EffectController(duration: 0.25),
        ));
      } else {
        quantityText.text = ' x$_quantity';
        buttonIcon!.add(ScaleEffect.to(
          Vector2.all(1),
          EffectController(duration: 0.25),
        ));
      }
    }
    if (_equipment == equipment) {
      return;
    }
    final game = gameRef as DustyIslandGame;

    switch (equipment) {
      case PassiveObjectType.coconut:
        setIcon(game.atlas.findSpriteByName('raft') as Sprite);
        break;
      case PassiveObjectType.normalSeed:
        setIcon(game.atlas.findSpriteByName('raft') as Sprite);
        break;
      default:
        // button =
        break;
    }
    _equipment = equipment;
  }

  void setIcon(Sprite icon) {
    buttonIcon!.sprite = icon;
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
      if (buttonIcon!.opacity == 1) {
        buttonIcon!.opacity = 0.5;
      }
    } else {
      progress = 0;
      if (buttonIcon!.opacity != 1) {
        buttonIcon!.opacity = 1;
      }
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
  double _gauge = 0;
  double get gauge => _gauge;
  Function(double, int) handleLongTapButtonAction;
  Function(double)? handleLongTapButtonTapAction;

  late CircleComponent shadow;

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
    this.handleLongTapButtonTapAction,
  });

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    _clearGuage();
  }

  @override
  void onTapUp(TapUpEvent event) {
    final gauge = _gauge.toInt();
    handleLongTapButtonAction(progress, gauge);
    _clearGuage();
    super.onTapUp(event);
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    if (equipment == PassiveObjectType.idle) {
      return;
    }
    if (progress != 0) return;
    if (handleLongTapButtonTapAction != null) {
      handleLongTapButtonTapAction!(progress);
    }
    _isPressing = true;
  }

  @override
  void update(double dt) {
    if (_isPressing && _gauge < 100) {
      _pressedTime += dt;
      _gauge = min((_pressedTime / longTapMaxTime) * 100, 100);
    }
    super.update(dt);
  }

  void _clearGuage() {
    _gauge = 0;
    _pressedTime = 0;
    _isPressing = false;
  }
}
