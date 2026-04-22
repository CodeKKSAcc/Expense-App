import 'package:flutter/material.dart';

class AppRoundedButton extends StatelessWidget {
  double buttonWidth;
  double buttonHeight;
  String title;
  Color? bgColor;
  Color? fgColor;
  void Function() onTap;

  AppRoundedButton({
    this.buttonWidth = double.infinity,
    this.buttonHeight = 51,
    required this.title,
    this.bgColor,
    this.fgColor,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? Colors.blueAccent,
          foregroundColor: fgColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
