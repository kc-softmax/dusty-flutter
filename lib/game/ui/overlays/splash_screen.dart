import 'package:flame/game.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';

class GameSplashScreen extends StatelessWidget {
  final GameWidget gameWidget;

  const GameSplashScreen({
    super.key,
    required this.gameWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FlameSplashScreen(
      theme: FlameSplashTheme.dark,
      showBefore: (BuildContext context) {
        return const Text(
          "FOURBARRACKS STUDIO",
          style:
              TextStyle(color: Colors.white, decoration: TextDecoration.none),
        );
      },
      onFinish: (context) => Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => gameWidget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
