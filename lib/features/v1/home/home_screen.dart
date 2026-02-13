import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/app_textstyle.dart';
import 'package:movie_app/providers/auth_provider.dart';
import 'package:movie_app/shared/appbar/home_appbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: HomeAppBar(
        userName: authProvider.account!.username,
        subtitle: 'Let\'s stream your favorite movie',
        onFavoriteTap: () {
          context.read<AuthProvider>().logout();
          context.goNamed('signup');
        },
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 20),
              Text(
                "Trending Now",
                style: AppTextStyle.h4SemiBold.copyWith(color: AppColor.white),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 180,
                child: Center(
                  child: Text(
                    "Movie List Here",
                    style: AppTextStyle.h4SemiBold.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
