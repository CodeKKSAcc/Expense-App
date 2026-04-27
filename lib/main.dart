import 'dart:async';

import 'package:expense_app/data/helper/db_helper.dart';
import 'package:expense_app/domain/constants/app_routes.dart';
import 'package:expense_app/user_interface/pages/on_boarding/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(BlocProvider(create: (context) => UserBloc(dbHelper: DBHelper.onlyInstance()), child: MyApp(),));
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    confirmLogedIn();
    Timer(Duration(seconds: 3), () => Navigator.pushNamed(context, AppRoutes.splashPage),);
  }

  Future<void> confirmLogedIn() async{
    SharedPreferences myPref = await SharedPreferences.getInstance();
    isLoggedIn = myPref.getBool("loggedIn") ?? false;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      initialRoute: isLoggedIn ? AppRoutes.homePage : AppRoutes.loginPage,
      routes: AppRoutes.myRoutes,
    );
  }
}