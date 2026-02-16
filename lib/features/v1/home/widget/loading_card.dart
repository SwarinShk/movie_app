import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';

class LoadingCard extends StatelessWidget {
  final double width;
  final double borderRadius;

  const LoadingCard({
    this.width = double.infinity,
    this.borderRadius = 16,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.grey,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: AppColor.white),
      ),
    );
  }
}
