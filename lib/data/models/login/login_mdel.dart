class LogIn {
  bool? success;
 String? userStatus;
  String? message;
  String? token;

  LogIn({ this.message, this.success,this.token,this.userStatus});

  factory LogIn.fromJson(Map<String, dynamic> json) {
    return LogIn(

        message: json["message"],
        success: json["success"],
        userStatus: json["user_status"],
        token: json["token"]
    );
  }}