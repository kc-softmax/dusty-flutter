import 'dart:ui';
import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game.dart';

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

  void updateTile(int x, int y, int team) {
    final mapWidth = gameRef.mapComponent.tileMap.map.width;
    final mapHeight = gameRef.mapComponent.tileMap.map.height;
    final xRatio = size.x / mapWidth.toDouble();
    final yRatio = size.y / mapHeight.toDouble();
    final rect = Rect.fromLTWH(x * xRatio, y * yRatio, xRatio, yRatio);
    if (team == 1) {
      alphaTiles.add(rect);
    } else if (team == 2) {
      betaTiles.add(rect);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // minimap ratio should be 3:2
    assert(gameRef.mapComponent.tileMap.map.width /
            gameRef.mapComponent.tileMap.map.height ==
        3 / 2);
    final mapWidth = gameRef.mapComponent.tileMap.map.width;
    final mapHeight = gameRef.mapComponent.tileMap.map.height;
    size = Vector2(144, 96); // const value
    position = Vector2(gameRef.size.x - size.x - 16, 16);
    // change the color of the minimap
    paint.color = normalSeaColor;

    // draw default island get from mapcomponent
    // currently, it's not implemented
    // so just draw hard-coded island
    // lt - 11,7
    xRatio = size.x / mapWidth.toDouble();
    yRatio = size.y / mapHeight.toDouble();
    islands.add(
      Rect.fromLTWH(11 * xRatio, 7 * yRatio, 25 * xRatio, 17 * yRatio),
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // draw border
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), borderPaint);

    // draw islands maybe TODO update polygon?
    for (final rect in islands) {
      canvas.drawRect(rect, islandPaint);
    }
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
