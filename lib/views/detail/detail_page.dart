import 'package:flutter/material.dart';
import 'package:yumemi_codecheck/models/detail/repo_detail_state.dart';
import 'package:yumemi_codecheck/views/detail/repo_detail_view.dart';

/// 詳細ページの全体的なレイアウトを定義するWidget
/// AppBarと本体(RepoDetailView)で構成される
class DetailPage extends StatelessWidget {
  const DetailPage({required this.state, super.key});
  final RepoDetailState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        // 右側に配置するWidget群
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            // スケッチの丸いユーザーアイコン
            // Providerの値を反映させる前の仮実装
            child: CircleAvatar(
              backgroundColor: Color(0xFFE0E0E0), // Grey 300
              child: Icon(
                Icons.person_outline,
                color: Colors.black54,
              ),
            ),
          ),
        ],
        // AppBarの背景色を透明にし、影をなくす
        backgroundColor: Colors.transparent,
        elevation: 0,
        // AppBarの下線を非表示にする
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[300],
            height: 1,
          ),
        ),
      ),
      // 画面の本体
      body: RepoDetailPage(state: state),
    );
  }
}
