import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yumemi_codecheck/core/api_exception.dart';
import 'package:yumemi_codecheck/core/dio_client.dart';
import 'package:yumemi_codecheck/models/search/repositoriy_list_entity.dart';

class RepoSearchRepository {
  RepoSearchRepository({required this.dioClient});
  final DioClient dioClient;

  /// GitHubリポジトリを検索する
  ///
  /// [page] ページ番号（1から開始）
  /// [query] 検索クエリ
  ///
  /// 戻り値は (RepositoryListEntity, bool) の形式で、
  /// 2番目の bool は次のページが存在するかどうかを示します。
  /// 失敗した場合は ApiException をスローします。
  Future<(RepositoryListEntity, bool)> fetch({
    required int page,
    required String query,
  }) async {
    try {
      final response = await dioClient.get<Map<String, dynamic>>(
        '/search/repositories',
        queryParameters: {
          'q': query,
          'page': page,
          'per_page': 30, // GitHub APIのデフォルト値
        },
      );
      debugPrint('page: $page');

      final data = response.data;
      if (data == null) {
        throw ApiException('Response data is null');
      }

      final result = RepositoryListEntity.fromJson(data);
      final hasMore = result.items.length == 30; // 次のページの存在チェック
      /// TODO: 次ページの有無の判定ロジックを検討。headerから取得できる可能性あり。

      return (result, hasMore);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
