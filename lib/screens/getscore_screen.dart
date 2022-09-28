import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/data/providers/provider_list/providers_export.dart';
import 'package:quiz_u/data/providers/questions_provider.dart';
import 'package:quiz_u/rout/rout_names_constant.dart';

import 'package:quiz_u/ui/widgets/Texts.dart';
import 'package:quiz_u/ui/widgets/buttons.dart';
import 'package:share_plus/share_plus.dart';

class GetScoreScreen extends StatefulWidget {
  const GetScoreScreen({Key? key}) : super(key: key);

  @override
  State<GetScoreScreen> createState() => _GetScoreScreenState();
}

class _GetScoreScreenState extends State<GetScoreScreen> {
  @override
  Widget build(BuildContext context) {
    QuestionsProvider provider = Provider.of<QuestionsProvider>(context);

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
                  onPressed: () async {
                    await provider.setScore();
                    await provider.saveScore();

                    provider.setIsSkipped(false);
                    provider.resetIndex();
                    provider.resetScore();
                    provider.restQuestionNo();

                    if (provider.state == QuestionState.loaded) {
                      if (!mounted) return;
                      Navigator.pushReplacementNamed(context, mainScreen);
                    }
                  },
                )),
            Center(
              child: SizedBox(
                height: height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.star_sharp,
                      color: Colors.amber,
                      size: 120,
                    ),
                    Column(
                      children: [
                        const Texts(
                          text: "You have completed ",
                          size: 30,
                        ),
                        Text(
                          provider.questionNo.toString(),
                          style: const TextStyle(
                              fontSize: 35,
                              color: Colors.orange,
                              fontWeight: FontWeight.w700),
                        ),
                        const Texts(
                          text: "Correct answers !",
                          size: 30,
                        ),
                      ],
                    ),
                    Buttons(
                        onTap: () {
                          Share.share(
                              "I answer${provider.questionNo} correct answer ");
                        },
                        text: "Share")
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
