import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/models/protocols/parser.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_event.freezed.dart';
part 'game_event.g.dart';

enum EventType {
  @JsonValue(1)
  generate,
  @JsonValue(2)
  update,
  @JsonValue(3)
  remove
}

enum Team {
  @JsonValue(1)
  alpha(1),
  @JsonValue(2)
  beta(2),
  @JsonValue(3)
  neutral(3);

  final int code;
  const Team(this.code);
  factory Team.parse(int code) =>
      Team.values.firstWhere((state) => code == state.code);
}

enum ActiveObjectType {
  @JsonValue(1)
  normalMissaile,
  @JsonValue(2)
  normalPunch,
  @JsonValue(3)
  normalGrenade
}

enum PassiveObjectType {
  @JsonValue(1)
  tree(1),
  @JsonValue(2)
  artifact(2);

  final int code;
  const PassiveObjectType(this.code);
  factory PassiveObjectType.parse(int code) =>
      PassiveObjectType.values.firstWhere((state) => code == state.code);
}

enum ObjectState {
  @JsonValue(1)
  idle,
  @JsonValue(2)
  moving,
  @JsonValue(3)
  hitting,
  @JsonValue(4)
  casting,
  @JsonValue(5)
  damaged,
  @JsonValue(6)
  invisible;
}

@freezed
class StateData with _$StateData {
  const factory StateData({ObjectState? state, int? target, dynamic value}) =
      _StateData;

  factory StateData.fromJson(Map<String, dynamic> json) =>
      _$StateDataFromJson(json);
}

mixin BaseEvent {
  EventType get eventType;
}

mixin HasPosition {
  int? position;
  double get x => PositionParser.x(position!);
  double get y => PositionParser.y(position!);
}

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent(
      {List<DustyEvent>? dusties,
      List<ActiveObjectEvent>? activeObjects,
      List<PassiveObjectEvent>? passiveObjects,
      SystemEvent? systemEvent}) = _GameEvent;

  factory GameEvent.fromJson(Map<String, dynamic> json) =>
      _$GameEventFromJson(json);
}

@freezed
class SystemEvent with _$SystemEvent {
  const factory SystemEvent({
    int? followId,
    int? remainTime,
  }) = _SystemEvent;

  factory SystemEvent.fromJson(Map<String, dynamic> json) =>
      _$SystemEventFromJson(json);
}

@freezed
class DustyEvent with _$DustyEvent, BaseEvent, HasPosition {
  DustyEvent._();

  factory DustyEvent({
    required int objectId,
    required EventType eventType,
    List<StateData>? states,
    String? name,
    bool? isPlayer,
    Team? team,
    int? status,
    int? position,
    int? targetId,
    int? killerId,
    int? quantity,
    int? defence,
  }) = _DustyEvent;

  get direction => StatusParser.direction(status!);
  get activeAvailable => StatusParser.activeAvailable(status!);
  get specialAvailable => StatusParser.specialAvailable(status!);
  get special2Available => StatusParser.special2Available(status!);
  get finishAvailable => StatusParser.finishAvailable(status!);
  get boostAvailable => StatusParser.boostAvailable(status!);
  get isFinishing => StatusParser.isFinishing(status!);
  get isShield => StatusParser.isShield(status!);
  get equipment1 => StatusParser.equipment1(status!);
  get equipment2 => StatusParser.equipment2(status!);
  FinishType get finishType => StatusParser.finishType(status!);
  get finishGauge => StatusParser.finishGauge(status!);
  DustyState get dustyState => StatusParser.dustyState(status!);

  factory DustyEvent.fromJson(Map<String, dynamic> json) =>
      _$DustyEventFromJson(json);
}

@freezed
class ActiveObjectEvent with _$ActiveObjectEvent, BaseEvent, HasPosition {
  ActiveObjectEvent._();

  factory ActiveObjectEvent({
    required int objectId,
    required EventType eventType,
    int? team,
    double? directionX,
    double? directionY,
    double? gravity,
    double? lifeStep,
    int? speed,
    int? position,
    int? destination,
    int? targetId,
    int? ownerId,
    ActiveObjectType? objectType,
  }) = _ActiveObjectEvent;

  double get dstX => PositionParser.x(destination!);
  double get dstY => PositionParser.y(destination!);

  factory ActiveObjectEvent.fromJson(Map<String, dynamic> json) =>
      _$ActiveObjectEventFromJson(json);
}

@freezed
class PassiveObjectEvent with _$PassiveObjectEvent, BaseEvent, HasPosition {
  PassiveObjectEvent._();

  factory PassiveObjectEvent({
    required int objectId,
    required EventType eventType,
    int? position,
    PassiveObjectType? objectType,
  }) = _PassiveObjectEvent;

  factory PassiveObjectEvent.fromJson(Map<String, dynamic> json) =>
      _$PassiveObjectEventFromJson(json);
}
