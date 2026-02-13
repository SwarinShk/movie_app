import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/storage_constants.dart';
import 'package:movie_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkNavigation();
  }

  Future<void> _checkNavigation() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool(StorageConstants.firstTime) ?? true;

    if (!mounted) return;
    final authProvider = context.read<AuthProvider>();
    await authProvider.sessionLoaded;

    if (!mounted) return;

    if (isFirstTime) {
      context.go('/onboarding');
      return;
    } else if (authProvider.isLoggedIn) {
      if (mounted) context.go('/home');
      return;
    } else {
      if (mounted) context.go('/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(flex: 2),
              Image.asset('assets/logos/app_logo.png', height: 125, width: 125),
              const Spacer(flex: 2),
              const CircularProgressIndicator(color: AppColor.white),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
