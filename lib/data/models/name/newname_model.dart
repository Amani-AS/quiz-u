class NewName {
  bool? success;
  String? message;
  String? name;
  String? mobile;

  NewName({this.message, this.success, this.name, this.mobile});

  factory NewName.fromJson(Map<String, dynamic> json) {
    return NewName(
        message: json["message"],
        success: json["success"],
        name: json["name"],
        mobile: json["mobile"]);
  }
}
