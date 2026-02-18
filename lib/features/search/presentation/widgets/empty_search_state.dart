import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';

class EmptySearchState extends StatelessWidget {
  final String? query;
  final String emptyIconText;
  final double iconSize;

  const EmptySearchState({
    super.key,
    this.query,
    this.emptyIconText = 'No results found',
    this.iconSize = 75,
  });

  @override
  Widget build(BuildContext context) {
    final isQueryEmpty = (query ?? '').trim().isEmpty;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isQueryEmpty ? Icons.search : Icons.search_off,
            color: AppColor.grey,
            size: iconSize,
          ),
          const SizedBox(height: 20),
          Text(
            isQueryEmpty ? 'Start typing to search' : emptyIconText,
            style: AppTextStyle.h4SemiBold.copyWith(color: AppColor.grey),
          ),
        ],
      ),
    );
  }
}
