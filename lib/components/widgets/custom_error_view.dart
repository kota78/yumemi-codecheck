import 'package:flutter/material.dart';
import 'package:yumemi_codecheck/core/data/api_exception.dart';
import 'package:yumemi_codecheck/core/extensions/api_error_type_x.dart';
import 'package:yumemi_codecheck/l10n/app_localizations.dart';

/// PagingHelperViewTheme の errorViewの互換ビュー

class CustomErrorView extends StatelessWidget {
  const CustomErrorView({
    required this.error,
    required this.onRefreshButtonPressed,
    super.key,
  });

  /// 表示するエラーオブジェクト
  final Object error;

  /// リトライなどで呼ばれるコールバック
  final VoidCallback onRefreshButtonPressed;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    String message;

    // ApiExceptionのローカライズ処理
    if (error is ApiException) {
      final apiError = error as ApiException;
      message = apiError.type.localized(context, code: apiError.statusCode);
    } else {
      message = loc?.unknownError ?? 'An unexpected error occurred.';
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onRefreshButtonPressed,
              icon: const Icon(Icons.refresh),
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}
