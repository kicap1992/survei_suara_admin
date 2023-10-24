import 'package:flutter/material.dart';

import '../../app/themes/app_colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.text,
    this.theBackgroundColor = mainColor,
    this.textColor = backgroundColor,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color theBackgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
        ),
      ),
    );
  }
}
