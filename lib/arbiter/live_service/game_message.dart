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

enum ActiveObjectType {
  @JsonValue(1)
  towerBullet,
  @JsonValue(2)
  dustyMissaile,
  @JsonValue(3)
  flame
}

enum RemoveType {
  @JsonValue(1)
  disappear,
  @JsonValue(2)
  defaultExplosion,
  @JsonValue(3)
  alphaExplosion,
  @JsonValue(4)
  betaExplosion,
  @JsonValue(5)
  defence,
  @JsonValue(6)
  burn,
  @JsonValue(7)
  removeFlame,
  @JsonValue(8)
  first,
  @JsonValue(9)
  shock,
  @JsonValue(10)
  earnItem
}

mixin BaseMessage {
  EventType get eventType;
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
    required int frameRate,
    required int punchingReloadTime,
    required int activeSkillReloadTime,
    required int specialSkillReloadTime,
    required int finishSkillReloadTime,
    required int boostSkillReloadTime,
    required int shieldSkillReloadTime,
    required int raftSkillReloadTime,
  }) = _GameConfig;

  factory GameConfig.fromJson(Map<String, dynamic> json) =>
      _$GameConfigFromJson(json);
}

@freezed
class DustyMessage with _$DustyMessage, BaseMessage {
  const DustyMessage._();

  const factory DustyMessage({
    required int dustyId,
    required EventType eventType,
    String? name,
    int? team,
    int? status,
    int? position,
    int? target,
    int? defence,
    int? deathInfo,
  }) = _DustyMessage;

  get direction => StatusParser.direction(status!);
  get activeAvailable => StatusParser.activeAvailable(status!);
  get specialAvailable => StatusParser.specialAvailable(status!);
  get finishAvailable => StatusParser.finishAvailable(status!);
  get boostAvailable => StatusParser.boostAvailable(status!);
  get shieldAvailable => StatusParser.shieldAvailable(status!);
  get finishing => StatusParser.finishing(status!);
  get punching => StatusParser.punching(status!);
  DustyState get dustyState => StatusParser.dustyState(status!);
  get rafting => StatusParser.rafting(status!);
  get finishType => StatusParser.finishType(status!);

  factory DustyMessage.fromJson(Map<String, dynamic> json) =>
      _$DustyMessageFromJson(json);
}

@freezed
class TowerMessage with _$TowerMessage, BaseMessage {
  const TowerMessage._();

  const factory TowerMessage({
    required int towerId,
    required EventType eventType,
    int? team,
    int? shape,
    int? position,
    int? target,
    RemoveType? removeType,
  }) = _TowerMessage;

  double get x => PositionParser.x(position!);
  double get y => PositionParser.y(position!);

  factory TowerMessage.fromJson(Map<String, dynamic> json) =>
      _$TowerMessageFromJson(json);
}

@freezed
class ActiveObjectMessage with _$ActiveObjectMessage, BaseMessage {
  const ActiveObjectMessage._();

  const factory ActiveObjectMessage({
    required int objectId,
    required EventType eventType,
    int? team,
    int? directionX,
    int? directionY,
    int? status,
    int? position,
    int? target,
    ActiveObjectType? objectType,
    RemoveType? removeType,
  }) = _ActiveObjectMessage;

  double get x => PositionParser.x(position!);
  double get y => PositionParser.y(position!);

  factory ActiveObjectMessage.fromJson(Map<String, dynamic> json) =>
      _$ActiveObjectMessageFromJson(json);
}

@freezed
class PassiveObjectMessage with _$PassiveObjectMessage, BaseMessage {
  const factory PassiveObjectMessage({
    required int objectId,
    required EventType eventType,
    int? team,
    int? size,
    int? position,
    int? objectType,
    int? removeType,
  }) = _PassiveObjectMessage;

  factory PassiveObjectMessage.fromJson(Map<String, dynamic> json) =>
      _$PassiveObjectMessageFromJson(json);
}

@freezed
class TileMessage with _$TileMessage, BaseMessage {
  const factory TileMessage(
      {required int address,
      required EventType eventType,
      int? team,
      int? activatorId}) = _TileMessage;

  factory TileMessage.fromJson(Map<String, dynamic> json) =>
      _$TileMessageFromJson(json);
}
