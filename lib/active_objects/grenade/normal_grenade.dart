import 'dart:async';
import 'dart:math';
import 'package:dusty_flutter/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

Vector2 findPerpendicularPoint(Vector2 a, Vector2 b, Vector2 p) {
  // 직선 AB의 기울기 계산
  double slopeAB = (b.y - a.y) / (b.x - a.x);
  // 직선 AB에 수직인 선의 기울기 (AB의 역수의 음수)
  double slopePerpendicular = -1 / slopeAB;
  // 점 P에서 AB로 내린 수직선의 방정식은 y - p.y = slopePerpendicular * (x - p.x)
  // 이를 y = mx + c 형태로 변환하여 y절편 구하기
  double intercept = p.y - slopePerpendicular * p.x;

  // AB의 방정식은 y = slopeAB * x + c. 여기서 c 구하기
  double interceptAB = a.y - slopeAB * a.x;

  // 두 직선의 교점을 찾기 위해 연립방정식 풀이
  double xIntersection =
      (intercept - interceptAB) / (slopeAB - slopePerpendicular);
  double yIntersection = slopeAB * xIntersection + interceptAB;

  // 교점 반환
  return Vector2(xIntersection, yIntersection);
}

// Vector2 findPerpendicularPoint(Vector2 a, Vector2 b, Vector2 p) {
//   // 직선 AB의 기울기
//   double slopeAB = (b.y - a.y) / (b.x - a.x);
//   // 직선 AB의 y절편
//   double interceptAB = a.y - slopeAB * a.x;
//   // 점 P에서 직선 AB에 내린 수직선의 기울기
//   double slopePerpendicular = -1 / slopeAB;
//   // 수직선의 y절편
//   double interceptPerpendicular = p.y - slopePerpendicular * p.x;

//   // 교점 Q의 x 좌표
//   double x =
//       (interceptPerpendicular - interceptAB) / (slopeAB - slopePerpendicular);
//   // 교점 Q의 y 좌표
//   double y = slopeAB * x + interceptAB;

//   return Vector2(x, y);
// }

class NormalGrenade extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, CollisionCallbacks, ActiveObjects {
  ActiveObjectMessage message;

  late double dx; // x의 이동할 거리
  late double dy; // y의 이동할 거리
  late double vx; // x의 속도
  late double vy; // y의 속도
  late double gravity; // 중력
  late Vector2 startPosition;
  late double lifeTime;
  late Vector2 destination;
  late CircleComponent shadow;

  NormalGrenade({
    required this.message,
  }) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('blue_bomb');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
    startPosition = Vector2(x, y);
    destination = Vector2(message.dstX, message.dstY);
    // rotate angle start pos -> destination
    Vector2 direction = destination - startPosition;
    double angle = atan2(direction.y, direction.x);
    angle = angle;
    lifeTime = message.lifeStep!.toDouble();
    gravity = message.gravity! * 0.1;
    dx = destination.x - startPosition.x;
    dy = startPosition.y - destination.y;
    vx = dx / lifeTime;
    vy = (dy + 0.5 * gravity * lifeTime * lifeTime) / lifeTime;
    final lifeTimeSec = lifeTime / gameRef.playScene.gameConfig!.frameRate;
    add(ScaleEffect.to(
      Vector2.all(2),
      EffectController(duration: lifeTimeSec / 2, alternate: true),
    ));
    shadow = CircleComponent(
      radius: size.x / 2,
    )
      ..anchor = Anchor.topCenter
      ..scale = Vector2.all(0.5);
    shadow.add((ScaleEffect.to(
      Vector2.all(1),
      EffectController(duration: lifeTimeSec / 2, alternate: true),
    ))
      ..onComplete = () {
        shadow.removeFromParent();
      });

    gameRef.world.add(shadow);
  }

  @override
  void update(double dt) {
    super.update(dt);
    //get esliped time
    final elapsed = message.lifeStep! - lifeTime;
    x = startPosition.x + vx * elapsed;
    y = startPosition.y - (vy * elapsed - 0.5 * gravity * elapsed * elapsed);
    // shadow is orthogonal point (x, y) to start to destination line
    shadow.position =
        findPerpendicularPoint(startPosition, destination, Vector2(x, y));

    // if x, y closed to destination, then transparent
    final distance = Vector2(x, y).distanceTo(destination);
    if (distance < 10) {
      shadow.setOpacity(0);
      setOpacity(0);
    }

    lifeTime -= dt / gameRef.playScene.serverDelta;
  }
}
