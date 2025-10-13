import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck/components/search_box_view.dart';
import 'package:yumemi_codecheck/view_models/search/search_page_view_model.dart';
import 'package:yumemi_codecheck/views/search/repository_list_view.dart';

/// 検索ページの骨組み
class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchPageViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.person))],
      ),
      body: Column(
        children: [
          SearchBoxView(
             initialValue: query,
            onChanged: (text) {
              ref.read(searchPageViewModelProvider.notifier).setQuery(text);
            },
            onClear: () {
              ref.read(searchPageViewModelProvider.notifier).clearQuery();
            },
          ),
          Expanded(child: RepoListView(query: query)),
        ],
      ),
    );
  }
}
