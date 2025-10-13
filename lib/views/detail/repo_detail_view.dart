import 'package:flutter/material.dart';
import 'package:yumemi_codecheck/models/detail/repo_detail_state.dart';

/// リポジトリ詳細情報を表示するページ全体
class RepoDetailPage extends StatelessWidget {
  const RepoDetailPage({
    required this.detail,
    super.key,
  });

  /// 表示対象のリポジトリ詳細データ
  final RepoDetailState detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. リポジトリ名
            Text(
              detail.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.3, // 行間
              ),
            ),
            const SizedBox(height: 24),

            // 2. オーナー情報
            CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(detail.avatarUrl),
                  backgroundColor: Colors.transparent, // 画像読み込み中の背景色
                ),
            const SizedBox(height: 12),

            // 3. プロジェクト言語 (nullの可能性あり)
            if (detail.language != null && detail.language!.isNotEmpty)
              _IconTextItem(
                icon: Icons.code,
                text: detail.language!,
              ),
            const SizedBox(height: 32),

            // 4. 各種メトリクス (Star, Watcherなど)
            Wrap(
              spacing: 28, // アイテム間の横方向のスペース
              runSpacing: 20, // アイテム間の縦方向のスペース
              children: [
                _MetricItem(
                  icon: Icons.star_border,
                  label: 'Star',
                  count: detail.stargazersCount,
                ),
                _MetricItem(
                  icon: Icons.visibility_outlined,
                  label: 'Watcher',
                  count: detail.watchersCount,
                ),
                _MetricItem(
                  icon: Icons.call_split,
                  label: 'Fork',
                  count: detail.forksCount,
                ),
                _MetricItem(
                  icon: Icons.lens_outlined,
                  label: 'Issue',
                  count: detail.openIssuesCount,
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
        Icon(icon, color: Colors.black54, size: 20),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 16)),
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
        Icon(icon, size: 20, color: Colors.black87),
        const SizedBox(width: 6),
        Text(
          '$count',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
