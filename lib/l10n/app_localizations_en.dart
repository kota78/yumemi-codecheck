// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Search Repositories';

  @override
  String get loginPrompt => 'Do you want to log in?';

  @override
  String get logoutPrompt => 'Do you want to log out?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get pleaseEnter => 'Please enter';

  @override
  String get enterSearchWord => 'Please enter a search word';

  @override
  String get timeoutError => 'The connection has timed out.';

  @override
  String serverError(Object code) {
    return 'A server error occurred. (Code: $code)';
  }

  @override
  String clientError(Object code) {
    return 'The request failed. (Code: $code)';
  }

  @override
  String get networkError =>
      'Could not connect to the network. Please check your connection.';

  @override
  String get rateLimitError =>
      'Rate limit exceeded. You can log in via the user icon to lift restrictions.';

  @override
  String get cancelError => 'The request was cancelled.';

  @override
  String get unknownError => 'An unexpected error occurred.';
}
