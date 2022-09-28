import 'package:quiz_u/data/models/user/user_model.dart';

class UserResponse {
  User? data;

  UserResponse({this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(data: User.fromJson(json));
  }
}
