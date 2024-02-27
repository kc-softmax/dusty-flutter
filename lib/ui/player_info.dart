import 'dart:ui';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' hide Image;

class PlayerInfoComponent extends RectangleComponent
    with HasGameRef<DustyIslandGame> {
  final rankPanelSize = Vector2(88, 44);
  final scorePanelSize = Vector2(132, 44);
  final rankIconSize = Vector2(24, 24);
  final scoreIconSize = Vector2(16, 16);
  final panelOffsetX = 16.0;
  final scorePanelOffsetX = 8.0;
  final scorePanelOffsetLongX = 66.0;

  late final TextComponent rankText;
  late final TextComponent killText;
  late final TextComponent tileText;
  late final TextComponent destoryText;
  late final TextComponent towerText;

  final rankTextPainter = TextPaint(
    style: TextStyle(
      fontSize: 16.0,
      color: BasicPalette.white.color,
      shadows: [
        Shadow(
          color: BasicPalette.black.color,
          offset: const Offset(1, 1),
          blurRadius: 1,
        ),
      ],
    ),
  );

  final scoreTextPainter = TextPaint(
    style: TextStyle(
      fontSize: 12,
      color: BasicPalette.white.color,
      shadows: [
        Shadow(
          color: BasicPalette.black.color,
          offset: const Offset(1, 1),
          blurRadius: 1,
        ),
      ],
    ),
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName('rank_bg'),
      size: rankPanelSize,
    ));
    add(SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName('score_bg'),
      size: scorePanelSize,
    )..x = rankPanelSize.x + panelOffsetX);

    //rankIcon
    add(SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName('raft'),
      size: rankIconSize,
    )
      ..x = 10
      ..y = 10);

    // kill score
    add(SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName('raft'),
      size: scoreIconSize,
    )
      ..x = rankPanelSize.x + panelOffsetX + scorePanelOffsetX
      ..y = 4);

    // tile score
    add(SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName('raft'),
      size: scoreIconSize,
    )
      ..x = rankPanelSize.x + panelOffsetX + scorePanelOffsetLongX
      ..y = 4);

    // destory score
    add(SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName('raft'),
      size: scoreIconSize,
    )
      ..x = rankPanelSize.x + panelOffsetX + scorePanelOffsetX
      ..y = 24);
    // tower score
    add(SpriteComponent(
      sprite: gameRef.atlas.findSpriteByName('raft'),
      size: scoreIconSize,
    )
      ..x = rankPanelSize.x + panelOffsetX + scorePanelOffsetLongX
      ..y = 24);

    rankText = TextComponent(
      text: '11',
      textRenderer: rankTextPainter,
      position: Vector2(50, 12),
    );

    killText = TextComponent(
      text: '100',
      textRenderer: scoreTextPainter,
      position:
          Vector2(rankPanelSize.x + panelOffsetX + scorePanelOffsetX + 24, 4),
    );

    tileText = TextComponent(
      text: '3000',
      textRenderer: scoreTextPainter,
      position: Vector2(
          rankPanelSize.x + panelOffsetX + scorePanelOffsetLongX + 24, 4),
    );

    destoryText = TextComponent(
      text: '3000',
      textRenderer: scoreTextPainter,
      position:
          Vector2(rankPanelSize.x + panelOffsetX + scorePanelOffsetX + 24, 24),
    );

    towerText = TextComponent(
      text: '1 / 5',
      textRenderer: scoreTextPainter,
      position: Vector2(
          rankPanelSize.x + panelOffsetX + scorePanelOffsetLongX + 24, 24),
    );

    addAll([
      rankText,
      killText,
      tileText,
      destoryText,
      towerText,
    ]);
  }

  // updateScore
}
