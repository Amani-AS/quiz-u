class Score {
  int? score;
  String? name;

  Score({this.name, this.score});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      name: json["name"],
      score: json["score"],
    );
  }
}
