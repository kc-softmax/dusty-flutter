import 'dart:async';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/scenes/lobby_scene.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Background extends Component {
  Background(this.color);
  final Color color;

  @override
  void render(Canvas canvas) {
    canvas.drawColor(color, BlendMode.srcATop);
  }
}

class LoadingScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = 'loading';
  static const progressPeriod = 10;
  static const finishProgress = 100;
  static const minimumHoldingTime = progressPeriod * finishProgress * 0.1;

  int currnetProgress = 0;
  bool isReGame = false;

  LoadingScene({this.isReGame = false});

  late final TextBoxComponent tb;
  @override
  FutureOr<void> onLoad() async {
    addAll([
      // Background(const Color(0xff282828)),
      tb = TextBoxComponent(
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0x66ffffff),
            fontSize: 16,
          ),
        ),
        align: Anchor.center,
        size: game.canvasSize,
      ),
    ]);

    Stream<int>.periodic(const Duration(milliseconds: progressPeriod), (x) => x)
        .take(finishProgress + 1)
        .forEach((progress) async {
      if (gameRef.isFinishLoadAllResource &&
          progressPeriod * progress > minimumHoldingTime) {
        currnetProgress = finishProgress;
        return;
      }
      currnetProgress = progress;
    });
  }

  @override
  void update(double dt) async {
    tb.text = currnetProgress.toString();
    if (gameRef.isFinishLoadAllResource && currnetProgress >= finishProgress) {
      if (gameRef.isVerified) {
        if (isReGame) {
          gameRef.router.pushReplacementNamed(PlayScene.routerName);
        } else {
          gameRef.router.pushReplacementNamed(LobbyScene.routerName);
        }
      } else {
        gameRef.router.pushOverlay('login-dialog');
      }
    }
  }
}
