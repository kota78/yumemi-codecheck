import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository_owner_entity.freezed.dart';
part 'repository_owner_entity.g.dart';

/// リポジトリのオーナー情報を表すEntity
@freezed
abstract class RepositoryOwnerEntity with _$RepositoryOwnerEntity {

  const factory RepositoryOwnerEntity({
    required String avatarUrl,/// オーナーのアイコン画像URL
  }) = _RepositoryOwnerEntity;
  const RepositoryOwnerEntity._();

  factory RepositoryOwnerEntity.fromJson(Map<String, dynamic> json) =>
      _$RepositoryOwnerEntityFromJson(json);
}
