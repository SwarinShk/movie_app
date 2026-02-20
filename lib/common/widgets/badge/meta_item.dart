import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';

class MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final double iconSize;
  final double spacing;

  const MetaItem({
    super.key,
    required this.icon,
    required this.text,
    this.color = AppColor.grey,
    this.iconSize = 16,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: iconSize, color: color),
        SizedBox(width: spacing),
        Text(text, style: AppTextStyle.h6Medium.copyWith(color: color)),
      ],
    );
  }
}
