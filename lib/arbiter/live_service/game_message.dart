import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_message.freezed.dart';
part 'game_message.g.dart';

@freezed
class GameMessage with _$GameMessage {
  const factory GameMessage({
    required bool prepare,
    required GameConfig gameConfig,
    required List<DustyMessage> dusties,
    required List<ActiveObjectMessage> activeObjects,
    required List<PassiveObjectMessage> passiveObjects,
    required List<TileMessage> tiles,
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
class DustyMessage with _$DustyMessage {
  const factory DustyMessage({
    required int id,
  }) = _DustyMessage;

  factory DustyMessage.fromJson(Map<String, dynamic> json) =>
      _$DustyMessageFromJson(json);
}

@freezed
class ActiveObjectMessage with _$ActiveObjectMessage {
  const factory ActiveObjectMessage({
    required int id,
  }) = _ActiveObjectMessage;

  factory ActiveObjectMessage.fromJson(Map<String, dynamic> json) =>
      _$ActiveObjectMessageFromJson(json);
}

@freezed
class PassiveObjectMessage with _$PassiveObjectMessage {
  const factory PassiveObjectMessage({
    required int id,
  }) = _PassiveObjectMessage;

  factory PassiveObjectMessage.fromJson(Map<String, dynamic> json) =>
      _$PassiveObjectMessageFromJson(json);
}

@freezed
class TileMessage with _$TileMessage {
  const factory TileMessage({
    required int address,
  }) = _TileMessage;

  factory TileMessage.fromJson(Map<String, dynamic> json) =>
      _$TileMessageFromJson(json);
}
