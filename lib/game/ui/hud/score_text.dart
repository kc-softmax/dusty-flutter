import 'package:dusty_flutter/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/layout.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class ScoreText extends SpriteComponent with HasGameRef<DustyIslandGame> {
  late TextComponent textComponent;
  late TextComponent labelComponent;

  ScoreText({required double x, required String label}) {
    sprite = gameRef.atlas.findSpriteByName('tree');
    size = Vector2(100, 45);
    anchor = Anchor.center;
    super.x = x;
    super.y = 40;

    labelComponent = TextComponent(
      text: label,
      textRenderer: TextPaint(
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
      )),
    )
      ..anchor = Anchor.center
      ..y = 100;

    textComponent = TextComponent(
      text: '',
      textRenderer: TextPaint(
          style: TextStyle(
        fontSize: 12.0,
        color: BasicPalette.white.color,
        shadows: [
          Shadow(
            color: BasicPalette.black.color,
            offset: const Offset(1, 1),
            blurRadius: 1,
          ),
        ],
      )),
    )..anchor = Anchor.center;

    addAll([
      AlignComponent(
        child: labelComponent,
        alignment: Anchor.topCenter,
      ),
      AlignComponent(
        child: textComponent,
        alignment: Anchor.center,
        keepChildAnchor: true,
      )..y += 10
    ]);
  }

  void updateScore(double score) {
    textComponent.text = '${(score * 100).roundToDouble()}%';
  }
}
