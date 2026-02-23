import 'package:go_router/go_router.dart';
import 'package:movie_app/core/routes/helper/router_transition.dart';
import 'package:movie_app/features/auth/presentation/screens/login_screen.dart';
import 'package:movie_app/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:movie_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:movie_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:movie_app/features/dashboard/presentation/screens/dashboard_shell.dart';
import 'package:movie_app/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:movie_app/features/tv/data/models/tv_category_model.dart';
import 'package:movie_app/features/tv/presentation/screens/tv_detail_screen.dart';
import 'package:movie_app/features/tv/presentation/screens/tv_list_screen.dart';
import 'package:movie_app/features/watchlist/presentation/screens/watchlist_screen.dart';
import 'package:movie_app/features/home/presentation/screens/home_screen.dart';
import 'package:movie_app/features/movie/presentation/screens/movie_detail_screen.dart';
import 'package:movie_app/features/movie/presentation/screens/movie_list_screen.dart';
import 'package:movie_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:movie_app/features/search/presentation/screens/search_screen.dart';
import 'package:movie_app/features/movie/data/models/movie_category_model.dart';

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
              path: '/watchlist',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const WatchlistScreen(),
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

    GoRoute(
      path: '/tvdetail/:id',
      pageBuilder: (context, state) {
        final tvId = int.parse(state.pathParameters['id']!);
        return CustomTransitionPage(
          key: state.pageKey,
          child: TvDetailScreen(tvId: tvId),
          transitionsBuilder: slideTransition,
        );
      },
    ),
    GoRoute(
      path: '/tvlist/:category',
      pageBuilder: (context, state) {
        final categoryParam = state.pathParameters['category']!;
        final category = TvCategory.values.firstWhere(
          (e) => e.name == categoryParam,
        );

        return CustomTransitionPage(
          key: state.pageKey,
          child: TvListScreen(category: category),
          transitionsBuilder: slideTransition,
        );
      },
    ),

    GoRoute(
      path: '/favorite',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const FavoriteScreen(),
        transitionsBuilder: slideTransition,
      ),
    ),
  ],
);
