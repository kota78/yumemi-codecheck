import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_codecheck/models/search/repository_owner_entity.dart';

part 'repository_entity.freezed.dart';
part 'repository_entity.g.dart';

/// 個々のリポジトリ情報を表すEntity
@freezed
abstract class RepositoryEntity with _$RepositoryEntity {
  const factory RepositoryEntity({
    required String name, /// リポジトリ名
    required RepositoryOwnerEntity owner, /// オーナー情報
    required int stargazersCount,  /// Star数
    required int watchersCount,/// Watcher数
    required int forksCount,  /// Fork数
    required int openIssuesCount, /// オープンなIssue数
    String? language,/// プロジェクト言語
  }) = _RepositoryEntity;
  const RepositoryEntity._();

  factory RepositoryEntity.fromJson(Map<String, dynamic> json) =>
      _$RepositoryEntityFromJson(json);
}
