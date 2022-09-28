class User {
  String? name;

  String? mobile;

  User({this.name, this.mobile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json["name"], mobile: json["mobile"]);
  }
}
