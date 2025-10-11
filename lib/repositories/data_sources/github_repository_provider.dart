import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck/core/dio_client.dart';
import 'package:yumemi_codecheck/repositories/data_sources/github_repository.dart';

part 'github_repository_provider.g.dart';

@riverpod
GithubRepository githubRepository(Ref ref) {
  final dioClient = DioClient('https://api.github.com');
  return GithubRepository(dioClient: dioClient);
}
