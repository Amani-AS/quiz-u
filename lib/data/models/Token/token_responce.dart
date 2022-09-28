import 'package:quiz_u/data/models/Token/token_mdele.dart';

class TokenResponse {
  Token? data;

  TokenResponse({this.data});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(data: Token.fromJson(json));
  }
}
