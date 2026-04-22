import 'dart:async';

import 'package:expense_app/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, AppRoutes.loginPage),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 72,
                  width: 72,
                  child: Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(36)
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 51,
                        height: 51,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                Text("Expenso", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(TextSpan(
                  text: "Powered by ",
                  style: TextStyle(fontSize: 15, color: Colors.black54, ),
                  children: [
                    TextSpan(text: "Accurate-Info", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black))
                  ]
                )),
                /*Container(height: 1.8, width: 240, margin: EdgeInsets.symmetric(vertical: 3), color: Colors.black54,),*/
                // Or use Divider() to get a divider line in between the components
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 90),
                  child: Divider(height: 6, thickness: 1.5, color: Colors.black54,),
                ),
                Text("Version 1.0.0", style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 3),),
                SizedBox(height: 24,)
              ],
            ),
          )
        ],
      ),
    );
  }
}












/*
import 'dart:async';

import 'package:expense_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login_page.dart';

class MySplashPage extends StatefulWidget {

  @override
  State<MySplashPage> createState() => _MySplashPageState();
}


class _MySplashPageState extends State<MySplashPage> {

  String name = "";

  @override
  void initState() {
    super.initState();
    getPref();
    Timer(Duration(seconds: 3), () async{
      SharedPreferences myPref = await SharedPreferences.getInstance();
      bool logedIn = myPref.getBool("login") ?? false;

      Widget NavigatePage = LoginPage();

      if(logedIn){
        NavigatePage = HomePage();
      }
      
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=> NavigatePage));
    },);
  }

  Future<void> getPref() async{
    SharedPreferences myPref = await SharedPreferences.getInstance();
    name = myPref.getString("name") ?? "Unknown";
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Welcome $name", style: TextStyle(fontSize: 36),),
      ),
    );
  }
}
*/
