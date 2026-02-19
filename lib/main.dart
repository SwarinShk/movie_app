import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_detail_provider.dart';
import 'package:movie_app/features/movie/presentation/providers/movie_provider.dart';
import 'package:movie_app/features/search/presentation/providers/search_movie_provider.dart';
import 'package:movie_app/core/routes/router.dart';
import 'package:movie_app/features/search/presentation/providers/search_person_provider.dart';
import 'package:movie_app/features/search/presentation/providers/search_tv_provider.dart';
import 'package:movie_app/features/tv/presentation/providers/tv_provider.dart';
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

        ChangeNotifierProvider(create: (_) => SearchMovieProvider()),
        ChangeNotifierProvider(create: (_) => SearchTvProvider()),
        ChangeNotifierProvider(create: (_) => SearchPersonProvider()),
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
