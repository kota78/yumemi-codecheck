import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yumemi_codecheck/l10n/app_localizations.dart';

/// リポジトリ名を検索するためのワードを入力するボックス
class SearchBoxView extends HookWidget {
  const SearchBoxView({
    required this.initialValue,
    required this.onChanged,
    super.key,
    this.onClear,
  });

  /// 初期表示する文字列
  final String initialValue;

  /// 入力中に呼ばれるコールバック
  final ValueChanged<String> onChanged;

  /// クリアボタン押下時に呼ばれる
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue);
    final text = useState(initialValue);

    // TextEditingController の変化を監視
    useEffect(
      () {
        void listener() => text.value = controller.text;
        controller.addListener(listener);
        return () => controller.removeListener(listener);
      },
      [controller],
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[800]
            : Theme.of(context).colorScheme.surface,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 56,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)?.hintText ??
                        'search word',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onSubmitted: (value) {
                    onChanged(value.trim());
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              if (text.value.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                    FocusScope.of(context).unfocus();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
