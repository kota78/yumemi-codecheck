import 'package:flutter/material.dart';
import 'package:riverpod_paging_utils/riverpod_paging_utils.dart';
import 'package:yumemi_codecheck/view_models/repository_list_view_model.dart';

/// リポジトリ名の一覧を表示するView
/// riverpod_paging_utilsパッケージを使用
class RepositoryListView extends StatelessWidget {
  const RepositoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return PagingHelperView(
      provider: repositoryListViewModelProvider('flutter'),
      futureRefreshable: repositoryListViewModelProvider('flutter').future,
      notifierRefreshable: repositoryListViewModelProvider('flutter').notifier,
      contentBuilder: (data, widgetCount, endItemView) => ListView.builder(
        key: const PageStorageKey<String>('page'),
        itemCount: widgetCount,
        itemBuilder: (context, index) {
          // リストの最後の要素では、PagingHelperView が自動生成した終端ウィジェット（endItemView）を表示する
          if (index == widgetCount - 1) {
            return endItemView;
          }
          return Column(
            children: [
              ListTile(
                key: ValueKey(data.items[index].id),
                title: Text(data.items[index].name),
              ),
              const Divider(height: 1),
            ],
          );
        },
      ),
    );
  }
}
