import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck/core/api_exception.dart';
import 'package:yumemi_codecheck/models/login/login_state.dart';
import 'package:yumemi_codecheck/models/login/user_profile_entity.dart';
import 'package:yumemi_codecheck/repositories/github/oauth_repository_provider.dart';

part 'login_avatar_view_model.g.dart';

@riverpod
class LoginAvatarViewModel extends _$LoginAvatarViewModel {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login() async {
    final oauthRepository = ref.read(oauthRepositoryProvider);
    try {
      final code = await oauthRepository.authorize();
      await oauthRepository.fetchAccessToken(code);
      state = state.copyWith(isLoggedIn: true);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('ログイン処理で予期せぬエラーが発生しました: $e');
    }
  }

  Future<void> fetchUserProfile() async {
    final oauthRepository = ref.read(oauthRepositoryProvider);
    try {
      final profile = await oauthRepository.fetchUserProfile();
      state = _mapToLoginState(profile);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('ユーザープロフィールの取得で予期せぬエラーが発生しました: $e');
    }
  }

  Future<void> logout() async {
    final oauthRepository = ref.read(oauthRepositoryProvider);
    await oauthRepository.logout();
    state = LoginState.initial();
  }

  LoginState _mapToLoginState(UserProfileEntity entity) {
    return LoginState(
      isLoggedIn: true,
      name: entity.login,
      avatarUrl: entity.avatarUrl,
    );
  }

  // UIから呼び出すコールバック
  Future<void> onLogin() async {
    await login();
    await fetchUserProfile();
  }

  Future<void> onLogout() async {
    await logout();
  }
}
