import 'package:quiz_u/data/models/Token/token_responce.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../data_constants.dart';
import 'api_preparing/api_response_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'api_preparing/apiresult.dart';

class TokenApi {
  static APIResult result1 = APIResult();

  static Future<void> token() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=  prefs.getString(AppConstants.keyAccessToken,)!;
    var url = Uri.parse("${AppConstants.baseUrl}/Token");

    http.Response response;
    dynamic jsonResponse;

    APIResult result = APIResult();

    TokenResponse tokenResponse;

    try {
      response = await http.get(url, headers: {
        "Authorization":token
      });

      if (response.statusCode == AppConstants.responseCodeSuccess) {
        jsonResponse = convert.jsonDecode(response.body);
        tokenResponse = TokenResponse.fromJson(jsonResponse);
        result.hasError = false;
        result.data = tokenResponse.data;


      } else {
        jsonResponse = convert.jsonDecode(response.body);
        tokenResponse = TokenResponse.fromJson(jsonResponse);

        result.hasError = tokenResponse.data!.success!;
        result.message=tokenResponse.data!.message;

      }
    } catch (ex) {
      result = APIResponseErrorHandler.parseError(ex);
    }

    result1 = result;
  }
}