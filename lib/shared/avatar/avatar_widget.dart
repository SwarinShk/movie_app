import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';
import 'package:movie_app/core/helpers/text_helper/text_helper.dart';
import 'package:movie_app/models/account_model.dart';

class AvatarWidget extends StatelessWidget {
  final Avatar? avatar;
  final String? userName;
  final double size;
  final Color backgroundColor;

  const AvatarWidget({
    super.key,
    this.avatar,
    this.userName,
    this.size = 40,
    this.backgroundColor = AppColor.orange,
  });

  @override
  Widget build(BuildContext context) {
    if (avatar?.tmdb.avatarPath != null) {
      return _buildImage(
        'https://image.tmdb.org/t/p/w500${avatar!.tmdb.avatarPath}',
      );
    } else if (avatar?.gravatar.hash != null) {
      return _buildImage(
        'https://gravatar.com/avatar/${avatar!.gravatar.hash}?s=200&d=identicon',
      );
    } else {
      return _buildInitials();
    }
  }

  Widget _buildImage(String url) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildInitials() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
      alignment: Alignment.center,
      child: Text(
        getInitials(userName ?? ''),
        style: AppTextStyle.h4SemiBold.copyWith(color: AppColor.white),
      ),
    );
  }
}
