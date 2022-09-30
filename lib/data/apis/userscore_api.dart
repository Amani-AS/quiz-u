import 'package:http/http.dart' as http;
import 'package:quiz_u/data/models/dynamic_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:quiz_u/data/data_constants.dart';
import 'api_preparing/api_response_handler.dart';
import 'api_preparing/apiresult.dart';
class UserScoreApi {
  static APIResult result1 = APIResult();

  static Future<void> score(score) async {
    var url = Uri.parse("${AppConstants.baseUrl}/Score");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token=  prefs.getString(AppConstants.keyAccessToken,)!;
    http.Response response;
    dynamic jsonResponse;

    APIResult result = APIResult();

    DynamicResponse dynamicResponse;

    try {
      response = await http.post(url,headers: {
        "Authorization":token
      }
          ,body: {
            "score":score.toString()
          });

      if (response.statusCode == 201) {
        jsonResponse = convert.jsonDecode(response.body);
        dynamicResponse = DynamicResponse.fromJson(jsonResponse);
        result.hasError = false;
        result.data = dynamicResponse.message;


      } else {
        jsonResponse = convert.jsonDecode(response.body);
        dynamicResponse = DynamicResponse.fromJson(jsonResponse);

        result.hasError = dynamicResponse.success!;
        result.message=dynamicResponse.message;

      }
    } catch (ex) {
      result = APIResponseErrorHandler.parseError(ex);

    }

    result1 = result;
  }
}