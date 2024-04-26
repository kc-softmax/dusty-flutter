import 'package:dio/dio.dart';
import 'package:dusty_flutter/arbiter/api/models.dart';

const tokenApiPath = '/auth/token';
const gameUserApiPath = '/auth/game';
const playApiPath = '/play';

class ArbiterApi {
  final Dio _dio;
  final String baseUrl;
  ArbiterApi({required this.baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(minutes: 1),
        ));

  Future<bool> verifyToken(String token) async {
    final response = await _dio.post<bool>('$tokenApiPath/verify',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }));
    return response.data!;
  }

  Future<Tokens> refreshToken(RequestRefreshToken requestBody) async {
    final response = await _dio.post<Map>(
      '$tokenApiPath/refresh',
      data: requestBody.toJson(),
    );
    return Tokens.fromJson(response.data!.cast());
  }

  Future<GameUser> loginByUserName(RequestLoginByUserName requestBody) async {
    final response = await _dio.post<Map>(
      '$gameUserApiPath/login/username',
      data: requestBody.toJson(),
    );
    return GameUser.fromJson(response.data!.cast());
  }

  // TODO REMOVE
  // Future<GameInfo> joinGame(String token, RequestGameJoin requestBody) async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   return GameInfo(
  //     gameMap: Random().nextInt(10) % 2 == 0 ? 'default' : 'ultimate',
  //     gameId: Random().nextInt(999),
  //   );
  // }

  // TODO REMOVE
  // Future<GameConnection> readyGame(
  //     String token, RequestGameReady requestBody) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   return GameConnection(gameAddress: '');
  // }

  Future<GameInfo> joinGame(String token, RequestGameJoin requestBody) async {
    final response = await _dio.post<Map>(
      '$playApiPath/join',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
      data: requestBody.toJson(),
    );
    return GameInfo.fromJson(response.data!.cast());
  }

  Future<GameConnection> readyGame(
      String token, RequestGameReady requestBody) async {
    // TODO 실제 api 연결
    final response = await _dio.post<Map>(
      '$playApiPath/ready',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
      data: requestBody.toJson(),
    );
    return GameConnection.fromJson(response.data!.cast());
  }
}
