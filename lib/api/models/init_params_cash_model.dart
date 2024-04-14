import 'dart:convert';

InitParamsCashModel initParamsCashModelFromJson(String str) =>
    InitParamsCashModel.fromJson(json.decode(str));

String initParamsCashModelToJson(InitParamsCashModel data) =>
    json.encode(data.toJson());

class InitParamsCashModel {
  InitParamsCashModel({
    required this.users,
    required this.user,
  });

  List<User> users;
  User user;

  factory InitParamsCashModel.fromJson(Map<String, dynamic> json) =>
      InitParamsCashModel(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
