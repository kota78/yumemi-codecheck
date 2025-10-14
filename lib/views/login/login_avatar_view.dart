import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck/view_models/login/login_avatar_view_model.dart';

class LoginAvatarView extends HookConsumerWidget {
  const LoginAvatarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginAvatarViewModelProvider);
    final notifier = ref.read(loginAvatarViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Login')),
      body: Center(
        child: state.isLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: (state.avatarUrl.isNotEmpty)
                        ? NetworkImage(state.avatarUrl)
                        : null,
                    child: state.avatarUrl.isEmpty
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text(state.name, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: notifier.logout,
                    child: const Text('ログアウト'),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: () async {
                  await notifier.login();
                  await notifier.fetchUserProfile();
                },
                child: const Text('GitHubでログイン'),
              ),
      ),
    );
  }
}
