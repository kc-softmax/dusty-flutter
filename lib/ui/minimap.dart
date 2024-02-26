import 'dart:ui';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Minimap extends RectangleComponent with HasGameRef<DustyIslandGame> {
  late Color borderColor;
  late double xRatio;
  late double yRatio;
  List<Rect> alphaTiles = [];
  List<Rect> betaTiles = [];
  List<Rect> islands = []; // TODO update polygon?

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

  void updateTile(int x, int y, Team team) {
    final mapWidth = gameRef.mapComponent.tileMap.map.width;
    final mapHeight = gameRef.mapComponent.tileMap.map.height;
    final xRatio = size.x / mapWidth.toDouble();
    final yRatio = size.y / mapHeight.toDouble();
    final rect = Rect.fromLTWH(x * xRatio, y * yRatio, xRatio, yRatio);
    switch (team) {
      case Team.alpha:
        alphaTiles.add(rect);
        break;
      case Team.beta:
        betaTiles.add(rect);
        break;
      default:
        islands.add(rect);
        break;
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // minimap ratio should be 3:2
    // 80 vs 60
    assert(gameRef.mapComponent.tileMap.map.width /
            gameRef.mapComponent.tileMap.map.height ==
        4 / 3);
    final mapWidth = gameRef.mapComponent.tileMap.map.width;
    final mapHeight = gameRef.mapComponent.tileMap.map.height;
    size = Vector2(144, 108); // const value
    position = Vector2(gameRef.size.x - size.x - 16, 16);
    // change the color of the minimap
    paint.color = normalSeaColor;
    final islandLayer =
        gameRef.mapComponent.tileMap.getLayer('island') as TileLayer;

    for (var row = 0; row < islandLayer.tileData!.length; row++) {
      for (var col = 0; col < islandLayer.tileData![row].length; col++) {
        final tile = islandLayer.tileData![row][col];
        if (tile.tile > 0) {
          updateTile(col, row, Team.neutral);
        }
      }
    }
    for (final rect in islands) {
      // add(RectangleComponent.fromRect(rect));
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // draw border
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), borderPaint);

    // draw islands maybe TODO update polygon?
    // for (final rect in islands) {
    //   canvas.drawRect(rect, islandPaint);
    // }
    // draw alpha tiles
    for (final rect in alphaTiles) {
      canvas.drawRect(rect, alphaTilePaint);
    }
    // draw beta tiles
    for (final rect in betaTiles) {
      canvas.drawRect(rect, betaTilePaint);
    }
  }
}
