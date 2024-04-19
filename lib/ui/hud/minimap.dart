import 'dart:math';

import 'package:dusty_flutter/ui/const.dart';
import 'package:flame/camera.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

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

class MinimapCamera extends CameraComponent with HasGameRef<DustyIslandGame> {
  final Vector2 position;
  final double width;
  final double height;
  final double zoomLevel;

  late final MinimapCollisionDetection _collisionDetection;

  Vector2 get center => Vector2(width * 0.5, height * 0.5);

  MinimapCamera({
    required this.position,
    required this.width,
    required this.height,
    this.zoomLevel = 0.1,
  }) {
    world = gameRef.playWorld;
    viewport = FixedSizeViewport(width, height)
      ..position = position
      ..add(
        _collisionDetection = MinimapCollisionDetection()
          ..width = width
          ..height = height,
      );
    backdrop = RectangleComponent.fromRect(
      Rect.fromLTWH(
        0,
        0,
        width,
        height,
      ),
    )..setColor(Colors.black);
    viewfinder.zoom = zoomLevel;
  }

  @override
  void update(double dt) {
    // TODO 더 효율적인 방법
    final passiveObjectsFactory = gameRef.playWorld?.passiveObjectsFactory;
    if (passiveObjectsFactory == null) return;

    final objectKeys = passiveObjectsFactory.objects.keys;
    viewport.children
        .whereType<ArrowComponent>()
        .where((child) => !objectKeys.contains(child.objectId))
        .forEach((child) {
      child.removeFromParent();
    });

    passiveObjectsFactory.objects.forEach((key, value) {
      final existArrow = viewport.children
          .whereType<ArrowComponent>()
          .where((arrow) => arrow.objectId == key)
          .firstOrNull;
      if (existArrow == null) {
        setArrow(value.position, key);
      } else {
        updateArrow(value.position, existArrow);
      }
    });
  }

  void setArrow(Vector2 targetPosition, int objectId) {
    // 게임 중 화면에 보이는 것은 미니맵에 표시할 필요x
    if (_isPositionVisible(targetPosition)) return;

    final arrowPosition = _getArrowPosition(targetPosition);
    if (arrowPosition == null) return;
    // 화살표 표시
    viewport.add(
      ArrowComponent(
        objectId: objectId,
        radius: 5,
        position: arrowPosition,
      )..setColor(Colors.red),
    );
  }

  void updateArrow(Vector2 targetPosition, ArrowComponent arrow) {
    if (_isPositionVisible(targetPosition)) {
      // 미니맵에 나오면 화살표는 없앰
      arrow.removeFromParent();
      return;
    }

    final arrowPosition = _getArrowPosition(targetPosition);
    if (arrowPosition == null) return;

    // 화살표 위치 갱신
    arrow.position = arrowPosition;
  }

  Vector2 _caculateIntersectionPoint(Vector2 position, Vector2 targetPosition) {
    // 두 위치 사이의 벡터 계산
    Vector2 relativePosition = targetPosition - position;
    // atan2를 사용하여 상대적 위치 벡터의 각도 계산
    double angleRadians = atan2(relativePosition.y, relativePosition.x);
    // 방향 벡터 계산
    Vector2 direction = Vector2(cos(angleRadians), sin(angleRadians));
    if (direction.isNaN) return Vector2.zero();
    // 교차점 계산
    return _collisionDetection.getIntersectionPoint(center, direction);
  }

  bool _isPositionVisible(Vector2 worldPosition) {
    final rangeRect = Rect.fromCenter(
      center: gameRef.playWorld!.player!.position.toOffset(),
      width: width / viewfinder.zoom,
      height: height / viewfinder.zoom,
    );
    return rangeRect.containsPoint(worldPosition);
  }

  Vector2? _getArrowPosition(final targetPosition) {
    final result = _caculateIntersectionPoint(
      gameRef.playWorld!.player!.position,
      targetPosition,
    );
    if (result == Vector2.zero()) return null;
    return Vector2(min(result.x, width - 5 * 2), min(result.y, height - 5 * 2));
  }
}

class MinimapCollisionDetection extends RectangleComponent
    with HasCollisionDetection {
  MinimapCollisionDetection() {
    setColor(Colors.transparent);
    add(RectangleHitbox());
  }

  Vector2 getIntersectionPoint(Vector2 position, Vector2 direction) {
    final ray = Ray2(origin: position, direction: direction.normalized());
    final result = collisionDetection.raycast(ray);
    if (result?.intersectionPoint == null) return Vector2.zero();
    return Vector2(
      max(0, result!.intersectionPoint!.x),
      result.intersectionPoint!.y,
    );
  }
}

class ArrowComponent extends CircleComponent {
  final int objectId;

  ArrowComponent({required this.objectId, super.radius, super.position});
}
