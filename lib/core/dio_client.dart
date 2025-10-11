import 'package:dio/dio.dart';
import 'package:yumemi_codecheck/core/api_exception.dart';

class DioClient {

  DioClient(String baseUrl)
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          contentType: 'application/json',
        ),
      ) {
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }
  final Dio _dio;

  /// GETリクエスト
  ///
  /// 成功した場合は Response<T> を、失敗した場合は ApiException をスローします。
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// POSTリクエスト
  ///
  /// 成功した場合は Response<T> を、失敗した場合は ApiException をスローします。
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
