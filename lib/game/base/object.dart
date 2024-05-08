import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/game.dart';
import 'package:dusty_flutter/game/ui/gauge_bar.dart';
import 'package:dusty_flutter/models/protocols/parser.dart';
import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

mixin HasObjectState on Component, HasGameRef<DustyIslandGame> {
  void updateState(List<StateData> states);
}

mixin MovingObject on HasObjectState {
  late Vector2 nextPosition;
  late Vector2 direction;
  late double serverDelta;
  double speed = 0.0;
  double serverElapsedDelta = 0.0;

  Vector2 movement(double dt) {
    if (speed < 1) return Vector2(0, 0);
    final currentSpeed = serverElapsedDelta > serverDelta ? speed * 0.5 : speed;
    serverElapsedDelta += dt;
    return direction * currentSpeed * dt / serverDelta;
  }

  void moveTo(Vector2 currentPosition, Vector2 moveToPosition) {
    nextPosition = moveToPosition; // 새로운 목표 위치 설정
    direction = (nextPosition - currentPosition)
        .normalized(); // 현재 기준으로 target point 까지 방향을 지정해준다.
    speed = (nextPosition - currentPosition).length;
    serverElapsedDelta = 0;
  }
}

mixin DamagedObject on HasObjectState {
  // 또는 late double hp; 식으로 값만 mixin으로 가지고 있고,
  // 랜더링은 구현체에서 해당 값으로 하도록 하기
  late final HPGaugeBar hpGaugeBar;

  @mustCallSuper
  void getDamaged(double value) {
    hpGaugeBar.updateValue(value);
  }
}

mixin HittingObject on HasObjectState {
  void hit(DIObject? targetObject);
}

mixin CastingObject on HasObjectState {
  void casting(DIObject? targetObject);
}

mixin TargetingObject on HasObjectState {
  void targeting(DIObject targetObject);
}

mixin TargetedObject on HasObjectState {
  void targeted();
}

mixin DIObject implements PositionComponent, HasObjectState {
  // objectId를 ComponentKey로 넣는 것을 강제화하기 위한 변수
  // objectId는 late로 선언되어 있으므로 생성자에서 초기화해주지 않으면,
  // key를 참조할 때 런타임 에러가 발생.
  late final int objectId;

  void idle();

  @override
  ComponentKey? get key => ComponentKey.named(objectId.toString());

  @override
  void updateState(List<StateData> states) {
    for (StateData stateData in states) {
      if (stateData.state == null) continue;
      switch (stateData.state!) {
        case ObjectState.damaged:
          assert(this is DamagedObject);
          (this as DamagedObject).getDamaged(stateData.value);
          break;
        case ObjectState.moving:
          assert(this is MovingObject);
          (this as MovingObject).moveTo(
              position,
              Vector2(
                PositionParser.x(stateData.value),
                PositionParser.y(stateData.value),
              ));
          break;
        case ObjectState.hitting:
          assert(this is HittingObject);
          final target = gameRef.findDIObject(stateData.target);
          (this as HittingObject).hit(target);
          break;
        case ObjectState.casting:
          assert(this is CastingObject);
          final target = gameRef.findDIObject(stateData.target);
          (this as CastingObject).casting(target);
          break;
        case ObjectState.targeting:
          assert(this is TargetingObject && stateData.target != null);
          final target = gameRef.findDIObject(stateData.target);
          if (target != null) {
            (this as TargetingObject).targeting(target);
          }
          break;
        case ObjectState.targeted:
          assert(this is TargetedObject);
          (this as TargetedObject).targeted();
          break;
        case ObjectState.idle:
          idle();
      }
    }
  }
}
