import 'package:quiz_u/data/models/name/newname_model.dart';

class NameResponse {
  NewName? data;

  NameResponse({this.data});

  factory NameResponse.fromJson(Map<String, dynamic> json) {
    return NameResponse(data: NewName.fromJson(json));
  }
}
