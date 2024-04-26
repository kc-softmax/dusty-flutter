import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/ui/hud/hud.dart';
import 'package:dusty_flutter/game/worlds/play.dart';
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
    final currentWorld = gameRef.world;
    if (currentWorld is! PlaySceneWorld) throw ('게임 플레이 중이 아닙니다.');
    currentWorld.isSoundOn = !currentWorld.isSoundOn;
    textComponent.text = _getSoundEmoji();
  }

  String _getSoundEmoji() {
    final currentWorld = gameRef.world;
    if (currentWorld is! PlaySceneWorld) throw ('게임 플레이 중이 아닙니다.');
    if (currentWorld.isSoundOn) return '\u{1F50A}';
    return '\u{1F507}';
  }
}
