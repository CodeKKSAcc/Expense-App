import 'dart:async';

import 'package:expense_app/data/helper/db_helper.dart';
import 'package:expense_app/domain/constants/app_routes.dart';
import 'package:expense_app/user_interface/pages/add_expense/expense_bloc/expense_bloc.dart';
import 'package:expense_app/user_interface/pages/on_boarding/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context)=> UserBloc(dbHelper: DBHelper.onlyInstance())),
      BlocProvider(create: (context) => ExpenseBloc(dbHelper: DBHelper.onlyInstance()))
    ], child: MyApp())
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      initialRoute: AppRoutes.splashPage,
      routes: AppRoutes.myRoutes,
    );
  }
}
