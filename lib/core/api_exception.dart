import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  /// Dioからスローされる多様な例外を、アプリで扱いやすい単一のApiExceptionに変換・集約します。
  /// これにより、Dioへの依存をこの層で食い止め、エラーハンドリングを一元化する責務を担います。
  factory ApiException.fromDioError(DioException error) {
    String message;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = '接続がタイムアウトしました。';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null && statusCode >= 500) {
          message = 'サーバーで問題が発生しました。(コード: $statusCode)';
        } else if (_isRateLimitExceeded(error)) {
          message = 'リクエスト超過エラーが発生しました。ユーザーアイコンをタップしてログインすることで緩和されます。';
        } else {
          message = 'リクエストに失敗しました。(コード: $statusCode)';
        }
      case DioExceptionType.connectionError:
        message = 'ネットワークに接続できませんでした。\n接続状況を確認してください。';
      case DioExceptionType.cancel:
        message = 'リクエストがキャンセルされました。';
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        message = '予期せぬエラーが発生しました。';
    }
    final statusCode = error.response?.statusCode;
    final exception = ApiException(
      message,
      statusCode: statusCode
    );

    debugPrint('⚠️ API Error: ${exception.message} StatusCode: $statusCode');

    return exception;
  }
  final String message;
  final int? statusCode;

  // エラー時に表示されるメッセージ
  @override
  String toString() => message;

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
