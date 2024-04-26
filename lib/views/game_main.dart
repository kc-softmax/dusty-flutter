import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/ui/overlays/pre_start_text.dart';
import 'package:dusty_flutter/game/worlds/lobby.dart';
import 'package:dusty_flutter/states/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainGameView extends StatelessWidget {
  final DustyIslandGame game;
  MainGameView({super.key}) : game = DustyIslandGame();

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    game.focusNode = focusNode;

    final isReset = Provider.of<GameModel>(context).isReset;
    if (isReset) {
      //TODO rotuer와 wolrd의 합체
      game.rootRouter.popUntilNamed('/');
      game.world = LobbySceneWorld();
    }

    return GameWidget(
      game: game,
      overlayBuilderMap: {
        PreStartText.name: (context, game) => const PreStartText(),
      },
      focusNode: focusNode,
    );
  }
}
