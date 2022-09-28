import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/data/providers/provider_list/providers_export.dart';
import 'package:quiz_u/rout/rout_names_constant.dart';

import 'package:quiz_u/ui/widgets/Texts.dart';
import 'package:quiz_u/ui/widgets/buttons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    QuestionsProvider questionsProvider =
        Provider.of<QuestionsProvider>(context);
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        height: height * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Texts(
            text: "Ready to test your knowledge and challenge others?",
          ),
          Buttons(
            onTap: () async {
              await questionsProvider.getQuestions();

              if (questionsProvider.state == QuestionState.loaded) {
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, questions);
              }
              questionsProvider.setState(QuestionState.initial);
            },
            text: "Go",
          ),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
                text: "Answer as much questions correctly within ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: "2 ",
                    style: TextStyle(fontSize: 20, color: Colors.orange),
                  ),
                  TextSpan(text: "minutes")
                ]),
          )
        ]),
      ),
    );
  }
}
