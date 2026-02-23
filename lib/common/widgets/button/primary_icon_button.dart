import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';

class PrimaryIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const PrimaryIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: AppColor.white),
      label: Text(
        label,
        style: AppTextStyle.h4Medium.copyWith(color: AppColor.white),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: AppColor.lineDark,
        backgroundColor: backgroundColor ?? AppColor.redAccent,
        disabledForegroundColor: AppColor.lineDark.withValues(alpha: 0.2),
        disabledBackgroundColor: (backgroundColor ?? AppColor.redAccent)
            .withValues(alpha: 0.2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
      ),
    );
  }
}
