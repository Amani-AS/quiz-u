import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/data/providers/provider_list/providers_export.dart';

import 'package:quiz_u/ui/widgets/Texts.dart';

import 'package:quiz_u/data/models/top_scors/score_model.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  late AudioPlayer player;

  play() async {
    player = AudioPlayer();

    await player.play(AssetSource("audio/success.mp3"));
  }

  @override
  void initState() {
    play();

    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.0, 1.0)));
    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TapsProvider provider = Provider.of<TapsProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                      child: Transform.scale(
                          alignment: Alignment.bottomCenter,
                          scale: animation.value,
                          child: Image(
                              width: width * 0.4,
                              image:
                                  const AssetImage("assets/images/top.png")))),
                ),
                Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: FutureBuilder<List<Score>>(
                          future: provider.getScores(),
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              return ListView.separated(
                                itemCount: snapShot.data!.length,
                                itemBuilder: (context, index) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Texts(text: snapShot.data![index].name),
                                    Texts(
                                        text: snapShot.data![index].score
                                            .toString()),
                                  ],
                                ),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height: height * 0.02,
                                ),
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
                          }),
                    ))
              ],
            )));
  }
}
