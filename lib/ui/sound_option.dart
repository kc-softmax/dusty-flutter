import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/ui/hud.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/layout.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class SoundOptionButton extends SpriteComponent
    with HasGameRef<DustyIslandGame>, TapCallbacks {
  late TextComponent textComponent;

  SoundOptionButton() {
    sprite = gameRef.atlas.findSpriteByName('rank_bg');
    size = Hud.smallButtonSize;
    anchor = Anchor.center;
    super.x = gameRef.size.x - 64;
    super.y = 40;

    textComponent = TextComponent(
      text: _getSoundEmoji(),
      textRenderer: TextPaint(
          style: TextStyle(
        fontSize: 24.0,
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

    add(AlignComponent(
      child: textComponent,
      alignment: Anchor.center,
      keepChildAnchor: true,
    ));
  }

  @override
  void onTapUp(TapUpEvent event) {
    gameRef.playScene.isSoundOn = !gameRef.playScene.isSoundOn;
    textComponent.text = _getSoundEmoji();
  }

  String _getSoundEmoji() {
    if (gameRef.playScene.isSoundOn) return '\u{1F50A}';
    return '\u{1F507}';
  }
}
