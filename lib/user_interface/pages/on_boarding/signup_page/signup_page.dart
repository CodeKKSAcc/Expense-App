

import 'package:expense_app/domain/utility/ui_helper.dart';
import 'package:expense_app/user_interface/custom_widgets/app_rounded_button.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi, Welcome to Expenso !", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            TextField(
              controller: nameController,
              decoration: myIpDecoration(
                  myHintText: "Enter your name here",
                  myLabelText: "Name"),
            ),
            SizedBox(height: 12,),
            TextField(
              controller: emailControl,
              decoration: myIpDecoration(
                  myHintText: "Enter your email here",
                  myLabelText: "Email"),
            ),
            SizedBox(height: 12,),
            TextField(
              controller: mobNoController,
              decoration: myIpDecoration(
                  myHintText: "Enter your mobile number here",
                  myLabelText: "Mobile Number"),
            ),
            SizedBox(height: 12,),
            StatefulBuilder(
              builder: (context, mySS) {
                return TextField(
                  controller: passwordController,
                  obscureText: ! isPasswordVisible,
                  decoration: myIpDecoration(
                      myHintText: "Enter your password here",
                      myLabelText: "Password",
                      isPasswordField: true,
                      isPasswordVisible: isPasswordVisible,
                      onTap: (){
                        isPasswordVisible = ! isPasswordVisible;
                        mySS((){});
                      }
                  ),
                );
              }
            ),
            SizedBox(height: 12,),
            StatefulBuilder(
              builder: (context, mySS) {
                return TextField(
                  controller: confirmPasswordController,
                  obscureText: ! isConfirmPasswordVisible,
                  decoration: myIpDecoration(
                      myHintText: "Re-enter your password...",
                      myLabelText: "Confirm Password",
                      isPasswordField: true,
                      isPasswordVisible: isConfirmPasswordVisible,
                      onTap: (){
                        isConfirmPasswordVisible = ! isConfirmPasswordVisible;
                        mySS((){});
                      }
                  ),
                );
              }
            ),
            SizedBox(height: 12,),
            AppRoundedButton(title: "SignUp", onTap: (){}),
            SizedBox(height: 6,),
            Center(
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text.rich(TextSpan(text: "Already have an account? ", style: TextStyle(fontSize: 15, color: Colors.black54),
                    children: [TextSpan(text: "Login now", style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold,
                        color: Colors.blueAccent
                    )),]),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
