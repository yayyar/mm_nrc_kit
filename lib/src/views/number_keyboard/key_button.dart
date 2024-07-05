import 'package:flutter/material.dart';

class KeyButton extends StatelessWidget {
  const KeyButton(BuildContext context, this.keyNumber,
      {super.key,
      this.backgroundColor = Colors.white,
      this.elevation = 1,
      this.fontWeight = FontWeight.normal,
      this.fontSize = 21,
      required this.orientation,
      this.overlayColor,
      required this.onKeyPressed});

  final String keyNumber;
  final Color backgroundColor;
  final double elevation;
  final FontWeight fontWeight;
  final double fontSize;
  final Orientation orientation;
  final Color? overlayColor;
  final Function(String) onKeyPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: orientation == Orientation.landscape
          ? MediaQuery.of(context).size.width / 3.6
          : MediaQuery.of(context).size.width / 3.2,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          surfaceTintColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10),
          ),
          overlayColor: MaterialStateProperty.all(overlayColor),
        ),
        onPressed: () => onKeyPressed(keyNumber),
        child: Text(
          keyNumber,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
