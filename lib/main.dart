import 'package:dusty_flutter/arbiter/api/models.dart';
import 'package:dusty_flutter/scenes/play_scene.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/widgets/splash_screen.dart';
import 'package:dusty_flutter/arbiter/arbiter_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DustyIslandApp extends StatelessWidget {
  const DustyIslandApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: GameSplashScreen(
        gameWidget: buildGame(),
      ),
    );
  }
}

GameWidget<DustyIslandGame> buildGame() {
  return GameWidget.controlled(
    gameFactory: DustyIslandGame.new,
    overlayBuilderMap: {
      "TestInputNickname": (context, game) {
        final controller = TextEditingController();
        return Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 36,
                  child: TextField(
                    controller: controller,
                  ),
                ),
                FilledButton(
                    onPressed: () async {
                      final result = await Arbiter.api.loginByUserName(
                          RequestLoginByUserName(
                              userName: controller.value.text));
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString("token", result.accessToken);
                      game.overlays.remove('TestInputNickname');
                      game.router.pushReplacementNamed(PlayScene.routerName);
                    },
                    child: const Text("시작")),
              ],
            ),
          ),
        );
      },
      "TestButton": (BuildContext context, DustyIslandGame game) {
        return FilledButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              final token = prefs.getString("token");
              Arbiter.liveService.on(
                "/di/ws?token=$token",
                (message) {
                  debugPrint(message.toString());
                },
              );
            },
            child: const Text("TEST"));
      }
    },
  );
}

void main() {
  runApp(const DustyIslandApp());
}
