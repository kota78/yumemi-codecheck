import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck/models/login/login_state.dart';
import 'package:yumemi_codecheck/view_models/login/login_avatar_view_model.dart';

class LoginAvatarView extends HookConsumerWidget {
  const LoginAvatarView({super.key});

  Future<void> showConfirmDialog({
    required BuildContext context,
    required String title,
    required VoidCallback onConfirm,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('いいえ'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('はい'),
          ),
        ],
      ),
    );
    if (result ?? false) {
      onConfirm();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginAvatarViewModelProvider);
    final notifier = ref.read(loginAvatarViewModelProvider.notifier);
    final value = state.value ?? LoginState.initial();

    return GestureDetector(
      onTap: () async {
        if (value.isLoggedIn) {
          await showConfirmDialog(
            context: context,
            title: 'ログアウトしますか？',
            onConfirm: notifier.onLogout,
          );
        } else {
          await showConfirmDialog(
            context: context,
            title: 'ログインしますか？',
            onConfirm: notifier.onLogin,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: CircleAvatar(
          radius: 28,
          backgroundImage: (value.avatarUrl.isNotEmpty)
              ? NetworkImage(value.avatarUrl)
              : null,
          child: value.avatarUrl.isEmpty
              ? Icon(
                  Icons.person,
                  size: 28,
                  color: Theme.of(context).iconTheme.color,
                )
              : null,
        ),
      ),
    );
  }
}
