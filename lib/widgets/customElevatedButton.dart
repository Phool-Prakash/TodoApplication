import 'package:flutter/material.dart';
import 'package:todo_aap/customExtension/customExtension.dart';
import 'package:todo_aap/theme/myColors.dart';
import 'package:todo_aap/theme/sizeStyle.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.textStyle,
      this.buttonStyle,
      this.borderRadius,
      this.textColor,
      this.buttonColor,
      this.borderColor,
      this.width,
      this.height,
      this.textSize,
      this.elevation,
      this.borderWidth,
      this.letterSpacing});

  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  final BorderRadius? borderRadius;
  final Color? textColor, buttonColor, borderColor;
  final double? width, height, textSize, elevation, borderWidth, letterSpacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 65.0,
      width: width ?? 250.0,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor ?? ColorTheme.buttonBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(112)),
              side: BorderSide(
                  color: borderColor ?? ColorTheme.buttonBlue,
                  width: borderWidth ?? .01),
              elevation: elevation ?? 0),
          onPressed: onPressed,
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: textStyle ??
                TextStyle(
                    letterSpacing: letterSpacing ?? .5,
                    fontSize: textSize ?? 12,
                    color: textColor ?? ColorTheme.whiteBold),
          )).padAll(8),
    );
  }
}
