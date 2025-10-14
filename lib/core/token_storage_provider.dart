import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';

/// SecureStorage のインスタンスを提供
final Provider<FlutterSecureStorage> secureStorageProvider = Provider(
  (ref) => const FlutterSecureStorage(),
);

/// アクセストークンの状態を管理するProvider
final accessTokenProvider = StateNotifierProvider<AccessTokenNotifier, String?>(
  (ref) {
    final storage = ref.watch(secureStorageProvider);
    return AccessTokenNotifier(storage);
  },
);

class AccessTokenNotifier extends StateNotifier<String?> {
  AccessTokenNotifier(this._storage) : super(null) {
    unawaited(
      _loadToken().catchError((Object e, StackTrace stack) {
        debugPrint('Failed to load token: $e');
      }),
    ); // 初期ロード
  }

  final FlutterSecureStorage _storage;
  static const _key = 'access_token';

  /// ストレージからトークンを読み込み
  Future<void> _loadToken() async {
    final token = await _storage.read(key: _key);
    state = token;
  }

  /// トークンを保存
  Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
    state = token;
  }

  /// トークンを削除
  Future<void> clearToken() async {
    await _storage.delete(key: _key);
    state = null;
  }
}
