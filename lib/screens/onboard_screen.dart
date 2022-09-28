import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:quiz_u/data/providers/sharedprefrence.dart';
import 'package:quiz_u/rout/rout_names_constant.dart';

import 'package:quiz_u/ui/widgets/buttons.dart';
import 'package:quiz_u/ui/widgets/page_patren.dart';
import 'package:quiz_u/ui/widgets/slider_point.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final ValueNotifier<int> pageNo = ValueNotifier<int>(0);
  final PageController controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List info = [
      {
        "image": "assets/images/quiz-img.png",
        "title": "Test yor knowledge with multiple questions ",
      },
      {
        "image": "assets/images/time.png",
        "title": "Be fast as you can to get high score",
      },
      {
        "image": "assets/images/leadership.png",
        "title": "you can see the top 10 players",
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ValueListenableBuilder<int>(
                    valueListenable: pageNo,
                    builder: (context, value, child) => SizedBox(
                          height: height * 0.8,
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: controller,
                              onPageChanged: (page) {
                                pageIndex = page;
                                pageNo.value = pageIndex;
                              },
                              itemCount: info.length,
                              itemBuilder: (context, index) => PagePattern(
                                    image: info[index]["image"],
                                    title: info[index]["title"],
                                  )),
                        )),
                ValueListenableBuilder<int>(
                    valueListenable: pageNo,
                    builder: (context, value, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            value != info.length - 1
                                ? Buttons(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, logIn);
                                    },
                                    text: "Skip",
                                    w: width * 0.3,
                                  )
                                : const SizedBox(),
                            Buttons(
                              onTap: () {
                                if (value < info.length - 1) {
                                  pageNo.value = value + 1;
                                  controller.nextPage(
                                    duration: const Duration(microseconds: 10),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, logIn);
                                }
                              },
                              text: "Next",
                              w: width * 0.3,
                            ),
                          ],
                        ))
              ],
            ),
          )),
          Positioned(
            top: height * 0.53,
            child: ValueListenableBuilder<int>(
                valueListenable: pageNo,
                builder: (context, value, child) => Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < info.length; i++)
                            if (i == value)
                              const SliderPoint(isActive: true)
                            else
                              const SliderPoint(isActive: false),
                        ])),
          )
          // Positioned(child: child),
        ],
      ),
    );
  }
}
