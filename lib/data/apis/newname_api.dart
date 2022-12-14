import 'package:http/http.dart' as http;

import 'package:quiz_u/data/models/name/newname_response.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import 'package:quiz_u/data/data_constants.dart';
import 'api_preparing/api_response_handler.dart';
import 'api_preparing/apiresult.dart';
class NewNameApi {
  static APIResult result1 = APIResult();

  static Future<void> name(name) async {
    var url = Uri.parse("${AppConstants.baseUrl}/Name");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token=  prefs.getString(AppConstants.keyAccessToken,);

    http.Response response;
    dynamic jsonResponse;

    APIResult result = APIResult();

    NameResponse nameResponse;

    try {
      response = await http.post(url,headers: {
      "Authorization":"$token"
      }
          ,body: {
        "name":name
      });
      print(response.body);
      if (response.statusCode == 201) {
        jsonResponse = convert.jsonDecode(response.body);
        nameResponse = NameResponse.fromJson(jsonResponse);
        result.hasError = false;
        result.data = nameResponse.data;


      } else {
        jsonResponse = convert.jsonDecode(response.body);
        nameResponse = NameResponse.fromJson(jsonResponse);

        result.hasError = nameResponse.data!.success!;
        result.message=nameResponse.data!.message;

      }
    } catch (ex) {
      result = APIResponseErrorHandler.parseError(ex);
    }

    result1 = result;
  }
}