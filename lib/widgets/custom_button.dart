import 'package:flutter/material.dart';
import 'package:izam_task/consts/colors.dart';


import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color backGroundColor;
  final double elevation;
  final double borderRadius;

  const CustomButton(this.child, this.onPressed,
      {Key? key,
      this.backGroundColor = const Color(ColorCode.primary),
      this.elevation = 1,
      this.borderRadius = 4.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backGroundColor,
        elevation: elevation,
      ),

      child: child,
    );
  }
}
