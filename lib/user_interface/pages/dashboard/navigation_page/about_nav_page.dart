import 'package:expense_app/domain/constants/app_constants.dart';
import 'package:expense_app/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutNavPage extends StatelessWidget {
  const AboutNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () async{
            SharedPreferences myPref = await SharedPreferences.getInstance();
            myPref.remove(AppConstants.pref_user_key);
            Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
          },
          child: Text(
            "Logout",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
