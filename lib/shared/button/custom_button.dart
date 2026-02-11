import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final void Function() onPressed;

  const CustomButton({
    this.height = 55,
    this.width = double.infinity,
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: AppColor.lineDark,
          backgroundColor: AppColor.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(32),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: AppColor.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
