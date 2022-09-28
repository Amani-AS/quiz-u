import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:quiz_u/data/apis/userinfo_api.dart';

import 'package:quiz_u/data/apis/api_preparing/apiresult.dart';
import 'package:quiz_u/data/models/top_scors/score_model.dart';

import 'package:quiz_u/data/apis/topscore_api.dart';

import 'package:quiz_u/data/models/user/user_model.dart';

class TapsProvider with ChangeNotifier {
  int page =0;

  setPage(page) {
    this.page = page;
    notifyListeners();
  }

  late AudioPlayer player;

  play() async {
    player = AudioPlayer();

    await player.play(AssetSource("audio/timer.mp3"));
  }

  APIResult result = APIResult();
  String? errorMessage;
  List<Score> scores = [];
  User? user;

  Future<User> getInfo() async {
    await UserInfoApi.user();

    result = UserInfoApi.result1;

    if (!result.hasError) {
      user = result.data;

      return user!;
    } else {
      errorMessage = result.message;
      throw Exception(errorMessage);
    }
  }

  Future<List<Score>> getScores() async {
    await TpoScoreApi.scores();

    result = TpoScoreApi.result1;

    if (!result.hasError) {
      List<Score> scors = [];
      for (var score in result.data) {
        scors.add(score);
      }
      scores = scors;

      return scores;
    } else {
      errorMessage = result.message;
      throw Exception(errorMessage);
    }
  }
}
