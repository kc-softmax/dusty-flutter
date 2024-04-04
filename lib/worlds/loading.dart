import 'dart:async';
import 'dart:math';
import 'package:dusty_flutter/effects/sound/dusty_sound.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/flame_texturepacker.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

class LoadingSceneWorld extends World with HasGameRef<DustyIslandGame> {
  final progressPeriod = 100;
  final initialProgress = 0.5;
  final finishProgress = 100.0;
  final minimumHoldingTime = 1000;

  bool isFinishLoadAllResource = false;
  bool isAllowToNext = false;
  bool isFin = false;
  double currnetProgress = 0;

  late SvgComponent loadingBar;
  late SvgComponent loadingGauge;
  late PauseEffectController loadingEffectController;

  @override
  FutureOr<void> onLoad() async {
    // add UI
    await addBackground();
    await addLogoText();
    await addLoadingBar();
    addLoadingText();

    // load Assets
    loadAssets();

    // progress
    Stream<int>.periodic(Duration(milliseconds: progressPeriod), (x) => x)
        .takeWhile((_) => !isAllowToNext)
        .forEach((progress) async {
      if (isFinishLoadAllResource &&
          progressPeriod * progress >= minimumHoldingTime) {
        currnetProgress = finishProgress;
        isAllowToNext = true;
        return;
      }
      currnetProgress = progress.toDouble();
    });
  }

  @override
  void update(double dt) async {
    if (isAllowToNext) {
      if (isFin) return;
      isFin = true;
      loadingGauge.add(ScaleEffect.to(
        Vector2(1, 1),
        EffectController(duration: 0.5),
        onComplete: () => {gameRef.world = DustyIslandWorld(false)},
      ));
    } else {
      loadingGauge.add(ScaleEffect.to(
        Vector2(min(1, initialProgress + currnetProgress / finishProgress), 1),
        EffectController(duration: 0.01),
      ));
    }
  }

  Future<void> addBackground() async {
    final bgImage = await Flame.images.load('loading/loading_bg.png');
    add(
      SpriteComponent.fromImage(
        bgImage,
        anchor: Anchor.center,
        size: gameRef.canvasSize,
      )..add(
          RectangleComponent.fromRect(Rect.largest)
            ..setColor(
              Colors.black.withOpacity(0.5),
            ),
        ),
    );
  }

  Future<void> addLogoText() async {
    final textLogoSvg = await Svg.load('images/loading/text_logo.svg');
    add(SvgComponent(
      size: gameRef.canvasSize * 0.5,
      svg: textLogoSvg,
      anchor: Anchor.center,
      position: Vector2(0, -120),
    ));
  }

  void addLoadingText() async {
    add(TextComponent(
      text: 'Loading...',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: 'ONEMobilePOP',
          fontSize: 48,
          color: Colors.white,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(0, gameRef.canvasSize.y * 0.5 - 192),
    ));
  }

  Future<void> addLoadingBar() async {
    final loadingBarSvg = await Svg.load('images/loading/loading_bar.svg');
    final loadingGaugeSvg = await Svg.load('images/loading/loading_gauge.svg');

    final barWidth = min(
      gameRef.canvasSize.x * 0.98,
      loadingBarSvg.pictureInfo.size.width * 0.98,
    );
    final barHeight = loadingBarSvg.pictureInfo.size.height;

    loadingBar = SvgComponent(
      size: Vector2(
        barWidth,
        barHeight,
      ),
      svg: loadingBarSvg,
      anchor: Anchor.center,
      position: Vector2(0, gameRef.canvasSize.y * 0.5 - 96),
    );

    final gaugeWidth = barWidth - 20;
    final gaugeHeight = loadingGaugeSvg.pictureInfo.size.height;
    loadingGauge = SvgComponent(
      size: Vector2(
        gaugeWidth,
        gaugeHeight,
      ),
      position: Vector2((barWidth - gaugeWidth) * 0.5,
          (loadingBarSvg.pictureInfo.size.height - gaugeHeight) * 0.5),
      svg: loadingGaugeSvg,
      scale: Vector2(initialProgress, 1),
    );

    add(loadingBar..add(loadingGauge));
  }

  void loadAssets() async {
    // sound
    await DustySoundPool.instance.load();
    // sprites
    gameRef.atlas = await gameRef.fromAtlas('images/dusty-island.atlas');
    // map
    gameRef.mapComponent =
        await TiledComponent.load('ultimate_map.tmx', Vector2.all(32));

    isFinishLoadAllResource = true;
  }
}

// final token = (await SharedPreferences.getInstance()).getString('token');
// isVerified = token != null && await Arbiter.api.verifyToken(token);
