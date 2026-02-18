import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';

class RatingBadge extends StatelessWidget {
  final double rating;

  const RatingBadge({required this.rating, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: AppColor.darkGrey.withValues(alpha: 0.4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 14, color: AppColor.orange),
              const SizedBox(width: 4),
              Text(
                rating.toStringAsFixed(1),
                style: AppTextStyle.h6SemiBold.copyWith(color: AppColor.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
