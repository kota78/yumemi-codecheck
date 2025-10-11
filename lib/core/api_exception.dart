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
        } else {
          message = 'リクエストに失敗しました。(コード: $statusCode)';
        }
      case DioExceptionType.connectionError:
        message = 'ネットワークに接続できませんでした。接続状況を確認してください。';
      case DioExceptionType.cancel:
        message = 'リクエストがキャンセルされました。';
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        message = '予期せぬエラーが発生しました。';
    }
    final exception = ApiException(
      message,
      statusCode: error.response?.statusCode,
    );

    debugPrint('⚠️ API Error: ${exception.message} (Original: ${error.type})');

    return exception;
  }
  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException: $message (statusCode: $statusCode)';
}
