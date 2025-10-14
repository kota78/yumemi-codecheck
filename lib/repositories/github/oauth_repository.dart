import 'package:dio/dio.dart' show DioException, Options;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:yumemi_codecheck/core/api_exception.dart';
import 'package:yumemi_codecheck/core/dio_client.dart';
import 'package:yumemi_codecheck/core/token_storage_provider.dart';
import 'package:yumemi_codecheck/models/login/user_profile_entity.dart';

class OAuthRepository {
  OAuthRepository(this._dioClient, this._tokenNotifier);

  final DioClient _dioClient;
  final AccessTokenNotifier _tokenNotifier;

  /// GitHub OAuth フローを開始し、ユーザー情報を返す
  Future<UserProfileEntity> authorizeAndLogin() async {
    final clientId = dotenv.env['GITHUB_CLIENT_ID']!;
    final redirectUri = dotenv.env['REDIRECT_URI']!;
    const scope = 'read:user,user:email';

    final authUrl =
        'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&scope=$scope';

    try {
      // --- WebでGitHub認証画面を開く ---
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: Uri.parse(redirectUri).scheme,
      );

      // --- codeを抽出 ---
      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) {
        throw ApiException('認可コードの取得に失敗しました。');
      }

      // --- 認可コードを使ってログイン ---
      final user = await loginWithCode(code);
      return user;
    } catch (e) {
      throw ApiException('GitHubログインに失敗しました: $e');
    }
  }

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
        options: Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data;
      if (data == null || data['access_token'] == null) {
        throw ApiException('アクセストークンの取得に失敗しました。');
      }

      final accessToken = data['access_token'] as String;

      // --- トークンを保存 ---
      await _tokenNotifier.saveToken(accessToken);

      // --- ユーザー情報取得 ---
      final userResponse = await _dioClient.get<Map<String, dynamic>>('/user');
      return UserProfileEntity.fromJson(userResponse.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// ログアウト
  Future<void> logout() async {
    await _tokenNotifier.clearToken();
  }
}
