import 'package:quiz_u/data/models/questions/question_model.dart';

class QuestionsResponse {
  List<Question>? data;

  QuestionsResponse({this.data});

  factory QuestionsResponse.fromJson(List<dynamic> json) {
    List<Question> questions = [];
    for (var question in json) {
      questions.add(Question.fromJson(question));
    }
    return QuestionsResponse(data: questions);
  }
}
