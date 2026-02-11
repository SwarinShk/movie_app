import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';

class CustomIconButton extends StatelessWidget {
  final double height;
  final double width;
  final String icon;
  final Color backgroundColor;
  final void Function() onPressed;

  const CustomIconButton({
    this.height = 65,
    this.width = 65,
    required this.icon,
    this.backgroundColor = AppColor.redAccent,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: IconButton(
        style: IconButton.styleFrom(
          elevation: 0,
          foregroundColor: AppColor.lineDark,
          backgroundColor: backgroundColor,
          shape: CircleBorder(),
        ),
        onPressed: onPressed,
        icon: Image.asset(icon),
      ),
    );
  }
}
