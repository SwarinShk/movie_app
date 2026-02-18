import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';

class DotsIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalDots;

  const DotsIndicator({
    super.key,
    required this.currentIndex,
    required this.totalDots,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        totalDots,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(right: 8),
          height: 10,
          width: currentIndex == index ? 32 : 10,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColor.redAccent
                : AppColor.darkGrey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
