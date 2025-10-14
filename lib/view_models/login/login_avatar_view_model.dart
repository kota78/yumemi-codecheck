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
      final userEntity = await oauthRepository.authorizeAndLogin();
      state = _mapToLoginState(userEntity);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('ログイン処理で予期せぬエラーが発生しました: $e');
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
}
