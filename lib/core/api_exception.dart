import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// このアプリで扱うエラーの種類を明示する列挙型
enum ApiErrorType {
  timeoutError, // 接続・送受信がタイムアウトした
  serverError, // サーバー側でエラーが発生した (5xx)
  clientError, // クライアントリクエストに問題がある (4xx)
  networkError, // ネットワーク接続に失敗した
  rateLimitError, // GitHub APIのリクエスト制限を超過した
  cancelError, // リクエストがキャンセルされた
  unknownError, // 不明または想定外のエラー
  authorizationCodeError, // 認可コードの取得に失敗した
  accessTokenError, // アクセストークンの取得に失敗した
}


class ApiException implements Exception {
  ApiException(this.type, {this.statusCode});

  /// Dioからスローされる多様な例外を、アプリで扱いやすいApiExceptionに変換・集約します。
  /// これにより、Dioへの依存をこの層で食い止め、エラーハンドリングを一元化する責務を担います。
  factory ApiException.fromDioError(DioException error) {
    ApiErrorType type;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        type = ApiErrorType.timeoutError;
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null && statusCode >= 500) {
          type = ApiErrorType.serverError;
        } else if (_isRateLimitExceeded(error)) {
          type = ApiErrorType.rateLimitError;
        } else {
          type = ApiErrorType.clientError;
        }
      case DioExceptionType.connectionError:
        type = ApiErrorType.networkError;
      case DioExceptionType.cancel:
        type = ApiErrorType.cancelError;
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        type = ApiErrorType.unknownError;
    }
    final exception = ApiException(
      type,
      statusCode: error.response?.statusCode,
    );
    debugPrint(
      '⚠️ API Error: ${type.name} (code: ${error.response?.statusCode})',
    );
    return exception;
  }
  final ApiErrorType type;
  final int? statusCode;

  /// GitHubのレートリミット超過エラーかどうかを判定
  static bool _isRateLimitExceeded(DioException e) {
    if (e.response?.statusCode != 403) {
      return false;
    }
    final data = e.response?.data;
    if (data is Map && data['message'] is String) {
      final message = data['message'] as String;
      return message.contains('API rate limit exceeded');
    }
    return false;
  }
}
