import 'package:dusty_flutter/game/game_objects/active_objects/active_objects_factory.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/utils/vector.dart';
import 'package:dusty_flutter/mixins/object_mixin.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Stone extends SpriteAnimationComponent
    with
        HasGameRef<DustyIslandGame>,
        CollisionCallbacks,
        DIObject,
        ActiveObjects,
        MovingObject {
  double elapsedDelta = 0;
  double currentSpeed = 0;
  late final Vector2 initialPosition;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteList = gameRef.atlas.findSpritesByName('normal_stone');
    initialPosition = Vector2(x, y);
    size = Vector2.all(16);
    anchor = Anchor.center;
    positions.add(initialPosition);
    animation = SpriteAnimation.spriteList(
      spriteList,
      stepTime: 0.05,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (positions.length < 2) {
      position = positions.isNotEmpty ? positions.first : Vector2.zero();
    } else {
      // 타이머를 사용하여 서버 데이터 사이의 시간 간격 계산
      currentTime += dt;

      // t 값 계산 (0.0과 1.0 사이)
      double t = currentTime / gameRef.playWorld!.serverDelta;

      // 보간된 좌표 계산
      final nextPosition = interpolatePosition(
          positions.elementAt(0), positions.elementAt(1), t);
      angle = (nextPosition - initialPosition).screenAngle();
      position = nextPosition;

      // 타이머가 다음 좌표로 넘어갈 시간에 도달하면 버퍼에서 제거
      if (t >= 1.0) {
        currentTime -= gameRef.playWorld!.serverDelta;
        positions.removeFirst();
      }
    }
  }

  @override
  void moveTo(Vector2 position) {
    positions.add(position);
  }

  @override
  void idle() {}
}
