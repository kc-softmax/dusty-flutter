// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestRefreshToken _$RequestRefreshTokenFromJson(Map<String, dynamic> json) =>
    RequestRefreshToken(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$RequestRefreshTokenToJson(
        RequestRefreshToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };

RequestLoginByUserName _$RequestLoginByUserNameFromJson(
        Map<String, dynamic> json) =>
    RequestLoginByUserName(
      userName: json['user_name'] as String,
    );

Map<String, dynamic> _$RequestLoginByUserNameToJson(
        RequestLoginByUserName instance) =>
    <String, dynamic>{
      'user_name': instance.userName,
    };

Tokens _$TokensFromJson(Map<String, dynamic> json) => Tokens(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$TokensToJson(Tokens instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };

GameUser _$GameUserFromJson(Map<String, dynamic> json) => GameUser(
      id: json['id'] as int,
      loginType: $enumDecode(_$LoginTypeEnumMap, json['login_type']),
      userName: json['user_name'] as String,
      deviceId: json['device_id'] as String?,
      email: json['email'] as String?,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String,
      deprecatedAt: json['deprecated_at'] as String?,
      deprecated: json['deprecated'] as bool?,
      adapter: json['adapter'] as String?,
      isUnlocked: json['is_unlocked'] as bool?,
      playerName: json['player_name'] as String?,
      playerToken: json['player_token'] as String?,
    );

Map<String, dynamic> _$GameUserToJson(GameUser instance) => <String, dynamic>{
      'id': instance.id,
      'login_type': _$LoginTypeEnumMap[instance.loginType]!,
      'user_name': instance.userName,
      'device_id': instance.deviceId,
      'email': instance.email,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'deprecated_at': instance.deprecatedAt,
      'deprecated': instance.deprecated,
      'adapter': instance.adapter,
      'is_unlocked': instance.isUnlocked,
      'player_name': instance.playerName,
      'player_token': instance.playerToken,
    };

const _$LoginTypeEnumMap = {
  LoginType.guest: 'guest',
  LoginType.email: 'email',
  LoginType.facebook: 'facebook',
  LoginType.apple: 'apple',
  LoginType.steam: 'steam',
  LoginType.google: 'google',
  LoginType.tester: 'tester',
};

RequestGameJoin _$RequestGameJoinFromJson(Map<String, dynamic> json) =>
    RequestGameJoin(
      team: json['team'] as String,
    );

Map<String, dynamic> _$RequestGameJoinToJson(RequestGameJoin instance) =>
    <String, dynamic>{
      'team': instance.team,
    };

GameConfig _$GameConfigFromJson(Map<String, dynamic> json) => GameConfig();

Map<String, dynamic> _$GameConfigToJson(GameConfig instance) =>
    <String, dynamic>{};

GameInfo _$GameInfoFromJson(Map<String, dynamic> json) => GameInfo(
      map: json['map'] as String,
      gameConfig:
          GameConfig.fromJson(json['game_config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameInfoToJson(GameInfo instance) => <String, dynamic>{
      'map': instance.map,
      'game_config': instance.gameConfig,
    };
