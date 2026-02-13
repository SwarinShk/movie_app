import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/constants/app_color.dart';
import 'package:movie_app/providers/auth_provider.dart';
import 'package:movie_app/router/router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
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
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.dark,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColor.black,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColor.dark,
        ),
      ),
    );
  }
}
