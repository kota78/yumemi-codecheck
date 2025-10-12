import 'package:flutter/material.dart';
import 'package:riverpod_paging_utils/riverpod_paging_utils.dart';
import 'package:yumemi_codecheck/view_models/search/repository_list_view_model.dart';

/// リポジトリ名の一覧を表示するView
/// riverpod_paging_utilsパッケージを使用
class RepositoryListView extends StatelessWidget {
  const RepositoryListView({required this.query, super.key});
  final String query;

  @override
  Widget build(BuildContext context) {
    // query が空の場合はリストを表示しない
    if (query.isEmpty) {
      return const Center(
        child: Text('検索ワードを入力してください'),
      );
    }

    final provider = repositoryListViewModelProvider(query);
    return PagingHelperView(
      provider: provider,
      futureRefreshable: provider.future,
      notifierRefreshable: provider.notifier,
      contentBuilder: (data, widgetCount, endItemView) => ListView.builder(
        key: const PageStorageKey<String>('page'),
        itemCount: widgetCount,
        itemBuilder: (context, index) {
          // リストの最後の要素では、PagingHelperView が自動生成した終端ウィジェット（endItemView）を表示する
          if (index == widgetCount - 1) {
            return endItemView;
          }
          final item = data.items[index];
          return Column(
            children: [
              ListTile(
                key: ValueKey(item.id),
                title: Text(item.name),
              ),
              const Divider(height: 1),
            ],
          );
        },
      ),
    );
  }
}
