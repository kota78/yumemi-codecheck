import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

/// ログインユーザーの状態を表すState
@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    required bool isLoggedIn,

    /// ログイン状態
    required String name,

    /// ユーザー名
    required String avatarUrl,

    /// ユーザーのアイコン画像URL
  }) = _LoginState;

  /// 初期状態（未ログイン）
  factory LoginState.initial() => const LoginState(
    isLoggedIn: false,
    name: '',
    avatarUrl: '',
  );
}
