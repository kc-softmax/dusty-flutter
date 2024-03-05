import 'dart:ui';
import 'dart:math' as math;
import 'package:dusty_flutter/arbiter/live_service/game_message.dart';
import 'package:dusty_flutter/game.dart';
import 'package:dusty_flutter/passive_objects/passive_objects_factory.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Equipment extends SpriteAnimationComponent
    with HasGameRef<DustyIslandGame>, CollisionCallbacks, PassiveObjects {
  PassiveObjectType equipmentType;
  Equipment({required this.equipmentType}) : super(anchor: Anchor.center);

  double aquireProgress = 0;
  late Timer aquireTimer;
  late ShapeHitbox shapeHitbox;
  late final aquirePaint = Paint()
    ..color = const Color(0xdd33FF33)
    ..style = PaintingStyle.fill;
  late final aquireBgPaint = Paint()
    ..color = const Color(0xdd111736)
    ..style = PaintingStyle.fill;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('bm');
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
    aquireTimer = Timer(1, autoStart: false);
    shapeHitbox = RectangleHitbox();
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
  }

  @override
  void render(Canvas canvas) {
    if (aquireTimer.isRunning()) {
      final rect =
          Rect.fromLTWH(-width * 0.5, height * 0.33, width * 2, height);

      canvas.drawOval(rect, aquireBgPaint);

      const startAngle = -math.pi / 2;
      final sweepAngle = math.pi * 2 * aquireProgress;
      canvas.drawArc(rect, startAngle, sweepAngle, true, aquirePaint);
    }
    super.render(canvas);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    aquireTimer.start();
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (!isColliding) {
      aquireTimer.stop();
      aquireProgress = 0;
    }
  }
}
