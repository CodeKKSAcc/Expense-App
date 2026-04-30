import 'package:flutter/material.dart';

InputDecoration myIpDecoration({
  required String myHintText,
  required String myLabelText,
  bool isPasswordField = false,
  bool isPasswordVisible = false,
  VoidCallback? onTap, // or   void Function() onTap;
}) {
  return InputDecoration(
    hintText: myHintText,
    labelText: myLabelText,
    suffixIcon: isPasswordField
        ? IconButton(
            onPressed: onTap,
            icon: isPasswordVisible
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
          )
        : null,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.pinkAccent, width: 2.4),
    ),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
  );
}
