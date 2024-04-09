import 'dart:ui';

import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Minimap extends RectangleComponent
    with HasGameRef<DustyIslandGame>, Snapshot {
  late Color borderColor;
  late double xRatio;
  late double yRatio;

  final Paint alphaTilePaint = Paint()
    ..color = alphaTeamColor
    ..style = PaintingStyle.fill;
  final Paint betaTilePaint = Paint()
    ..color = betaTeamColor
    ..style = PaintingStyle.fill;
  final borderPaint = Paint()
    ..color = neturalColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  final islandPaint = Paint()
    ..color = neturalColor
    ..style = PaintingStyle.fill;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // minimap ratio should be 3:2
    // 80 vs 60

    final mapWidth = gameRef.mapComponent.tileMap.map.width;
    final mapHeight = gameRef.mapComponent.tileMap.map.height;
    size = Vector2(144, 108); // const value
    position = Vector2(gameRef.size.x - size.x - 16, 16);
    // change the color of the minimap
    paint.color = normalSeaColor;
    final islandLayer =
        gameRef.mapComponent.tileMap.getLayer('restrict') as TileLayer;
    for (final data in islandLayer.tileData!) {
      // data.
      // for (final gid in data) {

      // }
    }
  }
}
