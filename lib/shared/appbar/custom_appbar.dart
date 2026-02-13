import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData? leading;
  final void Function()? onLeadingPressed;
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({
    this.leading,
    this.onLeadingPressed,
    required this.title,
    this.actions,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton.filled(
        onPressed: onLeadingPressed,
        icon: Icon(leading, color: AppColor.white),
        style: IconButton.styleFrom(
          foregroundColor: AppColor.lineDark,
          backgroundColor: AppColor.soft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: AppTextStyle.h3SemiBold.copyWith(color: AppColor.white),
      ),
      actions: actions,
    );
  }
}
