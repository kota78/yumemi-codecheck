import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck/core/data/dio_client_provider.dart';
import 'package:yumemi_codecheck/repositories/github/search/repo_search_repository.dart';

part 'repo_search_repository_provider.g.dart';

@riverpod
RepoSearchRepository repoSearchRepository(Ref ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RepoSearchRepository(dioClient: dioClient);
}
