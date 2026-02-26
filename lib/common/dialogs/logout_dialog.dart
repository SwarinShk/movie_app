import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/core/constants/app_color.dart';

class LogoutDialog extends StatelessWidget {
  final void Function()? onLogOutPressed;

  const LogoutDialog({this.onLogOutPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
          color: AppColor.dark,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              "Log Out Account",
              style: AppTextStyle.bodySemiBold.copyWith(
                color: AppColor.white,
                fontSize: 20,
              ),
              textAlign: .center,
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              "Are you sure you want to logout? Once you logout you need to login again. Are you Ok?",
              style: AppTextStyle.bodyRegular.copyWith(
                color: AppColor.grey,
                fontSize: 13,
                height: 1.6,
              ),
              textAlign: .center,
            ),

            const SizedBox(height: 28),

            // Buttons Row
            Row(
              children: [
                // Log Out (Outlined)
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColor.redAccent),
                      foregroundColor: AppColor.redAccent,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onPressed: onLogOutPressed,
                    child: const Text("Log Out"),
                  ),
                ),

                const SizedBox(width: 16),

                // Cancel (Filled)
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.redAccent,
                      foregroundColor: AppColor.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
