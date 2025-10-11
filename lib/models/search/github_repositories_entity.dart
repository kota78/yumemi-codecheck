import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_codecheck/models/search/repository_entity.dart';

part 'github_repositories_entity.freezed.dart';
part 'github_repositories_entity.g.dart';

/// GitHubリポジトリ検索APIのレスポンス全体を表すEntity
@freezed
abstract class GitHubRepositoriesEntity with _$GitHubRepositoriesEntity {
  const factory GitHubRepositoriesEntity({
    required int totalCount, /// 検索結果の総数
    required List<RepositoryEntity> items,    /// 検索結果のリスト
  }) = _GitHubRepositoriesEntity;
  const GitHubRepositoriesEntity._();

  /// JSONからインスタンスを生成するfactoryメソッド
  factory GitHubRepositoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$GitHubRepositoriesEntityFromJson(json);
}