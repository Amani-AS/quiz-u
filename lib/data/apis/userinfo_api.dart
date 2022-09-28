import 'package:quiz_u/data/apis/login_api.dart';
import 'package:quiz_u/data/models/dynamic_response.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:quiz_u/data/data_constants.dart';
import 'package:quiz_u/data/models/user/userinfo_responce.dart';
import 'api_preparing/api_response_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'api_preparing/apiresult.dart';

class UserInfoApi {
  static APIResult result1 = APIResult();

  static Future<void> user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(
      AppConstants.keyAccessToken,
    );
    print(token);
    var url = Uri.parse("${AppConstants.baseUrl}/UserInfo");

    http.Response response;
    dynamic jsonResponse;

    APIResult result = APIResult();

    UserResponse userResponse;

    try {
      response =
          await http.get(url, headers: {"Authorization":"$token"});
      print(response.body);
      if (response.statusCode == 200) {
        jsonResponse = convert.jsonDecode(response.body);
        userResponse = UserResponse.fromJson(jsonResponse);
        result.hasError = false;
        result.data = userResponse.data;

        print(jsonResponse);
      } else {
        jsonResponse = convert.jsonDecode(response.body);
        DynamicResponse dynamicResponse =
            DynamicResponse.fromJson(jsonResponse);

        result.hasError = !dynamicResponse.success!;
        result.message = dynamicResponse.message;
        print(jsonResponse);
      }
    } catch (ex) {
      result = APIResponseErrorHandler.parseError(ex);
    }

    result1 = result;
  }
}
