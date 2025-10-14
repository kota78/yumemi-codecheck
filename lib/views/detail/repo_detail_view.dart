import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yumemi_codecheck/models/detail/repo_detail_state.dart';

/// リポジトリ詳細情報を表示するページ全体
class RepoDetailPage extends StatelessWidget {
  const RepoDetailPage({
    required this.state,
    super.key,
  });

  /// 表示対象のリポジトリ詳細データ
  final RepoDetailState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // オーナーアイコン
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(state.avatarUrl),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surface, // 画像読み込み中の背景色
            ),
            const SizedBox(height: 20),
            Text(
              state.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.3, // 行間
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),

            // プロジェクト言語 (nullの可能性あり)
            if (state.language != null && state.language!.isNotEmpty)
              _IconTextItem(
                icon: Icons.code,
                text: state.language!,
              ),
            const SizedBox(height: 20),

            // 4. 各種メトリクス
            Column(
              children: [
                // 1行目: Star, Watcher
                Row(
                  children: [
                    Expanded(
                      child: _MetricItem(
                        icon: FontAwesomeIcons.star,
                        label: 'Star',
                        count: state.stargazersCount,
                      ),
                    ),
                    Expanded(
                      child: _MetricItem(
                        icon: FontAwesomeIcons.eye,
                        label: 'Watcher',
                        count: state.watchersCount,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // アイテム間の縦スペース
                // 2行目: Fork, Issue
                Row(
                  children: [
                    Expanded(
                      child: _MetricItem(
                        icon: FontAwesomeIcons.codeFork,
                        label: 'Fork',
                        count: state.forksCount,
                      ),
                    ),
                    Expanded(
                      child: _MetricItem(
                        icon: FontAwesomeIcons.circleDot,
                        label: 'Issue',
                        count: state.openIssuesCount,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// アイコンとテキストを横に並べるためのプライベート共通Widget
class _IconTextItem extends StatelessWidget {
  const _IconTextItem({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).iconTheme.color, size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

/// メトリクス表示用のプライベート共通Widget
class _MetricItem extends StatelessWidget {
  const _MetricItem({
    required this.icon,
    required this.label,
    required this.count,
  });

  final IconData icon;
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: Theme.of(context).iconTheme.color),
        const SizedBox(width: 6),
        Text(
          '$count',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
