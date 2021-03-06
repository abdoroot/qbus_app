import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double textSize;
  final FontWeight fontWeight;
  final Color textColor;
  final TextAlign? textAlign;

  const CustomText(
      {Key? key,
      required this.text,
      required this.textSize,
      required this.fontWeight,
      required this.textColor,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
    );
  }
}
