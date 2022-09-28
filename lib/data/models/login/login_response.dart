import 'package:quiz_u/data/models/login/login_mdel.dart';

class LogInResponse {
  LogIn? data;

  LogInResponse({this.data});

  factory LogInResponse.fromJson(Map<String, dynamic> json) {
    return LogInResponse(data: LogIn.fromJson(json));
  }
}
