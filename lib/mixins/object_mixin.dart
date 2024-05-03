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
  // TODO dusty는 사용안함
  final Queue<Vector2> positions = Queue<Vector2>();
  double currentTime = 0.0;
  void moveTo(Vector2 position);
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
          (this as MovingObject).moveTo(Vector2(
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
