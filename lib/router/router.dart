import 'package:go_router/go_router.dart';
import 'package:movie_app/features/v1/dashboard/dashboard_shell.dart';
import 'package:movie_app/features/v1/home/home_screen.dart';
import 'package:movie_app/features/v1/search/search_screen.dart';
import 'package:movie_app/features/v1/download/download_screen.dart';
import 'package:movie_app/features/v1/profile/profile_screen.dart';
import 'package:movie_app/features/v1/login/login_screen.dart';
import 'package:movie_app/features/v1/signup/signup_screen.dart';
import 'package:movie_app/features/v1/onboarding/onboarding_screen.dart';
import 'package:movie_app/features/v1/splash/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    // AUTH FLOW
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

    // MAIN APP (TABS)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return DashboardShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/download',
              builder: (context, state) => const DownloadScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
