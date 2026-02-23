import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:movie_app/features/favorite/presentation/providers/favorite_provider.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_detail_provider.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';
import 'package:movie_app/features/search/presentation/providers/search_movie_provider.dart';
import 'package:movie_app/core/routes/router.dart';
import 'package:movie_app/features/search/presentation/providers/search_person_provider.dart';
import 'package:movie_app/features/search/presentation/providers/search_tv_provider.dart';
import 'package:movie_app/features/tv/presentation/providers/tv_detail_provider.dart';
import 'package:movie_app/features/tv/presentation/providers/tv_provider.dart';
import 'package:movie_app/features/watchlist/presentation/providers/watchlist_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServiceProvider()),

        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => MovieDetailProvider()),

        ChangeNotifierProvider(create: (_) => TvProvider()),
        ChangeNotifierProvider(create: (_) => TvDetailProvider()),

        ChangeNotifierProvider(create: (_) => SearchMovieProvider()),
        ChangeNotifierProvider(create: (_) => SearchTvProvider()),
        ChangeNotifierProvider(create: (_) => SearchPersonProvider()),

        ChangeNotifierProxyProvider<AuthServiceProvider, WatchlistProvider>(
          create: (context) => WatchlistProvider(
            auth: Provider.of<AuthServiceProvider>(context, listen: false),
          ),
          update: (context, auth, previousWatchlist) {
            // This runs whenever AuthServiceProvider calls notifyListeners()
            final watchlist =
                previousWatchlist ?? WatchlistProvider(auth: auth);

            // If user just logged in, trigger initial fetch
            if (auth.sessionId != null &&
                watchlist.movieWatchlist == null &&
                watchlist.tvWatchlist == null &&
                !watchlist.isLoading) {
              watchlist.fetchAll(reset: true);
            }

            // If user logged out, clear the data
            if (auth.sessionId == null) {
              watchlist.clear();
            }

            return watchlist;
          },
        ),

        ChangeNotifierProxyProvider<AuthServiceProvider, FavoriteProvider>(
          create: (context) => FavoriteProvider(
            auth: Provider.of<AuthServiceProvider>(context, listen: false),
          ),
          update: (context, auth, previousFavorite) {
            // This runs whenever AuthServiceProvider calls notifyListeners()
            final favorite = previousFavorite ?? FavoriteProvider(auth: auth);

            // If user just logged in, trigger initial fetch
            if (auth.sessionId != null &&
                favorite.movieFavorite == null &&
                favorite.tvFavorite == null &&
                !favorite.isLoading) {
              favorite.fetchAll(reset: true);
            }

            // If user logged out, clear the data
            if (auth.sessionId == null) {
              favorite.clear();
            }

            return favorite;
          },
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'ClipIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: AppColor.dark,
        scaffoldBackgroundColor: AppColor.dark,
        appBarTheme: AppBarTheme(backgroundColor: AppColor.dark),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColor.dark,
        ),
      ),
    );
  }
}
