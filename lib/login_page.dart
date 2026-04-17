

import 'package:expense_app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: userNameControl,
              decoration: InputDecoration(
                labelText: "Username",
                hintText: "Enter username",
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.1, color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(21),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21),
                )
              ),
            ),
          ),
          SizedBox(height: 27,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: passwordControl,
              obscureText: true,
              obscuringCharacter: "~",
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter password",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.1, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                  )
              ),
            ),
          ),
          SizedBox(height: 24,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: () async{
                SharedPreferences myPref = await SharedPreferences.getInstance();
                myPref.setString("name", userNameControl.text);
                myPref.setString("password", passwordControl.text);
                myPref.setBool("login", true);
                Navigator.pushReplacementNamed(
                    context, AppRoutes.homePage);
              },
                  child: Icon(Icons.arrow_forward, size: 36, color: Colors.blueAccent,)),
              SizedBox(width: 9,)
            ],
          )
        ],
      ),
    );
  }
}
