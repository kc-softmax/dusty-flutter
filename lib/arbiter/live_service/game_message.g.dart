// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameMessageImpl _$$GameMessageImplFromJson(Map<String, dynamic> json) =>
    _$GameMessageImpl(
      prepare: json['prepare'] as bool,
      gameConfig:
          GameConfig.fromJson(json['game_config'] as Map<String, dynamic>),
      dusties: (json['dusties'] as List<dynamic>)
          .map((e) => DustyMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeObjects: (json['active_objects'] as List<dynamic>)
          .map((e) => ActiveObjectMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      passiveObjects: (json['passive_objects'] as List<dynamic>)
          .map((e) => PassiveObjectMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      tiles: (json['tiles'] as List<dynamic>)
          .map((e) => TileMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GameMessageImplToJson(_$GameMessageImpl instance) =>
    <String, dynamic>{
      'prepare': instance.prepare,
      'game_config': instance.gameConfig,
      'dusties': instance.dusties,
      'active_objects': instance.activeObjects,
      'passive_objects': instance.passiveObjects,
      'tiles': instance.tiles,
    };

_$GameConfigImpl _$$GameConfigImplFromJson(Map<String, dynamic> json) =>
    _$GameConfigImpl(
      frameRate: json['frame_rate'] as int,
      punchingReloadTime: json['punching_reload_time'] as int,
      activeSkillReloadTime: json['active_skill_reload_time'] as int,
      specialSkillReloadTime: json['special_skill_reload_time'] as int,
      finishSkillReloadTime: json['finish_skill_reload_time'] as int,
      boostSkillReloadTime: json['boost_skill_reload_time'] as int,
      shieldSkillReloadTime: json['shield_skill_reload_time'] as int,
      raftSkillReloadTime: json['raft_skill_reload_time'] as int,
    );

Map<String, dynamic> _$$GameConfigImplToJson(_$GameConfigImpl instance) =>
    <String, dynamic>{
      'frame_rate': instance.frameRate,
      'punching_reload_time': instance.punchingReloadTime,
      'active_skill_reload_time': instance.activeSkillReloadTime,
      'special_skill_reload_time': instance.specialSkillReloadTime,
      'finish_skill_reload_time': instance.finishSkillReloadTime,
      'boost_skill_reload_time': instance.boostSkillReloadTime,
      'shield_skill_reload_time': instance.shieldSkillReloadTime,
      'raft_skill_reload_time': instance.raftSkillReloadTime,
    };

_$DustyMessageImpl _$$DustyMessageImplFromJson(Map<String, dynamic> json) =>
    _$DustyMessageImpl(
      id: json['id'] as int,
    );

Map<String, dynamic> _$$DustyMessageImplToJson(_$DustyMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

_$ActiveObjectMessageImpl _$$ActiveObjectMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$ActiveObjectMessageImpl(
      id: json['id'] as int,
    );

Map<String, dynamic> _$$ActiveObjectMessageImplToJson(
        _$ActiveObjectMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

_$PassiveObjectMessageImpl _$$PassiveObjectMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$PassiveObjectMessageImpl(
      id: json['id'] as int,
    );

Map<String, dynamic> _$$PassiveObjectMessageImplToJson(
        _$PassiveObjectMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

_$TileMessageImpl _$$TileMessageImplFromJson(Map<String, dynamic> json) =>
    _$TileMessageImpl(
      address: json['address'] as int,
    );

Map<String, dynamic> _$$TileMessageImplToJson(_$TileMessageImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
    };
