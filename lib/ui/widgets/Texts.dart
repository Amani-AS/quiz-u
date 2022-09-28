import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  const Texts({Key? key, this.text, this.size}) : super(key: key);
  final String? text;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white,
          fontSize: size ?? 20,
          fontWeight: FontWeight.w400),
    );
  }
}
