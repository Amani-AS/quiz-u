
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:quiz_u/data/apis/api_preparing/apiresult.dart';

import 'package:quiz_u/data/data_constants.dart';
import 'package:quiz_u/data/models/dynamic_response.dart';


import 'package:quiz_u/data/models/login/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_preparing/api_response_handler.dart';


class LogInApi {
  static APIResult result1 = APIResult();

  static Future<void> logIn(otp,phone) async {
    var url = Uri.parse("${AppConstants.baseUrl}/Login");

    http.Response response;
    dynamic jsonResponse;



    LogInResponse logInResponse = LogInResponse();
    APIResult result = APIResult();

    try {
      response = await http.post(url, body: {
        "OTP": otp,
        "mobile": "0$phone"
      });

      if (response.statusCode == 201) {
        jsonResponse = convert.jsonDecode(response.body);
        logInResponse = LogInResponse.fromJson(jsonResponse);
        result.hasError = !logInResponse.data!.success!;
        result.data = logInResponse.data;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            AppConstants.keyAccessToken, logInResponse.data!.token!);

      } else {
        jsonResponse = convert.jsonDecode(response.body);
        DynamicResponse dynamicResponse = DynamicResponse.fromJson(
            jsonResponse);

        result.hasError = !dynamicResponse.success!;
        result.message = dynamicResponse.message;


      }
    } catch (ex) {
      result = APIResponseErrorHandler.parseError(ex);

    }

    result1=result;
    print(result1.data);
  }

}