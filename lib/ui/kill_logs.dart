import 'dart:ui';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class KillLogComponent extends PositionComponent
    with HasGameRef<DustyIslandGame> {
  Color color;
  String name;
  late PolygonComponent panel;

  KillLogComponent({
    required this.color,
    required this.name,
  }) : super();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(128, 24);
    panel = PolygonComponent.relative(
      [
        Vector2(-0.875, 1.0),
        Vector2(1.0, 1.0),
        Vector2(0.875, -1.0),
        Vector2(-1.0, -1.0),
      ],
      parentSize: size,
    )
      ..x = -size.x / 2
      ..y = -size.y / 2;
    panel.paintLayers = [
      Paint()..color = color,
      Paint()
        ..color = color.withOpacity(0.75)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    ];

    add(panel);
    add(TextBoxComponent(
      text: name,
      align: Anchor.center,
      textRenderer: regularText,
      position: Vector2(-size.x * 0.75, -size.y * 0.75),
      // boxConfig: TextBoxConfig(timePerChar: 0.05)
    ));
    add(
      SpriteComponent(
        sprite: gameRef.atlas.findSpriteByName('knob'),
        size: Vector2.all(size.y),
      )
        ..x = -size.x * 0.4
        ..y = -size.y * 0.5,
    );
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

class KillLogsComponent extends PositionComponent {
  List<KillLogComponent> killLogs = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  void addKillLog(String name, Team team, RemoveBy removeBy) {
    final killLog = KillLogComponent(
        color: team == Team.alpha ? alphaTeamColor : betaTeamColor, name: name);
    if (killLogs.isNotEmpty) {
      for (final log in killLogs) {
        log.addAll([
          MoveToEffect(
            Vector2(0, -log.size.y * 0.75),
            EffectController(duration: 0.25),
          ),
          ScaleEffect.by(
            Vector2(0.8, 0.8),
            EffectController(duration: 0.25),
          ),
        ]);
      }
    }
    killLogs.add(killLog);
    killLog.add(ScaleEffect.by(
      Vector2(0, 0),
      DelayedEffectController(EffectController(duration: 0.25), delay: 1.5),
      onComplete: () {
        killLogs.remove(killLog);
        killLog.removeFromParent();
      },
    ));
    add(killLog);

//     final effect = OpacityEffect.to(
//   0.2,
//   EffectController(duration: 0.75),
// );
    // DelayedEffectController(LinearEffectController(1), delay: 5);
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
