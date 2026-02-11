import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';

class LabeledField extends StatelessWidget {
  const LabeledField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: AppColor.whiteGrey)),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
