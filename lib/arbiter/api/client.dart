import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dusty_flutter/arbiter/api/models.dart';

const tokenApiPath = '/auth/token';
const gameUserApiPath = '/auth/game';
const playApiPath = '/play/join';

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

  Future<GameInfo> joinGame(RequestGameJoin requestBody) async {
    // TODO 실제 api 연결
    // final response = await _dio.post<Map>(
    //   playApiPath,
    //   data: requestBody.toJson(),
    // );
    // return GameInfo.fromJson(response.data!.cast());
    await Future.delayed(const Duration(seconds: 3));
    return GameInfo(
      map: Random().nextInt(10) % 2 == 0 ? 'default' : 'ultimate',
      gameConfig: GameConfig(),
    );
  }

  Future<String> readyGame() async {
    // TODO 실제 api 연결
    await Future.delayed(const Duration(seconds: 3));
    return 'address';
  }
}
