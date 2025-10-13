import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_codecheck/models/search/repo_owner_entity.dart';

part 'repo_entity.freezed.dart';
part 'repo_entity.g.dart';

/// 個々のリポジトリ情報を表すEntity
@freezed
abstract class RepoEntity with _$RepositoryEntity {
  const factory RepoEntity({
    required String name, /// リポジトリ名
    required int id, /// id
    required RepoOwnerEntity owner, /// オーナー情報
    required int stargazersCount,  /// Star数
    required int watchersCount,/// Watcher数
    required int forksCount,  /// Fork数
    required int openIssuesCount, /// オープンなIssue数
    String? language,/// プロジェクト言語
  }) = _RepositoryEntity;
  const RepoEntity._();

  factory RepoEntity.fromJson(Map<String, dynamic> json) =>
      _$RepositoryEntityFromJson(json);
}
