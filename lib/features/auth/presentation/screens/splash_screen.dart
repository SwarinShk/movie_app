import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/core/constants/storage_constants.dart';
import 'package:movie_app/features/auth/presentation/providers/auth_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNavigation();
    });
  }

  Future<void> _checkNavigation() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool(StorageConstants.firstTime) ?? true;

    if (!mounted) return;

    final authProvider = context.read<AuthServiceProvider>();

    // WAIT until provider finishes loading + initialization
    while (!authProvider.isInitialized) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (!mounted) return;

    if (isFirstTime) {
      context.go('/onboarding');
    } else if (authProvider.isLoggedIn) {
      context.go('/home'); // Go to home if valid session exists
    } else {
      context.go('/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(flex: 2),
              Image(
                image: AssetImage('assets/logos/app_logo.png'),
                height: 125,
                width: 125,
              ),
              Spacer(flex: 2),
              CircularProgressIndicator(color: AppColor.white),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
