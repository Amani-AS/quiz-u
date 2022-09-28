import 'package:flutter/cupertino.dart';

import 'package:quiz_u/data/apis/api_preparing/apiresult.dart';

import 'package:quiz_u/data/apis/questions_api.dart';
import 'package:quiz_u/data/apis/userscore_api.dart';

import 'package:quiz_u/data/models/questions/question_model.dart';

import 'package:quiz_u/rout/rout_names_constant.dart';

import 'package:quiz_u/database_helpers.dart';

enum QuestionState { initial, loading, loaded, error }

class QuestionsProvider with ChangeNotifier {
  QuestionState state = QuestionState.initial;

  List<Question>? questions = [];
  List<UserScore>? scores = [];

  APIResult result = APIResult();
  String? errorMessage;
  int index = 0;
  int score = 0;
  int questionNo = 0;
  DateTime time = DateTime.now();
  String? scoreTime;
  bool isSkipped = false;

  setIsSkipped(isSkip) {
    isSkipped = isSkip;
    notifyListeners();
  }

  setScoreTime(time) {
    scoreTime = time;
    notifyListeners();
  }

  read() async {
    DatabaseHelper helper = DatabaseHelper.instance;

    List<UserScore>? scores = await helper.queryAllUserScore();
    if (scores!.isNotEmpty) {
      this.scores = scores;
    } else {

    }
  }

  saveScore() async {
    UserScore sco = UserScore();
    sco.score = score.toString();
    sco.time = scoreTime;


  }

  getQuestions() async {
    await QuestionsApi.questions();

    result = QuestionsApi.result1;
    questions = result.data;
    if (!result.hasError) {
      questions = result.data;

      setState(QuestionState.loaded);
      notifyListeners();
    } else {
      errorMessage = result.message;
      setState(QuestionState.error);
      notifyListeners();
    }
  }

  setScore() async {
    await UserScoreApi.score(score);

    result = UserScoreApi.result1;

    if (!result.hasError) {
      setState(QuestionState.loaded);
      notifyListeners();
    } else {
      errorMessage = result.message;
      setState(QuestionState.error);
      notifyListeners();
    }
  }

  onTapAnswer(option, context) {
    if (questions![index].correct == option) {
      if (index < questions!.length) {
        ++index;
        ++questionNo;
        score = score + 10;
        scoreTime =
            "${time.hour}:${time.minute}   ${time.day}/${time.month}/${time.year}";
        notifyListeners();
      } else {
        scoreTime =
            "${time.hour}:${time.minute}   ${time.day}/${time.month}/${time.year}";
        Navigator.pushReplacementNamed(context, getScore);
        setIsSkipped(false);
        index = 0;
        notifyListeners();
      }
    } else {
      index = 0;
      score = 0;
      Navigator.pushReplacementNamed(context, fail);
      setIsSkipped(false);
    }
  }
  setIndex(){
    ++index;
    notifyListeners();
  }

  resetIndex() {
    index = 0;
    notifyListeners();
  }
  restQuestionNo() {
    questionNo = 0;
    notifyListeners();
  }
  resetScore() {
    score = 0;
    notifyListeners();
  }

  setState(state) {
    this.state = state;
    notifyListeners();
  }
}
