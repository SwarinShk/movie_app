import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/common/dialogs/logout_dialog.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/common/styles/app_textstyle.dart';
import 'package:movie_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:movie_app/features/profile/presentation/widgets/profile_area.dart';
import 'package:movie_app/features/profile/presentation/widgets/profile_option_item.dart';
import 'package:movie_app/common/widgets/appbar/custom_appbar.dart';
import 'package:movie_app/common/widgets/avatar/avatar_widget.dart';
import 'package:movie_app/common/widgets/button/custom_icon_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthServiceProvider>();

    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ProfileArea(
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
                      children: [
                        AvatarWidget(
                          size: 60,
                          avatar: authProvider.account?.avatar,
                          userName: authProvider.account?.username,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              authProvider.account!.username,
                              style: AppTextStyle.h4SemiBold.copyWith(
                                color: AppColor.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              authProvider.account!.iso31661,
                              style: AppTextStyle.h6Medium.copyWith(
                                color: AppColor.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CustomIconButton(
                      icon: Icons.logout,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => LogoutDialog(
                            onLogOutPressed: () {
                              authProvider.logout();
                              context.goNamed('signup');
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ProfileArea(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Account',
                      style: AppTextStyle.h3SemiBold.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ProfileOptionItem(
                      leadingIcon: Icons.person,
                      title: 'Member',
                      tralingIcon: Icons.chevron_right,
                    ),
                    const SizedBox(height: 15),
                    ProfileOptionItem(
                      leadingIcon: Icons.lock,
                      title: 'Change Password',
                      tralingIcon: Icons.chevron_right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ProfileArea(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'General',
                      style: AppTextStyle.h3SemiBold.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ProfileOptionItem(
                      leadingIcon: Icons.notifications,
                      title: 'Notification',
                      tralingIcon: Icons.chevron_right,
                    ),
                    const SizedBox(height: 15),
                    ProfileOptionItem(
                      leadingIcon: Icons.language,
                      title: 'Language',
                      tralingIcon: Icons.chevron_right,
                    ),
                    const SizedBox(height: 15),
                    ProfileOptionItem(
                      leadingIcon: Icons.flag,
                      title: 'Country',
                      tralingIcon: Icons.chevron_right,
                    ),
                    const SizedBox(height: 15),
                    ProfileOptionItem(
                      leadingIcon: Icons.delete,
                      title: 'Clear Cache',
                      tralingIcon: Icons.chevron_right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ProfileArea(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'More',
                      style: AppTextStyle.h3SemiBold.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ProfileOptionItem(
                      leadingIcon: Icons.shield,
                      title: 'Legal and Policies',
                      tralingIcon: Icons.chevron_right,
                    ),
                    const SizedBox(height: 15),
                    ProfileOptionItem(
                      leadingIcon: Icons.help,
                      title: 'Help & Feedback',
                      tralingIcon: Icons.chevron_right,
                    ),
                    const SizedBox(height: 15),
                    ProfileOptionItem(
                      leadingIcon: Icons.info,
                      title: 'About Us',
                      tralingIcon: Icons.chevron_right,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
