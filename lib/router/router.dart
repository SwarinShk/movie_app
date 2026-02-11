import 'package:go_router/go_router.dart';
import 'package:movie_app/features/v1/login/login_screen.dart';
import 'package:movie_app/features/v1/onboarding/onboarding_screen.dart';
import 'package:movie_app/features/v1/signup/signup_screen.dart';
import 'package:movie_app/features/v1/splash/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: 'onboarding',
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
  ],
);
