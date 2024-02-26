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
  @JsonValue(501)
  alpha,
  @JsonValue(502)
  beta,
  @JsonValue(503)
  neutral,
}

enum ActiveObjectType {
  @JsonValue(1)
  normalMissaile,
  @JsonValue(2)
  normalPunch
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
  lithning
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
    List<TowerMessage>? towers,
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
    required int activeSkillDuration,
    required int specialSkillReloadTime,
    required int shieldSkillReloadTime,
    required int raftSkillReloadTime,
    required int respawnTime,
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
    int? defence,
    RemoveBy? removeBy,
  }) = _DustyMessage;

  get direction => StatusParser.direction(status!);
  get activeAvailable => StatusParser.activeAvailable(status!);
  get specialAvailable => StatusParser.specialAvailable(status!);
  get finishAvailable => StatusParser.finishAvailable(status!);
  get shieldAvailable => StatusParser.shieldAvailable(status!);
  get isFinishing => StatusParser.isFinishing(status!);
  get isRiding => StatusParser.isRiding(status!);
  get finishType => StatusParser.finishType(status!);
  get finishGauge => StatusParser.finishGauge(status!);
  DustyState get dustyState => StatusParser.dustyState(status!);

  factory DustyMessage.fromJson(Map<String, dynamic> json) =>
      _$DustyMessageFromJson(json);
}

@freezed
class TowerMessage with _$TowerMessage, BaseMessage, HasPosition {
  TowerMessage._();

  factory TowerMessage({
    required int towerId,
    required EventType eventType,
    int? team,
    int? shape,
    int? target,
    RemoveBy? removeBy,
  }) = _TowerMessage;

  factory TowerMessage.fromJson(Map<String, dynamic> json) =>
      _$TowerMessageFromJson(json);
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
    int? status,
    int? position,
    int? targetId,
    int? ownerId,
    ActiveObjectType? objectType,
    RemoveBy? removeBy,
  }) = _ActiveObjectMessage;

  get size => ActiveStatusParser.size(status!);
  get stride => ActiveStatusParser.stride(status!);
  get life => ActiveStatusParser.life(status!);

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
    int? objectType,
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
      int? team,
      int? activatorId,
      RemoveBy? removeBy}) = _TileMessage;

  get col => TileAddressParser.col(address);
  get row => TileAddressParser.row(address);

  factory TileMessage.fromJson(Map<String, dynamic> json) =>
      _$TileMessageFromJson(json);
}
