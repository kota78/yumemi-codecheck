import 'package:flutter/material.dart';
import 'package:yumemi_codecheck/core/api_exception.dart';
import 'package:yumemi_codecheck/l10n/app_localizations.dart';

extension ApiErrorTypeX on ApiErrorType {
  String localized(BuildContext context, {int? code}) {
    final loc = AppLocalizations.of(context);

    switch (this) {
      case ApiErrorType.timeoutError:
        return loc?.timeoutError ?? 'The connection has timed out.';

      case ApiErrorType.serverError:
        return loc?.serverError(code ?? '') ??
            'A server error occurred. (Code: ${code ?? ''})';

      case ApiErrorType.clientError:
        return loc?.clientError(code ?? '') ??
            'The request failed. (Code: ${code ?? ''})';

      case ApiErrorType.networkError:
        return loc?.networkError ??
            'Could not connect to the network. Please check your connection.';

      case ApiErrorType.rateLimitError:
        return loc?.rateLimitError ??
            '''
Rate limit exceeded.
You can log in via the user icon to lift restrictions.
''';

      case ApiErrorType.cancelError:
        return loc?.cancelError ?? 'The request was cancelled.';

      case ApiErrorType.authorizationCodeError:
        return loc?.authorizationCodeError ??
            'Failed to obtain the authorization code.';

      case ApiErrorType.accessTokenError:
        return loc?.accessTokenError ?? 'Failed to retrieve the access token.';

      case ApiErrorType.unknownError:
        return loc?.unknownError ?? 'An unexpected error occurred.';
    }
  }
}
