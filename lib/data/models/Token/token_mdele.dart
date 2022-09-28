class Token {
  bool? success;

  String? message;

  Token({this.message, this.success});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(message: json["message"], success: json["success"]);
  }
}
