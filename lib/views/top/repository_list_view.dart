import 'package:flutter/material.dart';

/// リポジトリ名の一覧を表示するView
class RepositoryListView extends StatelessWidget {
  const RepositoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(10, (i) => 'Repository #${i + 1}');
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) => ListTile(title: Text(items[index])),
    );
  }
}
