

import 'package:expense_app/home_page.dart';
import 'package:expense_app/signup_page.dart';
import 'package:expense_app/splash_screen.dart';
import 'package:flutter/cupertino.dart';

import 'login_page.dart';

class AppRoutes {
  static String splashPage = "splash";
  static String loginPage = "login";
  static String signupPage = "signup";
  static String homePage = "home";
  static String introPage = "intro";

  static Map<String, WidgetBuilder> appRoutes = {
    splashPage : (context) => MySplashPage(),
    loginPage : (context) => LoginPage(),
    signupPage : (context) => SignupPage(),
    homePage : (context) => HomePage(),
  };
}