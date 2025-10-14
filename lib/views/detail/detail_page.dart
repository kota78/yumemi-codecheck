import 'package:flutter/material.dart';
import 'package:yumemi_codecheck/models/detail/repo_detail_state.dart';
import 'package:yumemi_codecheck/views/detail/repo_detail_view.dart';

/// 詳細ページのレイアウトを定義するWidget
class DetailPage extends StatelessWidget {
  const DetailPage({required this.state, super.key});
  final RepoDetailState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RepoDetailPage(state: state),
    );
  }
}
