
import 'package:quiz_u/data/models/dynamic_response.dart';
import 'package:quiz_u/data/models/questions/questions_response.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'package:quiz_u/data/data_constants.dart';

import 'api_preparing/api_response_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'api_preparing/apiresult.dart';

class QuestionsApi {
  static APIResult result1 = APIResult();

  static Future<void> questions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token=  prefs.getString(AppConstants.keyAccessToken,)!;
    var url = Uri.parse("${AppConstants.baseUrl}/Questions");

    http.Response response;
    dynamic jsonResponse;

    APIResult result = APIResult();

    QuestionsResponse questionsResponse;

    try {
      response = await http.get(url, headers: {
        "Authorization":token
      });

      if (response.statusCode == AppConstants.responseCodeSuccess) {
        jsonResponse = convert.jsonDecode(response.body);
        questionsResponse = QuestionsResponse.fromJson(jsonResponse);
        result.hasError = false;
        result.data = questionsResponse.data;

        print(jsonResponse);
      } else {
        jsonResponse = convert.jsonDecode(response.body);
        DynamicResponse  dynamicResponse = DynamicResponse.fromJson(jsonResponse);

        result.hasError = dynamicResponse.success!;
        result.message=dynamicResponse.message;
        print(jsonResponse);
      }
    } catch (ex) {
      result = APIResponseErrorHandler.parseError(ex);
      print(ex);
    }

    result1 = result;
  }
}