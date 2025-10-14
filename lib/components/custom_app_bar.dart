import 'package:flutter/material.dart';
import 'package:yumemi_codecheck/models/login/login_state.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.state,
    this.title = '',
    this.showBackButton = false,
    super.key,
  });
  final String title;
  final bool showBackButton;
  final LoginState state;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(context).colorScheme.surface,
      // showBackButtonがfalseの場合はleadingをnullに設定し、戻るボタンを非表示
      leading: showBackButton ? const BackButton() : null,
      // leadingの有無で戻るボタンのスペースが確保されるのを防ぐ
      automaticallyImplyLeading: showBackButton,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            backgroundImage: state.isLoggedIn
                ? NetworkImage(state.avatarUrl)
                : null,
            child: state.isLoggedIn ? null : const Icon(Icons.person_outline),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
