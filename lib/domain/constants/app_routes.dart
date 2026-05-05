import 'package:expense_app/user_interface/pages/add_expense/add_expense.dart';
import 'package:expense_app/user_interface/pages/dashboard/dashboard_page_ui.dart';
import 'package:expense_app/intro_page.dart';
import 'package:expense_app/user_interface/pages/dashboard/navigation_page/home_nav_page.dart';
import 'package:expense_app/user_interface/pages/on_boarding/signup_page/signup_page.dart';
import 'package:expense_app/user_interface/pages/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import '../../user_interface/pages/on_boarding/login_page/login_page.dart';

class AppRoutes {
  static String splashPage = "/";
  static String loginPage = "/login";
  static String signupPage = "/signup";
  static String homePage = "home";
  static String dashboardPage = "dashboard";
  static String introPage = "intro";
  static String addExpensePage = "expense";

  static Map<String, WidgetBuilder> myRoutes = {
    splashPage : (context) => SplashPage(),
    loginPage : (context) => LoginPage(),
    signupPage : (context) => SignupPage(),
    homePage : (context) => HomeNavPage(),
    dashboardPage : (context) => DashboardPage(),
    introPage : (context) => IntroPage(),
    addExpensePage : (context) => AddExpensePage(toUpdate: false, index: 0,)
  };
}