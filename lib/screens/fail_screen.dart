import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/data/providers/provider_list/providers_export.dart';
import 'package:quiz_u/rout/rout_names_constant.dart';

import 'package:quiz_u/ui/widgets/Texts.dart';
import 'package:quiz_u/ui/widgets/buttons.dart';

class FailScreen extends StatelessWidget {
  const FailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    QuestionsProvider qProvider = Provider.of<QuestionsProvider>(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Positioned(
                top: height * 0.05,
                right: 25,
                child: IconButton(
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, mainScreen);

                  },
                )),
            Center(
              child: SizedBox(
                height: height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.mood_bad_outlined,
                      color: Colors.amber,
                      size: 120,
                    ),
                    const Texts(
                      text: "Wrong Answer ",
                      size: 30,
                    ),
                    Buttons(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, questions);
                          qProvider.setIsSkipped(false);

                        },
                        text: "Try Again")
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
