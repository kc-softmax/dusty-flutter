import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/tiles/tile_factory.dart';
import 'package:flame/components.dart';

class NormalTile extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, DustyTiles {}
