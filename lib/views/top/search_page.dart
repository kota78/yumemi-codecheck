import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck/components/search_box_view.dart';
import 'package:yumemi_codecheck/core/api_exception.dart';
import 'package:yumemi_codecheck/repositories/github/repo_search_repository_provider.dart';
import 'package:yumemi_codecheck/views/top/repository_list_view.dart';

/// 検索ページの骨組み
class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.person))],
      ),
      body: const Column(
        children: [SerchBoxView(), Expanded(child: RepositoryListView())],
      ),
      /// リポジトリ検索のデバッグ用ボタン
      floatingActionButton: FloatingActionButton(onPressed: () async {
        try {
          final repository = ref.read(repoSearchRepositoryProvider);
          final result = await repository.searchRepositories(
            query: 'flutter',
          );
          debugPrint('検索結果: ${result.items.length}件');
          for (final repo in result.items) {
            debugPrint('リポジトリ名: ${repo.name}');
            debugPrint('star: ${repo.stargazersCount}');
            debugPrint('language: ${repo.language}');
            debugPrint('owner: ${repo.owner.avatarUrl}');
            debugPrint('watcher: ${repo.watchersCount}');
          }
        } on ApiException catch (e) {
          debugPrint('エラーが発生しました: $e');
        }
      },),
    );
  }
}
