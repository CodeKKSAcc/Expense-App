import 'package:flutter/material.dart';

class AppRoundedButton extends StatelessWidget {
  double buttonWidth;
  double buttonHeight;
  String title;
  Color? bgColor;
  Color? fgColor;
  void Function() onTap;
  bool isLoading;

  AppRoundedButton({
    this.buttonWidth = double.infinity,
    this.buttonHeight = 51,
    required this.title,
    this.bgColor,
    this.fgColor,
    required this.onTap,
    this.isLoading = false
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
        child: isLoading ? Padding(
          padding: const EdgeInsets.all(4.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(width: 12,),
              Text(title)
            ],
          ),
        ) : Text(title),
      ),
    );
  }
}
