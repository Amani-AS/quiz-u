import 'package:flutter/material.dart';

class PagePattern extends StatelessWidget {
  final String? image;
  final String? title;

  const PagePattern({
    Key? key,
    this.image,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.15,
            ),
            Image.asset(
              image!,
              height: height / 3,
              width: width * 08,
            ),
            SizedBox(
              height: height * 0.1,
            ),
            SizedBox(
              height: height * 0.2,
              child: Column(
                children: [
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Cairo",
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
