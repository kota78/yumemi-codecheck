import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_codecheck/models/search/repository_entity.dart';

part 'repositoriy_list_entity.freezed.dart';
part 'repositoriy_list_entity.g.dart';

/// GitHubリポジトリ検索APIのレスポンス全体を表すEntity
@freezed
abstract class RepositoryListEntity with _$RepositoryListEntity {
  const factory RepositoryListEntity({
    required int totalCount, /// 検索結果の総数
    required List<RepositoryEntity> items,    /// 検索結果のリスト
  }) = _RepositoryListEntity;
  const RepositoryListEntity._();

  factory RepositoryListEntity.fromJson(Map<String, dynamic> json) =>
      _$RepositoryListEntityFromJson(json);
}
