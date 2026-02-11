import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/router/router.dart';

void main() {
  runApp(const MainApp());
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
