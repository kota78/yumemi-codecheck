import 'package:freezed_annotation/freezed_annotation.dart';

// build_runnerで自動生成されるファイル
part 'repo_detail_state.freezed.dart';
part 'repo_detail_state.g.dart';

@freezed
abstract class RepoDetailState with _$RepoDetailState {
  const factory RepoDetailState({
    /// リポジトリ名
    required String name,

    /// id
    required int id,

    /// オーナーのアイコン画像URL
    // 'owner' オブジェクトから avatar_url を抽出するために readValue を指定
    required String avatarUrl,

    /// Star数
    required int stargazersCount,

    /// Watcher数
    required int watchersCount,

    /// Fork数
    required int forksCount,

    /// オープンなIssue数
    required int openIssuesCount,

    /// プロジェクト言語
    String? language,
  }) = _RepoDetailState;

  /// JSONからRepoDetailStateを生成するファクトリコンストラクタ
  factory RepoDetailState.fromJson(Map<String, dynamic> json) =>
      _$RepoDetailStateFromJson(json);
}
