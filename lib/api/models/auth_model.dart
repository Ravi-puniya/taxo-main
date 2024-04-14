// To parse this JSON data, do
//
//     final auth = authFromJson(jsonString);

import 'dart:convert';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
  Auth({
    this.success,
    this.name,
    this.email,
    this.seriedefault,
    this.token,
    this.ruc,
    this.logo,
  });

  bool? success;
  String? name;
  String? email;
  dynamic seriedefault;
  String? token;
  String? ruc;
  String? logo;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        success: json["success"],
        name: json["name"],
        email: json["email"],
        seriedefault: json["seriedefault"],
        token: json["token"],
        ruc: json["ruc"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "name": name,
        "email": email,
        "seriedefault": seriedefault,
        "token": token,
        "ruc": ruc,
        "logo": logo,
      };
}
