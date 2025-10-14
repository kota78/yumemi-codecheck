
import 'package:riverpod/riverpod.dart';
import 'package:yumemi_codecheck/core/dio_client_provider.dart';
import 'package:yumemi_codecheck/core/token_storage_provider.dart';
import 'package:yumemi_codecheck/repositories/github/oauth_repository.dart';

/// OAuthRepository を提供する Provider
/// dioClient と tokenNotifier を注入して生成
final oauthRepositoryProvider = Provider<OAuthRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final tokenNotifier = ref.watch(accessTokenProvider.notifier);
  return OAuthRepository(dioClient, tokenNotifier);
});
