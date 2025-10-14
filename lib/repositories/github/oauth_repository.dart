import 'package:dio/dio.dart' show DioException, Options;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:yumemi_codecheck/components/texts/app_env_keys.dart';
import 'package:yumemi_codecheck/core/api_exception.dart';
import 'package:yumemi_codecheck/core/dio_client.dart';
import 'package:yumemi_codecheck/core/token_storage_provider.dart';
import 'package:yumemi_codecheck/models/login/user_profile_entity.dart';

class OAuthRepository {
  OAuthRepository(this._dioClient, this._tokenNotifier);

  final DioClient _dioClient;
  final AccessTokenNotifier _tokenNotifier;

  /// GitHub OAuth 認可画面を開き、認可コードを取得
  Future<String> authorize() async {
    final clientId = dotenv.env[AppEnvKeys.clientId]!;
    final redirectUri = dotenv.env[AppEnvKeys.redirectUri]!;
    final baseUrl = dotenv.env[AppEnvKeys.baseUrl]!;
    const scope = 'read:user,user:email';

    final authUrl =
        '$baseUrl/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=$scope';

    try {
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: Uri.parse(redirectUri).scheme,
      );

      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) {
        throw ApiException('認可コードの取得に失敗しました。');
      }

      return code;
    } catch (e) {
      throw ApiException('GitHub認可に失敗しました: $e');
    }
  }

  /// 認可コードを使ってアクセストークンを取得・保存
  Future<String> fetchAccessToken(String code) async {
    final clientId = dotenv.env[AppEnvKeys.clientId]!;
    final clientSecret = dotenv.env[AppEnvKeys.clientSecret]!;
    final redirectUri = dotenv.env[AppEnvKeys.redirectUri]!;
    final baseUrl = dotenv.env[AppEnvKeys.baseUrl]!;
    try {
      final response = await _dioClient.post<Map<String, dynamic>>(
        '$baseUrl/login/oauth/access_token',
        data: {
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
          'redirect_uri': redirectUri,
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data;
      final accessToken = data?['access_token'] as String?;
      if (accessToken == null || accessToken.isEmpty) {
        throw ApiException('アクセストークンの取得に失敗しました。');
      }

      await _tokenNotifier.saveToken(accessToken);
      return accessToken;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// 現在保存済みのトークンを使ってユーザー情報を取得
  Future<UserProfileEntity> fetchUserProfile() async {
    try {
      final response = await _dioClient.get<Map<String, dynamic>>('/user');
      return UserProfileEntity.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException('ユーザー情報の取得に失敗しました: $e');
    }
  }

  /// ログアウト処理（トークン削除）
  Future<void> logout() async {
    await _tokenNotifier.clearToken();
  }
}
