import 'package:expense_app/domain/constants/app_routes.dart';
import 'package:expense_app/domain/utility/ui_helper.dart';
import 'package:expense_app/user_interface/custom_widgets/app_rounded_button.dart';
import 'package:expense_app/user_interface/pages/on_boarding/bloc/user_event.dart';
import 'package:expense_app/user_interface/pages/on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/user_bloc.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  bool isPasswordVisible = false;

  bool isLoading = false;
  bool loggedIn = true;

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, Welcome back !",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 21),
                TextFormField(
                  validator: (value) {
                    RegExp emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (value == null || value.isEmpty) {
                      return "Please enter your email !!!";
                    } else if (!emailRegex.hasMatch(value)) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  controller: emailControl,
                  decoration: myIpDecoration(
                    myHintText: "Enter your email here...",
                    myLabelText: "Email",
                  ),
                ),
                SizedBox(height: 15),
                StatefulBuilder(
                  builder: (context, mySetState) {
                    return TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        } else {
                          return null;
                        }
                      },
                      controller: passwordControl,
                      obscureText: !isPasswordVisible,
                      decoration: myIpDecoration(
                        myHintText: "Enter your password here...",
                        myLabelText: "Password",
                        isPasswordField: true,
                        isPasswordVisible: isPasswordVisible,
                        onTap: () {
                          isPasswordVisible = !isPasswordVisible;
                          mySetState(() {});
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 15),
                BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserLoadingState) {
                      isLoading = true;
                    }
                    if (state is UserFailureState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error : ${state.errorMsg} !!!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    if (state is UserSuccessState) {
                      isLoading = false;
                      confirmLogin(loggedIn);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("User authenticated successfully !!!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushNamed(context, AppRoutes.homePage);
                    }
                  },
                  builder: (context, state) {
                    return AppRoundedButton(
                      isLoading: isLoading,
                      title: isLoading ? "Authenticating User..." : "Login",
                      onTap: () {
                        if (loginKey.currentState!.validate()) {
                          context.read<UserBloc>().add(
                            UserLoginEvent(
                              email: emailControl.text,
                              password: passwordControl.text,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 6),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.signupPage);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                        children: [
                          TextSpan(
                            text: "Create now",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> confirmLogin(bool isLoggedIn) async{
    SharedPreferences getPref = await SharedPreferences.getInstance();
    return await getPref.setBool("loggedIn", isLoggedIn);
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
