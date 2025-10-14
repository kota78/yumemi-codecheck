import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

/// ログインユーザーの状態を表すState
@freezed
abstract class LoginState with _$LoginState{
  const factory LoginState({
    required bool isLoggedIn, /// ログイン状態
    required String name, /// ユーザー名
    required String avatarUrl, /// ユーザーのアイコン画像URL
  }) = _LoginState;
}
