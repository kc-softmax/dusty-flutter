// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameMessageImpl _$$GameMessageImplFromJson(Map<String, dynamic> json) =>
    _$GameMessageImpl(
      gameConfig: json['game_config'] == null
          ? null
          : GameConfig.fromJson(json['game_config'] as Map<String, dynamic>),
      dusties: (json['dusties'] as List<dynamic>?)
          ?.map((e) => DustyMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      towers: (json['towers'] as List<dynamic>?)
          ?.map((e) => TowerMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      actives: (json['actives'] as List<dynamic>?)
          ?.map((e) => ActiveObjectMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      passives: (json['passives'] as List<dynamic>?)
          ?.map((e) => PassiveObjectMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      tiles: (json['tiles'] as List<dynamic>?)
          ?.map((e) => TileMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GameMessageImplToJson(_$GameMessageImpl instance) =>
    <String, dynamic>{
      'game_config': instance.gameConfig,
      'dusties': instance.dusties,
      'towers': instance.towers,
      'actives': instance.actives,
      'passives': instance.passives,
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
      dustyId: json['dusty_id'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      name: json['name'] as String?,
      team: json['team'] as int?,
      status: json['status'] as int?,
      position: json['position'] as int?,
      target: json['target'] as int?,
      defence: json['defence'] as int?,
      deathInfo: json['death_info'] as int?,
    );

Map<String, dynamic> _$$DustyMessageImplToJson(_$DustyMessageImpl instance) =>
    <String, dynamic>{
      'dusty_id': instance.dustyId,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'name': instance.name,
      'team': instance.team,
      'status': instance.status,
      'position': instance.position,
      'target': instance.target,
      'defence': instance.defence,
      'death_info': instance.deathInfo,
    };

const _$EventTypeEnumMap = {
  EventType.generate: 1,
  EventType.update: 2,
  EventType.remove: 3,
};

_$TowerMessageImpl _$$TowerMessageImplFromJson(Map<String, dynamic> json) =>
    _$TowerMessageImpl(
      towerId: json['tower_id'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      team: json['team'] as int?,
      shape: json['shape'] as int?,
      position: json['position'] as int?,
      target: json['target'] as int?,
      removeType: json['remove_type'] as int?,
    );

Map<String, dynamic> _$$TowerMessageImplToJson(_$TowerMessageImpl instance) =>
    <String, dynamic>{
      'tower_id': instance.towerId,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'team': instance.team,
      'shape': instance.shape,
      'position': instance.position,
      'target': instance.target,
      'remove_type': instance.removeType,
    };

_$ActiveObjectMessageImpl _$$ActiveObjectMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$ActiveObjectMessageImpl(
      objectId: json['object_id'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      team: json['team'] as int?,
      directionX: json['direction_x'] as int?,
      directionY: json['direction_y'] as int?,
      status: json['status'] as int?,
      position: json['position'] as int?,
      target: json['target'] as int?,
      objectType: json['object_type'] as int?,
      removeType: json['remove_type'] as int?,
    );

Map<String, dynamic> _$$ActiveObjectMessageImplToJson(
        _$ActiveObjectMessageImpl instance) =>
    <String, dynamic>{
      'object_id': instance.objectId,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'team': instance.team,
      'direction_x': instance.directionX,
      'direction_y': instance.directionY,
      'status': instance.status,
      'position': instance.position,
      'target': instance.target,
      'object_type': instance.objectType,
      'remove_type': instance.removeType,
    };

_$PassiveObjectMessageImpl _$$PassiveObjectMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$PassiveObjectMessageImpl(
      objectId: json['object_id'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      team: json['team'] as int?,
      size: json['size'] as int?,
      position: json['position'] as int?,
      objectType: json['object_type'] as int?,
      removeType: json['remove_type'] as int?,
    );

Map<String, dynamic> _$$PassiveObjectMessageImplToJson(
        _$PassiveObjectMessageImpl instance) =>
    <String, dynamic>{
      'object_id': instance.objectId,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'team': instance.team,
      'size': instance.size,
      'position': instance.position,
      'object_type': instance.objectType,
      'remove_type': instance.removeType,
    };

_$TileMessageImpl _$$TileMessageImplFromJson(Map<String, dynamic> json) =>
    _$TileMessageImpl(
      address: json['address'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      team: json['team'] as int?,
      activatorId: json['activator_id'] as int?,
    );

Map<String, dynamic> _$$TileMessageImplToJson(_$TileMessageImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'team': instance.team,
      'activator_id': instance.activatorId,
    };
