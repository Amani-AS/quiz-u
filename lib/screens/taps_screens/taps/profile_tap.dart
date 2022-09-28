import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/data/providers/provider_list/providers_export.dart';

import 'package:quiz_u/ui/widgets/Texts.dart';

import 'package:quiz_u/data/models/user/user_model.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TapsProvider provider = Provider.of<TapsProvider>(context);
    QuestionsProvider questionsProvider =
        Provider.of<QuestionsProvider>(context);
    double height = MediaQuery.of(context).size.height;

    return Container(
            height: height*7,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: FutureBuilder<User>(
              future: provider.getInfo(),
              builder: (context, snapShot) {
                questionsProvider.read();

                questionsProvider.scores!
                    .sort((b, a) => a.score!.compareTo(b.score!));
                if (snapShot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Text(
                          'My name:   ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                              fontWeight: FontWeight.w700),
                        ),
                        Texts(text: snapShot.data?.name)
                      ]),
                      Row(children: [
                        const Text(
                          'My phone:   ',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                              fontWeight: FontWeight.w700),
                        ),
                        Texts(text: snapShot.data?.mobile)
                      ]),

                            const Text(
                              'My score:  ',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w700),
                            ),
                      questionsProvider.scores!.isEmpty ||
                          questionsProvider.scores == null
                          ? const SizedBox()
                          :

                      SizedBox(
                        height: height*0.4,
                        child: ListView.separated(
                          itemCount: questionsProvider.scores!.length,
                          itemBuilder: (context,index)=>
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Texts(
                                      text:
                                      "${questionsProvider.scores![index].time}"),
                                  Texts(
                                    text:
                                    "${questionsProvider.scores![index].score}",
                                  )
                                ],
                              ), separatorBuilder: (BuildContext context, int index) =>const SizedBox(height: 15,),),
                      )


                    ],
                  );
                } else if (snapShot.hasError) {
                  return Center(
                    child: Text("${snapShot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              },
            ));
  }
}
