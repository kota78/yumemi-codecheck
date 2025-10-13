import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_paging_utils/riverpod_paging_utils.dart';
import 'package:yumemi_codecheck/models/detail/repo_detail_state.dart';
import 'package:yumemi_codecheck/repositories/github/repo_search_repository_provider.dart';
import 'package:yumemi_codecheck/view_models/search/repo_to_state_mapper.dart';

part 'repo_list_view_model.g.dart';

///   GitHub リポジトリ検索結果の一覧をページングで管理する ViewModel。
///
/// - 検索クエリ（[query]）をもとに GitHub API からリポジトリ一覧を取得する。
/// - PagePagingNotifierMixin を利用し、ページング状態を自動管理。
/// - 検索クエリが空の場合は API を呼ばず、空のリストを返す。
@riverpod
class RepoListViewModel extends _$RepoListViewModel
    with PagePagingNotifierMixin<RepoDetailState> {

  @override
  Future<PagePagingData<RepoDetailState>> build(String query) {
    // もし検索ワードが空なら、APIを叩かずに空のリストを返す
    if (query.isEmpty) {
      return Future.value(
        const PagePagingData(items: [], hasMore: false, page: 1),
      );
    }
    return fetch(page: 1);
  }

  @override
  Future<PagePagingData<RepoDetailState>> fetch({
    required int page,
  }) async {
    final repository = ref.read(repoSearchRepositoryProvider);
    final (result, hasMore) = await repository.fetch(page: page, query: query);
    final detailStates = result.items.map(repoToState).toList();
    ref.keepAlive();

    return PagePagingData(
      items: detailStates,
      hasMore: hasMore,
      page: page,
    );
  }
}
