
import 'package:flutter/material.dart';

import '../../utils/constant/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBack;
  final Function()? onBack;
  final Widget? actions;
  const CustomAppBar({
    super.key,
    required this.title,
    this.isBack = true,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBack,
            )
          : null,
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.neutral900,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        actions ?? const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
