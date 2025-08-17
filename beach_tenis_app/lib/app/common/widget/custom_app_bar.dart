import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.onBackPressed,
    this.leading,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: foregroundColor ?? AppStyles.white,
        ),
      ),
      backgroundColor: backgroundColor ?? AppStyles.primaryBlue,
      foregroundColor: foregroundColor ?? AppStyles.white,
      elevation: 0,
      centerTitle: true,
      leading: leading ?? (showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarWithProfile extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? userName;
  final String? userAvatar;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onProfilePressed;

  const CustomAppBarWithProfile({
    Key? key,
    required this.title,
    this.userName,
    this.userAvatar,
    this.onMenuPressed,
    this.onProfilePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppStyles.primaryBlue,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppStyles.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          GestureDetector(
            onTap: onProfilePressed,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppStyles.white,
              backgroundImage: userAvatar != null ? NetworkImage(userAvatar!) : null,
              child: userAvatar == null
                  ? const Icon(Icons.person, color: AppStyles.primaryBlue)
                  : null,
            ),
          ),
          const SizedBox(width: AppStyles.mediumSpace),
          if (userName != null)
            Text(
              userName!,
              style: const TextStyle(
                color: AppStyles.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: AppStyles.white),
          onPressed: onMenuPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
