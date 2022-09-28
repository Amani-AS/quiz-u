class DynamicResponse {
  bool? success;

  String? message;

  DynamicResponse({this.message, this.success});

  factory DynamicResponse.fromJson(Map<String, dynamic> json) {
    return DynamicResponse(
      success: json["success"],
      message: json["message"],
    );
  }
}
