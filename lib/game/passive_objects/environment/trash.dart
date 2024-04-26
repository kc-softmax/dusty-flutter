import 'dart:math';
import 'dart:ui';
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game/characters/dusty.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/passive_objects/passive_objects_factory.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Trash extends SpriteComponent
    with HasGameRef<DustyIslandGame>, CollisionCallbacks, PassiveObjects {
  PassiveObjectMessage message;
  final movingSecond = 0.25;
  double aquireProgress = 0;
  double dx = 0; // x의 이동할 거리
  double dy = 0; // y의 이동할 거리
  double vx = 0; // x의 속도
  double vy = 0; // y의 속도
  double gravity = 5000.0; // 중력
  double lifeTime = -1;
  bool calib = false;
  late Vector2 startPosition;

  late Timer aquireTimer;
  late ShapeHitbox shapeHitbox;
  late final aquirePaint = Paint()
    ..color = const Color(0xdd33FF33)
    ..style = PaintingStyle.fill;
  late final aquireBgPaint = Paint()
    ..color = const Color(0xdd111736)
    ..style = PaintingStyle.fill;

  Trash(this.message) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final garbageList = gameRef.atlas.findSpritesByName('garbage');
    // garbage_0001
    Random random = Random();
    int index =
        random.nextInt(garbageList.length); // 0과 items.length - 1 사이의 랜덤 인덱스
    sprite = garbageList[index];

    final dusty = gameRef.playWorld!.dustyFactory.objects[message.generateBy];
    if (dusty != null) {
      startPosition = Vector2(dusty.x, dusty.y);
      lifeTime = movingSecond;
      dx = message.x - startPosition.x;
      dy = startPosition.y - message.y;
      vx = dx / lifeTime;
      vy = (dy + 0.5 * gravity * lifeTime * lifeTime) / lifeTime;
    } else {
      startPosition = Vector2(message.x, message.y);
    }
    // final rotateAngle = random.nextInt(11) - 5;
    // angle = pi * 0.01 * rotateAngle;
    x = startPosition.x;
    y = startPosition.y;
    aquireTimer = Timer(0.5, autoStart: false);
    shapeHitbox = RectangleHitbox(size: Vector2(24, 24))
      ..x = -(24 - size.x) * 0.5
      ..y = -(24 - size.y) * 0.5;
    add(shapeHitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (aquireTimer.isRunning()) {
      aquireTimer.update(dt);
      aquireProgress = aquireTimer.progress;
    } else {
      aquireProgress = 0;
    }
    if (lifeTime < 0) {
      // print('$x , $y , ${message.x} , ${message.y}');
      if (!calib && (x != message.x || y != message.y)) {
        calib = true;
        x = message.x;
        y = message.y;
      }
      return;
    }
    //get esliped time
    final elapsed = movingSecond - lifeTime;
    x = startPosition.x + vx * elapsed;
    y = startPosition.y - (vy * elapsed - 0.5 * gravity * elapsed * elapsed);
    lifeTime -= dt;
  }

  @override
  void render(Canvas canvas) {
    if (aquireTimer.isRunning()) {
      // renderSnapshot = true;
      final rect =
          Rect.fromLTWH(-width * 0.5, height * 0.33, width * 2, height);

      canvas.drawOval(rect, aquireBgPaint);

      const startAngle = -pi / 2;
      final sweepAngle = pi * 2 * aquireProgress;
      canvas.drawArc(rect, startAngle, sweepAngle, true, aquirePaint);
    }
    super.render(canvas);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is! Dusty) return;

    if (other.team == Team.alpha) return;
    // renderSnapshot = true;
    aquireTimer.start();
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (!isColliding) {
      // renderSnapshot = false;
      aquireTimer.stop();
      aquireProgress = 0;
    }
  }
}
