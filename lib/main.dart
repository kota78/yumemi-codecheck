import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_paging_utils/theme_extension.dart';
import 'package:yumemi_codecheck/components/widgets/custom_end_error_view.dart';
import 'package:yumemi_codecheck/components/widgets/custom_error_view.dart';
import 'package:yumemi_codecheck/l10n/app_localizations.dart';
import 'package:yumemi_codecheck/views/search/search_page.dart';

void main() async {
  await dotenv.load();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    PagingHelperViewTheme buildPagingTheme() => PagingHelperViewTheme(
      errorViewBuilder: (context, error, _, onRefreshButtonPressed) =>
          CustomErrorView(
            error: error,
            onRefreshButtonPressed: onRefreshButtonPressed,
          ),
      endErrorViewBuilder: (context, error, onRetryButtonPressed) =>
          CustomEndErrorView(
            error: error,
            onRefreshButtonPressed: onRetryButtonPressed,
          ),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        extensions: [buildPagingTheme()],
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: [buildPagingTheme()],
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // 英語
        Locale('ja'), // 日本語
      ],
      home: const SearchPage(),
    );
  }
}
