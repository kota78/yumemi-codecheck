import 'package:yumemi_codecheck/models/detail/repo_detail_state.dart';
import 'package:yumemi_codecheck/models/search/repo_entity.dart';

// データ層のモデル(RepositoryEntity)をUI層が使うための状態(RepoDetailState)に変換するマッパー
RepoDetailState repoToState(RepoEntity entity) {
  return RepoDetailState(
    id: entity.id,
    name: entity.name,
    avatarUrl: entity.owner.avatarUrl,
    stargazersCount: entity.stargazersCount,
    watchersCount: entity.watchersCount,
    forksCount: entity.forksCount,
    openIssuesCount: entity.openIssuesCount,
    language: entity.language,
  );
}
