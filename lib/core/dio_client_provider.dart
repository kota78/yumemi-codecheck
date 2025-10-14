import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod/riverpod.dart';
import 'package:yumemi_codecheck/components/texts/app_env_keys.dart';
import 'package:yumemi_codecheck/core/dio_client.dart';
import 'package:yumemi_codecheck/core/token_storage_provider.dart';

/// 認証付き DioClient Provider
final dioClientProvider = Provider<DioClient>((ref) {
  final baseUrl = dotenv.env[AppEnvKeys.apiUrl]!;
  final token = ref.watch(accessTokenProvider);
  final client = DioClient(baseUrl);

  // 認証ヘッダーを自動付与するInterceptor
  client.dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ),
  );

  return client;
});
