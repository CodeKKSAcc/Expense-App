import 'package:expense_app/app_routes.dart';
import 'package:expense_app/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySplashPage(),
      initialRoute: AppRoutes.splashPage,
      routes: AppRoutes.appRoutes,
    );
  }
}

// 6674D3