import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';
import 'package:movie_app/models/account_model.dart';
import 'package:movie_app/shared/avatar/avatar_widget.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String subtitle;
  final VoidCallback? onFavoriteTap;
  final Avatar? avatar;

  const HomeAppBar({
    super.key,
    required this.userName,
    required this.subtitle,
    this.onFavoriteTap,
    this.avatar,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 15.0;

    return AppBar(
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: horizontalPadding),
        child: AvatarWidget(avatar: avatar, userName: userName),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, $userName',
            style: AppTextStyle.h4SemiBold.copyWith(color: AppColor.white),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyle.h6Medium.copyWith(color: AppColor.white),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: horizontalPadding),
          child: IconButton.filled(
            onPressed: onFavoriteTap,
            icon: const Icon(Icons.favorite),
            style: IconButton.styleFrom(
              backgroundColor: AppColor.soft,
              foregroundColor: AppColor.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
