import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_codecheck/models/search/repo_entity.dart';

part 'repo_list_entity.freezed.dart';
part 'repo_list_entity.g.dart';

/// GitHubリポジトリ検索APIのレスポンス全体を表すEntity
@freezed
abstract class RepoListEntity with _$RepoListEntity {
  const factory RepoListEntity({
    required int totalCount, /// 検索結果の総数
    required List<RepoEntity> items,    /// 検索結果のリスト
  }) = _RepoListEntity;
  const RepoListEntity._();

  factory RepoListEntity.fromJson(Map<String, dynamic> json) =>
      _$RepoListEntityFromJson(json);
}
