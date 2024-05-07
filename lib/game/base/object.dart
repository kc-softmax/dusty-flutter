import 'dart:collection';

import 'package:dusty_flutter/arbiter/live_service/game_event.dart';
import 'package:dusty_flutter/game/ui/gauge_bar.dart';
import 'package:dusty_flutter/models/protocols/parser.dart';
import 'package:flame/components.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

mixin HasObjectState on Component {
  void updateState(List<StateData> states);
  void idle();
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

mixin HpObject on HasObjectState {
  late final HPGaugeBar hpGaugeBar;

  @mustCallSuper
  void getDamaged(double value) {
    hpGaugeBar.updateValue(value);
  }
}

abstract mixin class DIObject implements PositionComponent, HasObjectState {
  @override
  void updateState(List<StateData> states) {
    for (StateData stateData in states) {
      switch (stateData.state) {
        case ObjectState.damaged:
          assert(this is HpObject);
          (this as HpObject).getDamaged(stateData.value);
          break;
        case ObjectState.moving:
          assert(this is MovingObject);
          (this as MovingObject).moveTo(
              position,
              Vector2(
                PositionParser.x(stateData.value),
                PositionParser.y(stateData.value),
              ));
        case ObjectState.idle:
          idle();
        default:
      }
    }
  }
}
