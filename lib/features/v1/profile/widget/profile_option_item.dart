import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';

class ProfileOptionItem extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final IconData tralingIcon;

  const ProfileOptionItem({
    required this.leadingIcon,
    required this.title,
    required this.tralingIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColor.soft,
              child: Icon(leadingIcon, color: AppColor.grey),
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: AppTextStyle.h5Medium.copyWith(color: AppColor.white),
            ),
          ],
        ),
        Icon(tralingIcon, color: AppColor.redAccent),
      ],
    );
  }
}
