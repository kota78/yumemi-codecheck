import 'package:flutter/material.dart';
import 'package:yumemi_codecheck/core/data/api_exception.dart';
import 'package:yumemi_codecheck/core/data/dio_client.dart';
import 'package:yumemi_codecheck/models/search/repo_list_entity.dart';

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
  Future<(RepoListEntity, bool)> fetch({
    required int page,
    required String query,
  }) async {
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
      throw ApiException(ApiErrorType.unknownError);
    }

    final result = RepoListEntity.fromJson(data);
    // --- Linkヘッダーからページ情報を取得 ---
    bool hasMore;
    final linkHeader = response.headers.map['link']?.first;
    if (linkHeader != null) {
      // "rel=\"next\"" があるか確認
      hasMore = linkHeader.contains('rel="next"');
      debugPrint('link header: $linkHeader');
    } else {
      hasMore = false;
    }
    debugPrint('HasMorePage: $hasMore');

    return (result, hasMore);
  }
}
