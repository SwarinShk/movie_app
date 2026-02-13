import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String subtitle;
  final VoidCallback? onFavoriteTap;
  final Widget? avatar;

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
    return AppBar(
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: CircleAvatar(
          backgroundColor: AppColor.orange,
          radius: 20,
          child: Text(
            _getInitials(userName),
            style: AppTextStyle.h4SemiBold.copyWith(color: AppColor.white),
          ),
        ),
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
          padding: const EdgeInsets.only(right: 15),
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

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
