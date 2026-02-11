import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';

class LineDivider extends StatelessWidget {
  const LineDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Divider(color: AppColor.lineDark));
  }
}
