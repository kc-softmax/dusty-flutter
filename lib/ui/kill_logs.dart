import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' hide Image;

class KillLogComponent extends RectangleComponent
    with HasGameRef<DustyIslandGame> {
  final textMargin = 8.0;
  final leftMargin = 11.0;
  final avatarSize = 20.0;
  final killLogText = TextPaint(
    style: TextStyle(
      fontSize: 9.0,
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

  String winnerName;
  String loserName;
  Sprite winnerAvatar;
  Sprite loserAvatar;

  KillLogComponent({
    required this.winnerName,
    required this.loserName,
    required this.winnerAvatar,
    required this.loserAvatar,
  }) : super();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    var marginX = leftMargin;

    final winnerImage = SpriteComponent(
      sprite: winnerAvatar,
      size: Vector2.all(avatarSize),
    )..x = marginX;

    marginX += avatarSize + textMargin;
    final winnerText = TextComponent(
      text: winnerName,
      textRenderer: killLogText,
      position:
          Vector2(marginX, avatarSize / 2 - killLogText.style.fontSize! / 2),
    );

    marginX += winnerText.size.x + textMargin;

    final killIconImage = SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName('knob'),
      size: Vector2.all(avatarSize),
    )..x = marginX;

    marginX += avatarSize + textMargin;
    final loserText = TextComponent(
      text: loserName,
      textRenderer: killLogText,
      position:
          Vector2(marginX, avatarSize / 2 - killLogText.style.fontSize! / 2),
    );

    marginX += loserText.size.x + textMargin;

    final loserImage = SpriteComponent(
      sprite: loserAvatar,
      size: Vector2.all(avatarSize),
    )..x = marginX;

    addAll([
      winnerImage,
      winnerText,
      killIconImage,
      loserText,
      loserImage,
    ]);
  }
}

class KillLogsComponent extends PositionComponent
    with HasGameReference, ComponentViewportMargin {
  final maxDisplyLogs = 4;
  final killLogHeight = 22.0;
  final killLogMargin = 3.0;
  final killLogs = <KillLogComponent>[];
  final displayLogs = <KillLogComponent>[];
  late TimerComponent respawnTimer;
  KillLogsComponent({
    EdgeInsets? margin,
  }) : super() {
    this.margin = margin;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    respawnTimer = TimerComponent(
      period: 0.1,
      repeat: true,
      onTick: () => updateKillLogs(),
    );
    add(respawnTimer);
  }

  void addKillLog(String winnerName, String loserName, Sprite winnerAvatar,
      Sprite loserAvatar, RemoveBy removeBy) {
    final log = KillLogComponent(
        winnerName: winnerName,
        loserName: loserName,
        winnerAvatar: winnerAvatar,
        loserAvatar: loserAvatar);
    killLogs.add(log);
  }

  void updateKillLogs() {
    if (killLogs.isEmpty) {
      return;
    }
    if (displayLogs.length >= maxDisplyLogs) {
      //wait;
      return;
    }
    for (var i = 0; i < displayLogs.length; i++) {
      final log = displayLogs[i];
      log.add(MoveByEffect(Vector2(0, -(killLogHeight + killLogMargin)),
          EffectController(duration: 0.25)));
    }
    final log = killLogs.removeAt(0);
    log.y = (maxDisplyLogs - 1) * (killLogHeight + killLogMargin);
    //set log Y
    log.add(ScaleEffect.by(
      Vector2(1, 0),
      DelayedEffectController(EffectController(duration: 0.25), delay: 1.25),
      onComplete: () {
        displayLogs.remove(log);
        log.removeFromParent();
      },
    ));
    displayLogs.add(log);
    add(log);
  }
}
