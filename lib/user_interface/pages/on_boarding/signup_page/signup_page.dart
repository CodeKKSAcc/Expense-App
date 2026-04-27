import 'package:expense_app/data/model/user_model.dart';
import 'package:expense_app/domain/constants/app_routes.dart';
import 'package:expense_app/domain/utility/ui_helper.dart';
import 'package:expense_app/user_interface/custom_widgets/app_rounded_button.dart';
import 'package:expense_app/user_interface/pages/on_boarding/bloc/user_bloc.dart';
import 'package:expense_app/user_interface/pages/on_boarding/bloc/user_event.dart';
import 'package:expense_app/user_interface/pages/on_boarding/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, Welcome to Expenso !",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (fieldValue) {
                  if (fieldValue == null || fieldValue.isEmpty) {
                    return "Please enter your name";
                  } else {
                    return null;
                  }
                },
                controller: nameController,
                decoration: myIpDecoration(
                  myHintText: "Enter your name here",
                  myLabelText: "Name",
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                validator: (fieldValue) {
                  RegExp emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if (fieldValue == null || fieldValue.isEmpty) {
                    return "Please enter your email";
                  } else if (!emailRegex.hasMatch(fieldValue)) {
                    return "Please enter a valid email";
                  } else {
                    return null;
                  }
                },
                controller: emailControl,
                decoration: myIpDecoration(
                  myHintText: "Enter your email here",
                  myLabelText: "Email",
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                validator: (fieldValue) {
                  if (fieldValue == null || fieldValue.isEmpty) {
                    return "Please enter your mobile number";
                  } else if (fieldValue.length != 10) {
                    return "Please enter a valid mobile number";
                  } else {
                    return null;
                  }
                },
                controller: mobNoController,
                decoration: myIpDecoration(
                  myHintText: "Enter your mobile number here",
                  myLabelText: "Mobile Number",
                ),
              ),
              SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, mySS) {
                  return TextFormField(
                    validator: (fieldValue) {
                      RegExp passRegx = RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                      );

                      if (fieldValue == null || fieldValue.isEmpty) {
                        return "Please enter your password";
                      } else if (!passRegx.hasMatch(fieldValue)) {
                        return "Password must be 8 char long with \nAt-least 1 uppercase,\n1 lowercase,\n1 number\nand 1 special character";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: myIpDecoration(
                      myHintText: "Enter your password here...",
                      myLabelText: "Password",
                      isPasswordField: true,
                      isPasswordVisible: isPasswordVisible,
                      onTap: () {
                        isPasswordVisible = !isPasswordVisible;
                        mySS(() {});
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, mySS) {
                  return TextFormField(
                    validator: (fieldValue) {
                      if (fieldValue == null || fieldValue.isEmpty) {
                        return "Please enter your password again...";
                      } else if (fieldValue != passwordController.text) {
                        return "Password doesn't match";
                      } else {
                        return null;
                      }
                    },
                    controller: confirmPasswordController,
                    obscureText: !isConfirmPasswordVisible,
                    decoration: myIpDecoration(
                      myHintText: "Re-enter your password...",
                      myLabelText: "Confirm Password",
                      isPasswordField: true,
                      isPasswordVisible: isConfirmPasswordVisible,
                      onTap: () {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        mySS(() {});
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserLoadingState) {
                    isLoading = true;
                  }
                  if (state is UserFailureState) {
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error : ${state.errorMsg}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  if (state is UserSuccessState) {
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("User created successfully"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
                  }
                },
                builder: (context, state) {
                  return AppRoundedButton(
                    isLoading: isLoading,
                    title: isLoading ? "Creating Account" : "SignUp",
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<UserBloc>().add(
                          UserSignUpEvent(
                            newUser: UserModel(
                              name: nameController.text,
                              email: emailControl.text,
                              mobNo: mobNoController.text,
                              password: passwordController.text,
                              budget: 0,
                              balance: 0,
                              created_at: DateTime.now().millisecondsSinceEpoch,
                            ),
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
                    Navigator.pop(context);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                      children: [
                        TextSpan(
                          text: "Login now",
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
    );
  }
}
