// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GamePlayerRecordImpl _$$GamePlayerRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$GamePlayerRecordImpl(
      userId: json['user_id'] as int,
      userName: json['user_name'] as String,
      team: $enumDecode(_$TeamEnumMap, json['team']),
      kill: json['kill'] as int,
      death: json['death'] as int,
      territory: json['territory'] as int,
    );

Map<String, dynamic> _$$GamePlayerRecordImplToJson(
        _$GamePlayerRecordImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'team': _$TeamEnumMap[instance.team]!,
      'kill': instance.kill,
      'death': instance.death,
      'territory': instance.territory,
    };

const _$TeamEnumMap = {
  Team.alpha: 1,
  Team.beta: 2,
  Team.neutral: 3,
};
