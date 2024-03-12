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
      system: json['system'] == null
          ? null
          : SystemMessage.fromJson(json['system'] as Map<String, dynamic>),
      dusties: (json['dusties'] as List<dynamic>?)
          ?.map((e) => DustyMessage.fromJson(e as Map<String, dynamic>))
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
      'system': instance.system,
      'dusties': instance.dusties,
      'actives': instance.actives,
      'passives': instance.passives,
      'tiles': instance.tiles,
    };

_$SystemMessageImpl _$$SystemMessageImplFromJson(Map<String, dynamic> json) =>
    _$SystemMessageImpl(
      remainTime: json['remain_time'] as int?,
      pollutedCount: json['polluted_count'] as int?,
      isEnd: json['is_end'] as bool?,
    );

Map<String, dynamic> _$$SystemMessageImplToJson(_$SystemMessageImpl instance) =>
    <String, dynamic>{
      'remain_time': instance.remainTime,
      'polluted_count': instance.pollutedCount,
      'is_end': instance.isEnd,
    };

_$GameConfigImpl _$$GameConfigImplFromJson(Map<String, dynamic> json) =>
    _$GameConfigImpl(
      playerId: json['player_id'] as int,
      frameRate: json['frame_rate'] as int,
      boostDuration: json['boost_duration'] as int,
      shieldDuration: json['shield_duration'] as int,
      finishDuration: json['finish_duration'] as int,
      boostSkillReloadTime: json['boost_skill_reload_time'] as int,
      activeSkillDuration: json['active_skill_duration'] as int,
      specialSkillReloadTime: json['special_skill_reload_time'] as int,
      special2SkillReloadTime: json['special2_skill_reload_time'] as int,
      raftReloadTime: json['raft_reload_time'] as int,
      respawnTime: json['respawn_time'] as int,
      grenadePowerUnit: json['grenade_power_unit'] as int,
      defaultPunchRange: json['default_punch_range'] as int,
      autoTargetingRange: json['auto_targeting_range'] as int,
      autoTargetingAngle: json['auto_targeting_angle'] as int,
      totalOccupyableRegion: json['total_occupyable_region'] as int,
    );

Map<String, dynamic> _$$GameConfigImplToJson(_$GameConfigImpl instance) =>
    <String, dynamic>{
      'player_id': instance.playerId,
      'frame_rate': instance.frameRate,
      'boost_duration': instance.boostDuration,
      'shield_duration': instance.shieldDuration,
      'finish_duration': instance.finishDuration,
      'boost_skill_reload_time': instance.boostSkillReloadTime,
      'active_skill_duration': instance.activeSkillDuration,
      'special_skill_reload_time': instance.specialSkillReloadTime,
      'special2_skill_reload_time': instance.special2SkillReloadTime,
      'raft_reload_time': instance.raftReloadTime,
      'respawn_time': instance.respawnTime,
      'grenade_power_unit': instance.grenadePowerUnit,
      'default_punch_range': instance.defaultPunchRange,
      'auto_targeting_range': instance.autoTargetingRange,
      'auto_targeting_angle': instance.autoTargetingAngle,
      'total_occupyable_region': instance.totalOccupyableRegion,
    };

