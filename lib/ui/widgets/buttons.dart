import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons(
      {Key? key, required this.onTap, this.text, this.w, this.textColor})
      : super(key: key);
  final Function() onTap;
  final String? text;
  final double? w;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: w ?? width * 0.3,
        height: height * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: Colors.white),
        child: Center(
          child: Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor ?? Colors.black45,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
