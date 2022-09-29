import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quiz_u/data/providers/questions_provider.dart';

import 'package:quiz_u/rout/rout_names_constant.dart';
import 'package:quiz_u/ui/widgets/answers_row.dart';

import 'package:quiz_u/ui/widgets/buttons.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    QuestionsProvider questionsProvider =
        Provider.of<QuestionsProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: questionsProvider.questions == null ||
              questionsProvider.questions!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : Center(
              child: Container(
                height: height * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: CircularCountDownTimer(
                        duration: 120,
                        initialDuration: 0,
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 3,
                        ringColor: Colors.white,
                        fillColor: Colors.orange,
                        fillGradient: null,
                        backgroundColor: Colors.white,
                        backgroundGradient: null,
                        strokeWidth: 20.0,
                        onComplete: () {
                          if (questionsProvider.score > 0) {
                            Navigator.pushReplacementNamed(context, getScore);
                            questionsProvider.resetIndex();
                          } else {
                            Navigator.pushReplacementNamed(context, fail);
                            questionsProvider.resetIndex();
                            questionsProvider.resetScore();
                          }
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        questionsProvider
                            .questions![questionsProvider.index].question!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnswerRow(
                              text1: questionsProvider
                                  .questions![questionsProvider.index].a,
                              onTap1: () {
                                questionsProvider.onTapAnswer("a", context);
                              },
                              text2: questionsProvider
                                  .questions![questionsProvider.index].b,
                              onTap2: () {
                                questionsProvider.onTapAnswer("b", context);
                              }),
                          AnswerRow(
                              text1: questionsProvider
                                  .questions![questionsProvider.index].c,
                              onTap1: () {
                                questionsProvider.onTapAnswer("c", context);
                              },
                              text2: questionsProvider
                                  .questions![questionsProvider.index].d,
                              onTap2: () {
                                questionsProvider.onTapAnswer("d", context);
                              }),
                        ],
                      ),
                    ),
                    !questionsProvider.isSkipped
                        ? Buttons(
                            onTap: () {
                              questionsProvider.setIsSkipped(true);
                              questionsProvider.setIndex();
                            },
                            text: "Skip",
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
    );
  }
}
