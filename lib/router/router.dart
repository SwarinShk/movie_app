import 'package:go_router/go_router.dart';
import 'package:movie_app/core/helpers/route_helper/router_transition.dart';
import 'package:movie_app/features/v1/dashboard/dashboard_shell.dart';
import 'package:movie_app/features/v1/movies/movie_detail_screen.dart';
import 'package:movie_app/features/v1/home/home_screen.dart';
import 'package:movie_app/features/v1/movies/movie_list_screen.dart';
import 'package:movie_app/features/v1/search/search_screen.dart';
import 'package:movie_app/features/v1/download/download_screen.dart';
import 'package:movie_app/features/v1/profile/profile_screen.dart';
import 'package:movie_app/features/v1/login/login_screen.dart';
import 'package:movie_app/features/v1/signup/signup_screen.dart';
import 'package:movie_app/features/v1/onboarding/onboarding_screen.dart';
import 'package:movie_app/features/v1/splash/splash_screen.dart';
import 'package:movie_app/models/movie_category_model.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    // AUTH FLOW
    GoRoute(
      name: 'splash',
      path: '/splash',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SplashScreen(),
        transitionsBuilder: fadeTransition,
      ),
    ),
    GoRoute(
      name: 'onboarding',
      path: '/onboarding',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnboardingScreen(),
        transitionsBuilder: fadeTransition,
      ),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginScreen(),
        transitionsBuilder: slideTransition,
      ),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SignupScreen(),
        transitionsBuilder: slideTransition,
      ),
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
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const HomeScreen(),
                transitionsBuilder: fadeTransition,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const SearchScreen(),
                transitionsBuilder: fadeTransition,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/download',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const DownloadScreen(),
                transitionsBuilder: fadeTransition,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(),
                transitionsBuilder: fadeTransition,
              ),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: '/moviedetail/:id',
      pageBuilder: (context, state) {
        final movieId = int.parse(state.pathParameters['id']!);
        return CustomTransitionPage(
          key: state.pageKey,
          child: MovieDetailScreen(movieId: movieId),
          transitionsBuilder: slideTransition,
        );
      },
    ),
    GoRoute(
      path: '/movielist/:category',
      pageBuilder: (context, state) {
        final categoryParam = state.pathParameters['category']!;
        final category = MovieCategory.values.firstWhere(
          (e) => e.name == categoryParam,
        );

        return CustomTransitionPage(
          key: state.pageKey,
          child: MovieListScreen(category: category),
          transitionsBuilder: slideTransition,
        );
      },
    ),
  ],
);
