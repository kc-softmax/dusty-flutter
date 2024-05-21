import 'dart:async';
import 'dart:math' hide Rectangle;

import 'package:dusty_flutter/game/base/object.dart';
import 'package:dusty_flutter/game/game_objects/dusty/dusty.dart';
import 'package:dusty_flutter/game/game_objects/passive_objects/environment/tree.dart';
import 'package:dusty_flutter/game/utils/map.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

class Minimap extends PositionComponent
    with HasGameRef<DustyIslandGame>, HasVisibility {
  static const arrowMarkerIdPrefix = 'arrow_';
  static const treeMarkerIdPrefix = 'tree_';
  static const dustyMarkerIdPrefix = 'dusty_';

  late final SpriteComponent map;
  late final ClipComponent clip;
  late final MinimapCollisionDetection minimapCollisionDetection;
  late final Vector2 originalPosition;
  late double originalZoom;
  final double range;
  final Vector2 lastPlayerPosition = Vector2.zero();
  final Map<int, DustyMarker> dustyMarkerMap = {};
  final Map<int, TreeMarker> treeMarkerMap = {};
  final Map<int, ArrowMarker> arrowMarkerMap = {};

  double minimapZoom;
  bool isFull = false;

  Minimap({super.size, super.position, required this.range})
      : minimapZoom = range * 0.25;

  @override
  FutureOr<void> onLoad() async {
    originalPosition = Vector2.copy(position);
    originalZoom = minimapZoom;

    final gameMap = gameRef.playWorld?.gameMap;
    assert(gameMap != null);
    map = SpriteComponent.fromImage(mapToImage(tileMap: gameMap!.tileMap))
      ..scale = Vector2.all(minimapZoom);
    addAll([
      clip = ClipComponent.rectangle(size: Vector2(width, height))
        ..addAll([map]),
      minimapCollisionDetection =
          MinimapCollisionDetection(size: Vector2(width, height))
    ]);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke // 테두리만 그리기
      ..strokeWidth = 2.0; // 테두리의 두께

    canvas.drawRect(size.toRect(), paint);
  }

  @override
  void update(double dt) {
    _updateMinimapPosition();
    _updateObjectMarker(
      gameRef.playWorld!.dustyFactory.objects,
      dustyMarkerMap,
    );
    _updateObjectMarker(
      gameRef.playWorld!.passiveObjectsFactory.objects,
      treeMarkerMap,
    );
    _updateArrowMarker();
  }

  void scaleToFull() {
    _scaleToFull(!isFull);
    isFull = !isFull;
  }

  void _updateMinimapPosition() {
    final playerPosition = gameRef.playWorld?.player?.position;
    if (playerPosition == null) return;

    Vector2 scaledPlayerPosition = _positionOfMinimap(playerPosition);
    Vector2 miniMapCenter = Vector2(width, height) * 0.5;
    Vector2 newPosition =
        miniMapCenter - scaledPlayerPosition; // new minimap position
    double xLimit = map.scaledSize.x - width;
    double yLimit = map.scaledSize.y - height;
    newPosition.x = newPosition.x.clamp(-xLimit, 0);
    newPosition.y = newPosition.y.clamp(-yLimit, 0);

    map.position = newPosition;

    lastPlayerPosition.x = playerPosition.x;
    lastPlayerPosition.y = playerPosition.y;
  }

  // NOTE
  // 각 이벤트에서 호출해주는 것이 좋을까?
  // 이렇게 하는 것이 나을까?
  // 효율성 측면에서는 각 이벤트에서 호출해주는 것이 나을 것 같은데
  // 생각해보니 미니맵의 range는 맵의 range보다 크기 때문에
  // factory에 없는 오브젝트를 그려줘야함. => 수정이 필요!
  void _updateObjectMarker(
      Map<int, DIObject> objectsMap, Map<int, PositionComponent> markerMap) {
    markerMap.removeWhere((key, value) {
      final removed = !objectsMap.containsKey(key);
      if (removed) {
        value.removeFromParent();
      }
      return removed;
    });

    for (var id in objectsMap.keys) {
      final object = objectsMap[id];
      final marker = markerMap[id];
      if (markerMap.containsKey(id)) {
        if (!_isVisiblOnMinimap(object!.position)) {
          markerMap.remove(id);
          marker!.removeFromParent();
          continue;
        }
        marker!.position = _positionOfMinimap(object.position) + map.position;
      } else {
        if (!_isVisiblOnMinimap(object!.position)) continue;
        PositionComponent? newMarker;
        if (object is Dusty) {
          newMarker = DustyMarker(
            objectId: '$dustyMarkerIdPrefix$id',
            radius: 20,
          )
            ..setColor(object.isPlayer ? Colors.blue : Colors.yellow)
            ..scale = Vector2.all(minimapZoom);
        } else if (object is Tree) {
          newMarker = TreeMarker(objectId: '$treeMarkerIdPrefix$id', radius: 20)
            ..scale = Vector2.all(minimapZoom);
        }
        if (newMarker == null) return;
        newMarker.position = _positionOfMinimap(object.position) + map.position;
        add(newMarker);
        markerMap[id] = newMarker;
      }
    }
  }

  void _updateArrowMarker() {
    final passiveObjectsMap = gameRef.playWorld?.passiveObjectsFactory.objects;
    if (passiveObjectsMap == null) return;

    // remove
    arrowMarkerMap.removeWhere((key, value) {
      final removed = !passiveObjectsMap.containsKey(key);
      if (removed) {
        value.removeFromParent();
      }
      return removed;
    });

    for (var id in passiveObjectsMap.keys) {
      final object = passiveObjectsMap[id];
      if (object is! Tree) continue;
      if (arrowMarkerMap.containsKey(id)) {
        // update
        final arrowMarker = arrowMarkerMap[id];
        if (_isVisiblOnMinimap(object.position)) {
          // 미니맵 시야에 나오면 기존 화살표는 없앰
          arrowMarkerMap.remove(id);
          arrowMarker!.removeFromParent();
          continue;
        }
        final arrowPosition = _getArrowPosition(object.position);
        if (arrowPosition == null) return;
        // 화살표 위치 갱신
        arrowMarker!.position = arrowPosition;
      } else {
        // add
        // 미니맵 시야에 있으면 화살표로 표시해줄 필요X
        if (_isVisiblOnMinimap(object.position)) continue;
        final arrowPosition = _getArrowPosition(object.position);
        if (arrowPosition == null) return;
        // 화살표 표시
        final arrowMarker = ArrowMarker(
          objectId: '$arrowMarkerIdPrefix$id',
          radius: 5,
          position: arrowPosition,
        );
        arrowMarkerMap[id] = arrowMarker;
        parent?.add(arrowMarker); //arrowPostion이 world 기준 포지션
      }
    }
  }

  Vector2? _getArrowPosition(final targetPosition) {
    final result = _caculateIntersectionPoint(
      _positionOfMinimap(lastPlayerPosition),
      _positionOfMinimap(targetPosition),
    );
    if (result == Vector2.zero()) return null;
    double xLimit = position.x + width - 10;
    double yLimit = position.y + height - 10;
    return Vector2(min(result.x, xLimit), min(result.y, yLimit));
    // return result;
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
    return minimapCollisionDetection.getIntersectionPoint(center, direction);
  }

  bool _isVisiblOnMinimap(Vector2 position) {
    final rangeRect = Rect.fromCenter(
      center: gameRef.playWorld!.player!.position.toOffset(),
      width: scaledSize.x / minimapZoom,
      height: scaledSize.y / minimapZoom,
    );
    return rangeRect.containsPoint(position);
  }

  Vector2 _positionOfMinimap(Vector2 position) => position * minimapZoom;

  void _scaleToFull(bool isFull) {
    if (isFull) {
      final gameSize = gameRef.canvasSize;
      final fullSize = Vector2.all(gameSize.y * 0.8);

      final newScale = Vector2(fullSize.x / size.x, fullSize.y / size.y);
      scale = newScale;
      minimapCollisionDetection.scale = newScale;

      final newMapScale = Vector2(size.x / map.size.x, size.y / map.size.y);
      map.scale = newMapScale;
      minimapZoom = newMapScale.x;

      for (var dustyMarker in dustyMarkerMap.values) {
        dustyMarker.scale = newMapScale;
      }
      for (var treeMarker in treeMarkerMap.values) {
        treeMarker.scale = newMapScale;
      }
      final newX = gameSize.x * 0.5 - scaledSize.x * 0.5;
      final newY = gameSize.y * 0.5 - scaledSize.y * 0.5;
      position = Vector2(newX, newY);
      return;
    }
    scale = Vector2.all(1);
    minimapCollisionDetection.scale = Vector2.all(1);
    final originalScale = Vector2.all(originalZoom);
    map.scale = originalScale;
    minimapZoom = originalZoom;
    for (var dustyMarker in dustyMarkerMap.values) {
      dustyMarker.scale = originalScale;
    }
    for (var treeMarker in treeMarkerMap.values) {
      treeMarker.scale = originalScale;
    }
    position = Vector2.copy(originalPosition);
  }
}

class MinimapCollisionDetection extends RectangleComponent
    with HasCollisionDetection {
  MinimapCollisionDetection({required super.size}) {
    setColor(Colors.transparent);
    add(RectangleHitbox(size: super.size));
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

class ArrowMarker extends CircleComponent with HasVisibility {
  final String objectId;

  ArrowMarker({required this.objectId, super.radius, super.position}) {
    setColor(Colors.red);
  }
}

class TreeMarker extends CircleComponent {
  final String objectId;

  TreeMarker({required this.objectId, super.radius, super.position}) {
    setColor(Colors.purple);
  }
}

class DustyMarker extends CircleComponent {
  final String objectId;

  DustyMarker({required this.objectId, super.radius, super.position});
}
