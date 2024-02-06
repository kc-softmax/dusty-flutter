import 'dart:async';

import 'package:dusty_flutter/game.dart';
import 'package:flame/components.dart';

class LobbyScene extends Component with HasGameRef<DustyIslandGame> {
  static const routerName = "lobby";

  @override
  FutureOr<void> onLoad() {
    gameRef.overlays.add('StartButton');
  }
}
