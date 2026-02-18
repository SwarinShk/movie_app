import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';

class ProfileArea extends StatelessWidget {
  final double? padding;
  final BoxBorder? border;
  final double? borderRadius;
  final Widget child;

  const ProfileArea({
    this.padding,
    this.border,
    this.borderRadius,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 15),
      decoration: BoxDecoration(
        border: border ?? Border.all(color: AppColor.soft),
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
      ),
      child: child,
    );
  }
}
