import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck/components/search_box_view.dart';
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
    );
  }
}
