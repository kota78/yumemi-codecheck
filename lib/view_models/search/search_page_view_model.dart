import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_page_view_model.g.dart';

/// 検索ページ全体を管理するViewModel
/// - 現在の検索ワードを保持
/// - 検索ワード変更時にリポジトリリストをリフレッシュ
@riverpod
class SearchPageViewModel extends _$SearchPageViewModel {
  @override
  String build() => ''; // 初期状態は空文字

  /// 検索ワードを更新する
  void setQuery(String query) {
    state = query.trim();
  }

  /// 検索をリセット
  void clearQuery() {
    state = '';
  }
}
