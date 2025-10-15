import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck/core/api_exception.dart';
import 'package:yumemi_codecheck/core/token_storage_provider.dart';
import 'package:yumemi_codecheck/models/login/login_state.dart';
import 'package:yumemi_codecheck/models/login/user_profile_entity.dart';
import 'package:yumemi_codecheck/repositories/github/oauth_repository_provider.dart';

part 'login_avatar_view_model.g.dart';

@riverpod
class LoginAvatarViewModel extends _$LoginAvatarViewModel {
  @override
  Future<LoginState> build() async {
    final token = ref.watch(accessTokenProvider);

    // 初期状態：未ログイン
    var currentState = LoginState.initial();

    // トークンが存在する場合はログイン状態を復元
    if (token != null && token.isNotEmpty) {
      final oauthRepository = ref.read(oauthRepositoryProvider);
      try {
        final profile = await oauthRepository.fetchUserProfile();
        currentState = mapToLoginState(profile);
      } on ApiException {
        // 取得失敗時はトークンを破棄
        await ref.read(accessTokenProvider.notifier).clearToken();
        currentState = LoginState.initial();
      }
    }

    return currentState;
  }

  Future<void> login() async {
    final oauthRepository = ref.read(oauthRepositoryProvider);
    try {
      final code = await oauthRepository.authorize();
      await oauthRepository.fetchAccessToken(code);
      final current = state.value ?? LoginState.initial();
      state = AsyncData(current.copyWith(isLoggedIn: true));
    } on ApiException {
      rethrow;
    }
  }

  Future<void> fetchUserProfile() async {
    final oauthRepository = ref.read(oauthRepositoryProvider);
    try {
      final profile = await oauthRepository.fetchUserProfile();
      state = AsyncData(mapToLoginState(profile));
    } on ApiException {
      rethrow;
    }
  }

  Future<void> logout() async {
    final oauthRepository = ref.read(oauthRepositoryProvider);
    await oauthRepository.logout();
    state = AsyncData(LoginState.initial());
  }

  LoginState mapToLoginState(UserProfileEntity entity) {
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
