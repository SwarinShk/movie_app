import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/common/widgets/button/custom_text_button.dart';

class MovieArea extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final Widget child;

  const MovieArea({
    required this.title,
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.h4SemiBold.copyWith(color: AppColor.white),
            ),
            CustomTextButton(title: 'See All', onPressed: onPressed),
          ],
        ),
        const SizedBox(height: 15),
        child,
      ],
    );
  }
}