_$DustyMessageImpl _$$DustyMessageImplFromJson(Map<String, dynamic> json) =>
    _$DustyMessageImpl(
      dustyId: json['dusty_id'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      name: json['name'] as String?,
      team: $enumDecodeNullable(_$TeamEnumMap, json['team']),
      status: json['status'] as int?,
      position: json['position'] as int?,
      targetId: json['target_id'] as int?,
      killerId: json['killer_id'] as int?,
      quantity: json['quantity'] as int?,
      defence: json['defence'] as int?,
      removeBy: $enumDecodeNullable(_$RemoveByEnumMap, json['remove_by']),
    );

Map<String, dynamic> _$$DustyMessageImplToJson(_$DustyMessageImpl instance) =>
    <String, dynamic>{
      'dusty_id': instance.dustyId,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'name': instance.name,
      'team': _$TeamEnumMap[instance.team],
      'status': instance.status,
      'position': instance.position,
      'target_id': instance.targetId,
      'killer_id': instance.killerId,
      'quantity': instance.quantity,
      'defence': instance.defence,
      'remove_by': _$RemoveByEnumMap[instance.removeBy],
    };

const _$EventTypeEnumMap = {
  EventType.generate: 1,
  EventType.update: 2,
  EventType.remove: 3,
};

const _$TeamEnumMap = {
  Team.alpha: 1,
  Team.beta: 2,
  Team.neutral: 3,
};

const _$RemoveByEnumMap = {
  RemoveBy.unknown: 1,
  RemoveBy.flame: 2,
  RemoveBy.missaile: 3,
  RemoveBy.punch: 4,
  RemoveBy.lightning: 5,
};

_$ActiveObjectMessageImpl _$$ActiveObjectMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$ActiveObjectMessageImpl(
      objectId: json['object_id'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      team: json['team'] as int?,
      directionX: (json['direction_x'] as num?)?.toDouble(),
      directionY: (json['direction_y'] as num?)?.toDouble(),
      gravity: (json['gravity'] as num?)?.toDouble(),
      lifeStep: (json['life_step'] as num?)?.toDouble(),
      speed: json['speed'] as int?,
      position: json['position'] as int?,
      destination: json['destination'] as int?,
      targetId: json['target_id'] as int?,
      ownerId: json['owner_id'] as int?,
      objectType:
          $enumDecodeNullable(_$ActiveObjectTypeEnumMap, json['object_type']),
      removeBy: $enumDecodeNullable(_$RemoveByEnumMap, json['remove_by']),
    );

Map<String, dynamic> _$$ActiveObjectMessageImplToJson(
        _$ActiveObjectMessageImpl instance) =>
    <String, dynamic>{
      'object_id': instance.objectId,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'team': instance.team,
      'direction_x': instance.directionX,
      'direction_y': instance.directionY,
      'gravity': instance.gravity,
      'life_step': instance.lifeStep,
      'speed': instance.speed,
      'position': instance.position,
      'destination': instance.destination,
      'target_id': instance.targetId,
      'owner_id': instance.ownerId,
      'object_type': _$ActiveObjectTypeEnumMap[instance.objectType],
      'remove_by': _$RemoveByEnumMap[instance.removeBy],
    };

const _$ActiveObjectTypeEnumMap = {
  ActiveObjectType.normalMissaile: 1,
  ActiveObjectType.normalPunch: 2,
  ActiveObjectType.normalGrenade: 3,
};

_$PassiveObjectMessageImpl _$$PassiveObjectMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$PassiveObjectMessageImpl(
      objectId: json['object_id'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      team: json['team'] as int?,
      size: json['size'] as int?,
      position: json['position'] as int?,
      generatePosition: json['generate_position'] as int?,
      generateBy: json['generate_by'] as int?,
      objectType:
          $enumDecodeNullable(_$PassiveObjectTypeEnumMap, json['object_type']),
      acquireBy: json['acquire_by'] as int?,
      removeBy: $enumDecodeNullable(_$RemoveByEnumMap, json['remove_by']),
    );

Map<String, dynamic> _$$PassiveObjectMessageImplToJson(
        _$PassiveObjectMessageImpl instance) =>
    <String, dynamic>{
      'object_id': instance.objectId,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'team': instance.team,
      'size': instance.size,
      'position': instance.position,
      'generate_position': instance.generatePosition,
      'generate_by': instance.generateBy,
      'object_type': _$PassiveObjectTypeEnumMap[instance.objectType],
      'acquire_by': instance.acquireBy,
      'remove_by': _$RemoveByEnumMap[instance.removeBy],
    };

const _$PassiveObjectTypeEnumMap = {
  PassiveObjectType.idle: 0,
  PassiveObjectType.bush4X4: 4,
  PassiveObjectType.bush: 5,
  PassiveObjectType.trash: 6,
};

_$TileMessageImpl _$$TileMessageImplFromJson(Map<String, dynamic> json) =>
    _$TileMessageImpl(
      address: json['address'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      status: json['status'] as int?,
      occupierId: json['occupier_id'] as int?,
      removeBy: $enumDecodeNullable(_$RemoveByEnumMap, json['remove_by']),
    );

Map<String, dynamic> _$$TileMessageImplToJson(_$TileMessageImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'status': instance.status,
      'occupier_id': instance.occupierId,
      'remove_by': _$RemoveByEnumMap[instance.removeBy],
    };
