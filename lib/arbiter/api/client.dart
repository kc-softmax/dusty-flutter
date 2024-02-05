import 'package:dio/dio.dart';
import 'package:dusty_flutter/arbiter/api/models.dart';

const tokenApiPath = '/auth/token';
const gameUserApiPath = '/auth/game';

class ArbiterApi {
  final Dio _dio;
  final String baseUrl;
  ArbiterApi({required this.baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<bool> verifyToken() async {
    final response = await _dio.post<bool>('$tokenApiPath/verify');
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
}
