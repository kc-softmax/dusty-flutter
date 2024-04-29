import 'package:flame/components.dart';

// 메시지 예시
// class BaseGameMessage {}

// class StoneMessage extends BaseGameMessage {}

// class DustyMessage extends BaseGameMessage {}

// 상위 추상화
// mixin SpawnObject<T extends BaseGameMessage> on PositionComponent {
//   onSpawn(T message);
//   onDespawn(T message);
// }

mixin SpawnObject on PositionComponent {
  spawn(Vector2 position);
  despawn(Vector2 position);
}

mixin MovementObject on PositionComponent {
  moveTo(Vector2 position);
}

mixin CombatObject {
  double hp = 0;
  attack();
  damaged();
  kill();
  dead();
}

mixin FarmingObject {
  farming({required DIObject target});
}

// 기본 오브젝트
mixin DIObject on PositionComponent implements SpawnObject {}

// 사용?
// 예시 1 - 중간 클래스 만들기
// 패시브 오브젝트
abstract class BasePassiveObject extends PositionComponent with DIObject {}

// 액티브 오브젝트
abstract class BaseActiveObject extends PositionComponent
    with DIObject, MovementObject {}

class Stone extends BasePassiveObject {
  @override
  spawn(Vector2 position) {}

  @override
  despawn(Vector2 position) {}
}

class Dusty extends SpriteGroupComponent implements BaseActiveObject {
  @override
  spawn(Vector2 position) {}

  @override
  despawn(Vector2 position) {}

  @override
  moveTo(Vector2 position) {}
}

// 예시 2 - 그냥 인터페이스로만
// 움직일 수 있고 전투에 참여하는 오브젝트
class Dusty2 extends SpriteGroupComponent
    with DIObject, CombatObject, MovementObject {
  @override
  spawn(Vector2 position) {}

  @override
  despawn(Vector2 position) {}

  @override
  attack() {}

  @override
  damaged() {}

  @override
  dead() {}

  @override
  kill() {}

  @override
  moveTo(Vector2 position) {}
}

// 기각
// mixin class HasObjectState<T> {
//   late T _currentState;
//   Set<T> states = {};

//   T get currentState => _currentState;

//   @mustBeOverridden
//   @mustCallSuper
//   set currentState(T value) {
//     assert(states.contains(value));
//     _currentState = value;
//     _updateState();
//   }

//   @mustBeOverridden
//   void initStates() {}

//   void _updateState() async {}
// }
