// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebRTCSignalDataImpl _$$WebRTCSignalDataImplFromJson(
        Map<String, dynamic> json) =>
    _$WebRTCSignalDataImpl(
      type: $enumDecode(_$SignalingMessageTypeEnumMap, json['type']),
      sdp: json['sdp'] as String?,
    );

Map<String, dynamic> _$$WebRTCSignalDataImplToJson(
        _$WebRTCSignalDataImpl instance) =>
    <String, dynamic>{
      'type': _$SignalingMessageTypeEnumMap[instance.type]!,
      'sdp': instance.sdp,
    };

const _$SignalingMessageTypeEnumMap = {
  SignalingMessageType.offer: 'offer',
  SignalingMessageType.candidate: 'candidate',
};

_$DataChannelMessageDataImpl _$$DataChannelMessageDataImplFromJson(
        Map<String, dynamic> json) =>
    _$DataChannelMessageDataImpl(
      userId: json['user_id'] as int,
      text: json['text'] as String,
    );

Map<String, dynamic> _$$DataChannelMessageDataImplToJson(
        _$DataChannelMessageDataImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'text': instance.text,
    };
