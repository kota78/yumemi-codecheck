import 'package:dio/dio.dart' show DioException, Options;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yumemi_codecheck/core/api_exception.dart';
import 'package:yumemi_codecheck/core/dio_client.dart';
import 'package:yumemi_codecheck/core/token_storage_provider.dart';
import 'package:yumemi_codecheck/models/login/user_profile_entity.dart';

class OAuthRepository {
  OAuthRepository(this._dioClient, this._tokenNotifier);

  final DioClient _dioClient;
  final AccessTokenNotifier _tokenNotifier;

  /// 認可コードを使ってアクセストークンを取得し、ユーザー情報を返す
  Future<UserProfileEntity> loginWithCode(String code) async {
    final clientId = dotenv.env['GITHUB_CLIENT_ID']!;
    final clientSecret = dotenv.env['GITHUB_CLIENT_SECRET']!;
    final redirectUri = dotenv.env['REDIRECT_URI']!;

    try {
      // --- アクセストークン取得 ---
      final response = await _dioClient.post<Map<String, dynamic>>(
        'https://github.com/login/oauth/access_token',
        data: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
          'redirect_uri': redirectUri,
        },
        // JSONで受け取るためAcceptヘッダーを明示
        queryParameters: {},
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );

      final data = response.data;
      if (data == null || data['access_token'] == null) {
        throw ApiException('アクセストークンの取得に失敗しました。');
      }

      final accessToken = data['access_token'] as String;

      // --- トークンを保存 ---
      await _tokenNotifier.saveToken(accessToken);

      // --- ユーザー情報取得 ---
      final userResponse = await _dioClient.get<Map<String, dynamic>>(
        '/user',
        queryParameters: {},
      );

      final user = UserProfileEntity.fromJson(userResponse.data!);
      return user;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// ログアウト
  Future<void> logout() async {
    await _tokenNotifier.clearToken();
  }
}
