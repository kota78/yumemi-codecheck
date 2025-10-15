import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck/core/data/dio_client_provider.dart';
import 'package:yumemi_codecheck/core/storage/token_storage_provider.dart';
import 'package:yumemi_codecheck/repositories/github/login/oauth_repository.dart';

part 'oauth_repository_provider.g.dart';

/// OAuthRepository を提供する Provider
/// dioClient と tokenNotifier を注入して生成

@riverpod
OAuthRepository oauthRepository(Ref ref) {
  final dioClient = ref.watch(dioClientProvider);
  final tokenNotifier = ref.watch(accessTokenProvider.notifier);
  return OAuthRepository(dioClient, tokenNotifier);
}
