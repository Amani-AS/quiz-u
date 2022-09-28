import 'dart:io';


import 'apiresult.dart';




class APIResponseErrorHandler {
  static APIResult parseError(ex) {
    APIResult result = APIResult();

    if (ex is FormatException) {
      result.hasError = true;

      result.message =  "Problem parsing data from the server";
    } else if (ex is SocketException) {
      result.hasError = true;
      result.message = "Can't connect to internet";
    } else {
      result.hasError = true;
      result.message=ex.toString();

    }

    return result;
  }
}
