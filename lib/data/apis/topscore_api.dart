import 'package:quiz_u/data/models/Token/token_responce.dart';
import 'package:quiz_u/data/models/dynamic_response.dart';
import 'package:quiz_u/data/models/top_scors/topScore_response.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../data_constants.dart';
import 'api_preparing/api_response_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'api_preparing/apiresult.dart';

class TpoScoreApi {
  static APIResult result1 = APIResult();

  static Future<void> scores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token=  prefs.getString(AppConstants.keyAccessToken,);

    var url = Uri.parse("${AppConstants.baseUrl}/TopScores");

    http.Response response;
    dynamic jsonResponse;

    APIResult result = APIResult();

   TopScoreResponse topScoreResponse;

    try {
      response = await http.get(url, headers: {
        "Authorization":"$token"
      });

      if (response.statusCode == 200) {
        jsonResponse = convert.jsonDecode(response.body);

        topScoreResponse = TopScoreResponse.fromJson(jsonResponse);
        result.hasError = false;
        result.data = topScoreResponse.data;


      } else {
        jsonResponse = convert.jsonDecode(response.body);
       DynamicResponse responses= DynamicResponse.fromJson(jsonResponse);

        result.hasError = true;
        result.message=responses.message;

      }
    } catch (ex) {
      result = APIResponseErrorHandler.parseError(ex);
    }

    result1 = result;
  }
}