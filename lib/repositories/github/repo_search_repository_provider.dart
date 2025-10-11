import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck/core/dio_client.dart';
import 'package:yumemi_codecheck/repositories/github/repo_search_repository.dart';

part 'repo_search_repository_provider.g.dart';

@riverpod
RepoSearchRepository repoSearchRepository(Ref ref) {
  final dioClient = DioClient('https://api.github.com');
  return RepoSearchRepository(dioClient: dioClient);
}
