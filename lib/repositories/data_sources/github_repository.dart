import 'package:dio/dio.dart';
import 'package:yumemi_codecheck/core/api_exception.dart';
import 'package:yumemi_codecheck/core/dio_client.dart';
import 'package:yumemi_codecheck/models/search/repositoriy_list_entity.dart';

class GithubRepository {
  GithubRepository({required this.dioClient});
  final DioClient dioClient;

  /// GitHubリポジトリを検索する
  ///
  /// 成功した場合は RepositoryListEntity を、
  /// 失敗した場合は ApiException をスローします。
  Future<RepositoryListEntity> searchRepositories({
    required String query,
  }) async {
    try {
      final response = await dioClient.get<Map<String, dynamic>>(
        '/search/repositories',
        queryParameters: {'q': query},
      );
      final data = response.data;
      if (response.data == null) {
        throw ApiException('Response data is null');
      }
      return RepositoryListEntity.fromJson(data!);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
