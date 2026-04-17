

import 'dart:async';

import 'package:expense_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

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
