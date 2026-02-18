import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';

class MetaDivider extends StatelessWidget {
  final Color? color;
  final TextStyle? style;

  const MetaDivider({super.key, this.color, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      '|',
      style: (style ?? AppTextStyle.h6Medium).copyWith(
        color: color ?? AppColor.grey,
      ),
    );
  }
}
