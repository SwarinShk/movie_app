import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const CustomIconButton({
    this.icon = Icons.favorite,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: AppColor.soft,
        foregroundColor: AppColor.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
