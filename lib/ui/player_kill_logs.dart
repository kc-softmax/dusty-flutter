import 'dart:ui';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class PlayerKillLogComponent extends PositionComponent
    with HasGameRef<DustyIslandGame> {
  Color color;
  String name;
  late PolygonComponent panel;

  PlayerKillLogComponent({
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
}

class PlayerKillLogsComponent extends PositionComponent {
  List<PlayerKillLogComponent> killLogs = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  void addKillLog(Image avatar, String name, RemoveBy removeBy) {
    final killLog = PlayerKillLogComponent(color: crimsonColor, name: name);
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
    killLog.scale = Vector2.all(0.2);
    killLog.addAll([
      ScaleEffect.to(
        Vector2.all(1),
        EffectController(duration: 0.25),
      ),
      ScaleEffect.by(
        Vector2.all(0),
        DelayedEffectController(EffectController(duration: 0.25), delay: 1.5),
        onComplete: () {
          killLogs.remove(killLog);
          killLog.removeFromParent();
        },
      )
    ]);
    add(killLog);
  }
}
