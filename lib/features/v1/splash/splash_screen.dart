import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/constants/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void init() async {
    await Future.delayed(Duration(seconds: 1));

    if (!mounted) return;
    context.pushReplacementNamed('onboarding');
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: .min,
            children: [
              Spacer(flex: 2),
              Image.asset('assets/logos/app_logo.png', height: 125, width: 125),
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
