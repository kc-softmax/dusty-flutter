import 'package:dusty_flutter/models/protocols/const.dart';
import 'package:dusty_flutter/models/protocols/parser.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_message.freezed.dart';
part 'game_message.g.dart';

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
  @JsonValue(0)
  idle(0),
  @JsonValue(4)
  bush4X4(4),
  @JsonValue(5)
  bush(5),
  @JsonValue(6)
  trash(6);

  final int code;
  const PassiveObjectType(this.code);
  factory PassiveObjectType.parse(int code) =>
      PassiveObjectType.values.firstWhere((state) => code == state.code);
}

enum RemoveBy {
  @JsonValue(1)
  unknown,
  @JsonValue(2)
  flame,
  @JsonValue(3)
  missaile,
  @JsonValue(4)
  punch,
  @JsonValue(5)
  lightning,
}

mixin BaseMessage {
  EventType get eventType;
  RemoveBy? get removeBy;
}

mixin HasPosition {
  int? position;
  double get x => PositionParser.x(position!);
  double get y => PositionParser.y(position!);
}

@freezed
class GameMessage with _$GameMessage {
  const factory GameMessage({
    GameConfig? gameConfig,
    List<DustyMessage>? dusties,
    List<ActiveObjectMessage>? actives,
    List<PassiveObjectMessage>? passives,
    List<TileMessage>? tiles,
  }) = _GameMessage;

  factory GameMessage.fromJson(Map<String, dynamic> json) =>
      _$GameMessageFromJson(json);
}

@freezed
class GameConfig with _$GameConfig {
  const factory GameConfig({
    required int playerId,
    required int frameRate,
    required int boostDuration,
    required int shieldDuration,
    required int finishDuration,
    required int boostSkillReloadTime,
    required int activeSkillDuration,
    required int specialSkillReloadTime,
    required int special2SkillReloadTime,
    required int raftReloadTime,
    required int respawnTime,
    required int grenadePowerUnit,
    required int defaultPunchRange,
    required int autoTargetingRange,
    required int autoTargetingAngle,
    required int totalOccupyableRegion,
  }) = _GameConfig;

  factory GameConfig.fromJson(Map<String, dynamic> json) =>
      _$GameConfigFromJson(json);
}

@freezed
class DustyMessage with _$DustyMessage, BaseMessage, HasPosition {
  DustyMessage._();

  factory DustyMessage({
    required int dustyId,
    required EventType eventType,
    String? name,
    Team? team,
    int? status,
    int? position,
    int? targetId,
    int? killerId,
    int? quantity,
    int? defence,
    RemoveBy? removeBy,
  }) = _DustyMessage;

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

  factory DustyMessage.fromJson(Map<String, dynamic> json) =>
      _$DustyMessageFromJson(json);
}

@freezed
class ActiveObjectMessage with _$ActiveObjectMessage, BaseMessage, HasPosition {
  ActiveObjectMessage._();

  factory ActiveObjectMessage({
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
    RemoveBy? removeBy,
  }) = _ActiveObjectMessage;

  double get dstX => PositionParser.x(destination!);
  double get dstY => PositionParser.y(destination!);

  factory ActiveObjectMessage.fromJson(Map<String, dynamic> json) =>
      _$ActiveObjectMessageFromJson(json);
}

@freezed
class PassiveObjectMessage
    with _$PassiveObjectMessage, BaseMessage, HasPosition {
  PassiveObjectMessage._();

  factory PassiveObjectMessage({
    required int objectId,
    required EventType eventType,
    int? team,
    int? size,
    int? position,
    int? generatePosition,
    int? generateBy,
    PassiveObjectType? objectType,
    int? acquireBy,
    RemoveBy? removeBy,
  }) = _PassiveObjectMessage;

  factory PassiveObjectMessage.fromJson(Map<String, dynamic> json) =>
      _$PassiveObjectMessageFromJson(json);
}

@freezed
class TileMessage with _$TileMessage, BaseMessage {
  TileMessage._();

  factory TileMessage(
      {required int address,
      required EventType eventType,
      int? status,
      int? occupierId,
      RemoveBy? removeBy}) = _TileMessage;

  get col => TileAddressParser.col(address);
  get row => TileAddressParser.row(address);

  get tileIndex => TileStatusParser.tileIndex(status!);
  get pollutionTileIndex => TileStatusParser.pollutionTileIndex(status!);
  TileState get finishType => TileStatusParser.state(status!);
  Team get team => TileStatusParser.team(status!);

  factory TileMessage.fromJson(Map<String, dynamic> json) =>
      _$TileMessageFromJson(json);
}
