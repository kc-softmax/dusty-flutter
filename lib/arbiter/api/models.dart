import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

enum LoginType {
  guest,
  email,
  facebook,
  apple,
  steam,
  google,
  tester,
}

// Request
@JsonSerializable()
class RequestRefreshToken {
  final String accessToken;
  final String refreshToken;

  RequestRefreshToken({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() => _$RequestRefreshTokenToJson(this);
}

@JsonSerializable()
class RequestLoginByUserName {
  final String userName;

  RequestLoginByUserName({
    required this.userName,
  });

  Map<String, dynamic> toJson() => _$RequestLoginByUserNameToJson(this);
}

// Response
@JsonSerializable()
class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);
}

@JsonSerializable()
class GameUser {
  final int id;
  final LoginType loginType;
  final String userName;
  final String? deviceId;
  final String? email;
  final String accessToken;
  final String refreshToken;
  final String? updatedAt;
  final String createdAt;
  final String? deprecatedAt;
  final bool? deprecated;
  final String? adapter;
  // Game Tester
  final bool? isUnlocked;
  final String? playerName;
  final String? playerToken;

  GameUser({
    required this.id,
    required this.loginType,
    required this.userName,
    required this.deviceId,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    required this.updatedAt,
    required this.createdAt,
    required this.deprecatedAt,
    required this.deprecated,
    required this.adapter,
    required this.isUnlocked,
    required this.playerName,
    required this.playerToken,
  });

  factory GameUser.fromJson(Map<String, dynamic> json) =>
      _$GameUserFromJson(json);
}
