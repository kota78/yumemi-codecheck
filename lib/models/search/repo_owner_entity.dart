import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo_owner_entity.freezed.dart';
part 'repo_owner_entity.g.dart';

/// リポジトリのオーナー情報を表すEntity
@freezed
abstract class RepoOwnerEntity with _$RepoOwnerEntity {
  const factory RepoOwnerEntity({
    required String avatarUrl,/// オーナーのアイコン画像URL
  }) = _RepoOwnerEntity;
  const RepoOwnerEntity._();

  factory RepoOwnerEntity.fromJson(Map<String, dynamic> json) =>
      _$RepoOwnerEntityFromJson(json);
}
