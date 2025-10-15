import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.title = '',
    this.showBackButton = false,
    super.key, this.userAvatar,
  });
  final String title;
  final bool showBackButton;
  final Widget? userAvatar;

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
      actions: userAvatar != null ? [userAvatar!] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
