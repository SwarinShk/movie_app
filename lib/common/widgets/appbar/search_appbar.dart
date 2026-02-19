import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final Color fillColor;

  const SearchAppBar({
    required this.controller,
    required this.onChanged,
    this.hintText = "Search movies, TV shows...",
    this.fillColor = AppColor.soft,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          return TextField(
            controller: controller,
            style: AppTextStyle.h5Medium.copyWith(color: AppColor.white),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyle.h5Medium.copyWith(color: AppColor.grey),
              filled: true,
              fillColor: fillColor,
              prefixIcon: const Icon(Icons.search, color: AppColor.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close, color: AppColor.redAccent),
                      onPressed: () {
                        controller.clear();
                        onChanged('');
                      },
                    )
                  : null,
            ),
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}
