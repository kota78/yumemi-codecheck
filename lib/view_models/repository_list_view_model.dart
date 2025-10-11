import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_paging_utils/riverpod_paging_utils.dart';
import 'package:yumemi_codecheck/models/search/repository_entity.dart';
import 'package:yumemi_codecheck/repositories/github/repo_search_repository_provider.dart';

part 'repository_list_view_model.g.dart';

@riverpod
class RepositoryListViewModel extends _$RepositoryListViewModel
    with PagePagingNotifierMixin<RepositoryEntity> {

  @override
  Future<PagePagingData<RepositoryEntity>> build(String query) {
    // もし検索ワードが空なら、APIを叩かずに空のリストを返す
    if (query.isEmpty) {
      return Future.value(
        const PagePagingData(items: [], hasMore: false, page: 1),
      );
    }
    // 最初のページを取得
    return fetch(page: 1);
  }

  @override
  Future<PagePagingData<RepositoryEntity>> fetch({
    required int page,
  }) async {
    final repository = ref.read(repoSearchRepositoryProvider);
    final (result, hasMore) = await repository.fetch(page: page, query: query);
    ref.keepAlive();

    return PagePagingData(
      items: result.items,
      hasMore: hasMore,
      page: page,
    );
  }
}
