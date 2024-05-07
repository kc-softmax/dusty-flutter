// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StateDataImpl _$$StateDataImplFromJson(Map<String, dynamic> json) =>
    _$StateDataImpl(
      state: $enumDecodeNullable(_$ObjectStateEnumMap, json['state']),
      target: json['target'] as int?,
      value: json['value'],
    );

Map<String, dynamic> _$$StateDataImplToJson(_$StateDataImpl instance) =>
    <String, dynamic>{
      'state': _$ObjectStateEnumMap[instance.state],
      'target': instance.target,
      'value': instance.value,
    };

const _$ObjectStateEnumMap = {
  ObjectState.idle: 1,
  ObjectState.generate: 2,
  ObjectState.moving: 3,
  ObjectState.hitting: 4,
  ObjectState.casting: 5,
  ObjectState.damaged: 6,
  ObjectState.targeting: 7,
  ObjectState.targeted: 8,
  ObjectState.death: 9,
};

_$GameEventImpl _$$GameEventImplFromJson(Map<String, dynamic> json) =>
    _$GameEventImpl(
      dusties: (json['dusties'] as List<dynamic>?)
          ?.map((e) => DustyEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeObjects: (json['active_objects'] as List<dynamic>?)
          ?.map((e) => ActiveObjectEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      passiveObjects: (json['passive_objects'] as List<dynamic>?)
          ?.map((e) => PassiveObjectEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      systemEvent: json['system_event'] == null
          ? null
          : SystemEvent.fromJson(json['system_event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GameEventImplToJson(_$GameEventImpl instance) =>
    <String, dynamic>{
      'dusties': instance.dusties,
      'active_objects': instance.activeObjects,
      'passive_objects': instance.passiveObjects,
      'system_event': instance.systemEvent,
    };

_$SystemEventImpl _$$SystemEventImplFromJson(Map<String, dynamic> json) =>
    _$SystemEventImpl(
      followId: json['follow_id'] as int?,
      remainTime: json['remain_time'] as int?,
    );

Map<String, dynamic> _$$SystemEventImplToJson(_$SystemEventImpl instance) =>
    <String, dynamic>{
      'follow_id': instance.followId,
      'remain_time': instance.remainTime,
    };

_$DustyEventImpl _$$DustyEventImplFromJson(Map<String, dynamic> json) =>
    _$DustyEventImpl(
      objectId: json['object_id'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => StateData.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      isPlayer: json['is_player'] as bool?,
      team: $enumDecodeNullable(_$TeamEnumMap, json['team']),
      status: json['status'] as int?,
      position: json['position'] as int?,
      targetId: json['target_id'] as int?,
      killerId: json['killer_id'] as int?,
      quantity: json['quantity'] as int?,
      defence: json['defence'] as int?,
    );

Map<String, dynamic> _$$DustyEventImplToJson(_$DustyEventImpl instance) =>
    <String, dynamic>{
      'object_id': instance.objectId,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'states': instance.states,
      'name': instance.name,
      'is_player': instance.isPlayer,
      'team': _$TeamEnumMap[instance.team],
      'status': instance.status,
      'position': instance.position,
      'target_id': instance.targetId,
      'killer_id': instance.killerId,
      'quantity': instance.quantity,
      'defence': instance.defence,
    };

const _$EventTypeEnumMap = {
  EventType.generate: 1,
  EventType.update: 2,
  EventType.remove: 3,
};

const _$TeamEnumMap = {
  Team.colonists: 1,
  Team.guardians: 2,
};

_$ActiveObjectEventImpl _$$ActiveObjectEventImplFromJson(
        Map<String, dynamic> json) =>
    _$ActiveObjectEventImpl(
      objectId: json['object_id'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => StateData.fromJson(e as Map<String, dynamic>))
          .toList(),
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
    );

Map<String, dynamic> _$$ActiveObjectEventImplToJson(
        _$ActiveObjectEventImpl instance) =>
    <String, dynamic>{
      'object_id': instance.objectId,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'states': instance.states,
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
    };

const _$ActiveObjectTypeEnumMap = {
  ActiveObjectType.axe: 1,
  ActiveObjectType.stone: 2,
};

_$PassiveObjectEventImpl _$$PassiveObjectEventImplFromJson(
        Map<String, dynamic> json) =>
    _$PassiveObjectEventImpl(
      objectId: json['object_id'] as int,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => StateData.fromJson(e as Map<String, dynamic>))
          .toList(),
      position: json['position'] as int?,
      objectType:
          $enumDecodeNullable(_$PassiveObjectTypeEnumMap, json['object_type']),
    );

Map<String, dynamic> _$$PassiveObjectEventImplToJson(
        _$PassiveObjectEventImpl instance) =>
    <String, dynamic>{
      'object_id': instance.objectId,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'states': instance.states,
      'position': instance.position,
      'object_type': _$PassiveObjectTypeEnumMap[instance.objectType],
    };

const _$PassiveObjectTypeEnumMap = {
  PassiveObjectType.tree: 1,
  PassiveObjectType.artifact: 2,
};
