import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Quiz",
            style: TextStyle(
                color: Colors.white30,
                fontSize: 50,
                fontWeight: FontWeight.w900),
          ),
          Text(
            "u",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 55,
                fontWeight: FontWeight.w900),
          ),
          Icon(
            Icons.timer_outlined,
            color: Colors.white,
            size: 45,
          )
        ],
      ),
    );
  }
}
