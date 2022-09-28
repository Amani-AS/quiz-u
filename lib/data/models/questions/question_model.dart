class Question {
  String? question;
  String? a;
  String? b;
  String? c;
  String? d;
  String? correct;

  Question({this.correct, this.question, this.a, this.b, this.c, this.d});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json["Question"],
      a: json["a"],
      b: json["b"],
      c: json["c"],
      d: json["d"],
      correct: json["correct"],
    );
  }
}
