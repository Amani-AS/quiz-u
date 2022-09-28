import 'package:quiz_u/data/models/top_scors/score_model.dart';

class TopScoreResponse {
  List<Score>? data;

  TopScoreResponse({this.data});

  factory TopScoreResponse.fromJson(List<dynamic> json) {
    List<Score> scores = [];
    for (var score in json) {
      scores.add(Score.fromJson(score));
    }
    return TopScoreResponse(data: scores);
  }
}
