// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get title => 'リポジトリを検索';

  @override
  String get loginPrompt => 'ログインしますか？';

  @override
  String get logoutPrompt => 'ログアウトしますか？';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';

  @override
  String get pleaseEnter => '入力してください';

  @override
  String get enterSearchWord => '検索ワードを入力してください';

  @override
  String get timeoutError => '接続がタイムアウトしました。';

  @override
  String serverError(Object code) {
    return 'サーバーで問題が発生しました。(コード: $code)';
  }

  @override
  String clientError(Object code) {
    return 'リクエストに失敗しました。(コード: $code)';
  }

  @override
  String get networkError => 'ネットワークに接続できませんでした。接続状況を確認してください。';

  @override
  String get rateLimitError =>
      'リクエスト超過エラーが発生しました。ユーザーアイコンをタップしてログインすることで緩和されます。';

  @override
  String get cancelError => 'リクエストがキャンセルされました。';

  @override
  String get unknownError => '予期せぬエラーが発生しました。';

  @override
  String get authorizationCodeError => '認可コードの取得に失敗しました。';

  @override
  String get accessTokenError => 'アクセストークンの取得に失敗しました。';
}
