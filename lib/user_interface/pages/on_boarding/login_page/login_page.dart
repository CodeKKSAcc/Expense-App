import 'package:expense_app/domain/constants/app_routes.dart';
import 'package:expense_app/domain/utility/ui_helper.dart';
import 'package:expense_app/user_interface/custom_widgets/app_rounded_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  bool isPasswordVisible = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi, Welcome back !", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              SizedBox(height: 21,),
              TextField(
                controller: emailControl,
                decoration: myIpDecoration(
                    myHintText: "Enter your email here...",
                    myLabelText: "Email",
                ),),
              SizedBox(height: 15,),
              StatefulBuilder(
                builder: (context, mySetState) {
                  return TextField(
                    controller: passwordControl,
                    obscureText: ! isPasswordVisible,
                    decoration: myIpDecoration(
                        myHintText: "Enter your password here...",
                        myLabelText: "Password",
                        isPasswordField: true,
                        isPasswordVisible: isPasswordVisible,
                        onTap: (){
                          isPasswordVisible = ! isPasswordVisible;
                          mySetState((){});
                        }
                    )
                  );
                }
              ),
              SizedBox(height: 15,),
              AppRoundedButton(
                  title: "Login",
                  onTap: (){}),
              SizedBox(height: 6,),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.signupPage);
                  },
                  child: Text.rich(TextSpan(text: "Don't have an account? ", style: TextStyle(fontSize: 15, color: Colors.black54),
                      children: [TextSpan(text: "Create now", style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold,
                        color: Colors.blueAccent
                      )),]),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



/*
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
*/
