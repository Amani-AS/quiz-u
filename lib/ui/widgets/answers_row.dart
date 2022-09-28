import 'package:flutter/material.dart';
import 'package:quiz_u/ui/widgets/buttons.dart';

class AnswerRow extends StatelessWidget {
  const AnswerRow(
      {Key? key,
      required this.onTap1,
      this.text1,
      this.text2,
      required this.onTap2})
      : super(key: key);
  final Function() onTap1;
  final Function() onTap2;
  final String? text1;
  final String? text2;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.95,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Buttons(
            onTap: onTap1,
            text: text1,
            w: width * 0.45,
            textColor: Colors.black,
          ),
          Buttons(
            onTap: onTap2,
            text: text2,
            w: width * 0.45,
            textColor: Colors.black,
          )
        ],
      ),
    );
  }
}
