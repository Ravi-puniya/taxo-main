import 'dart:convert';

ResponseClientErrorsModel responseClientErrorsModelFromJson(String str) =>
    ResponseClientErrorsModel.fromJson(json.decode(str));

String responseClientErrorsModelToJson(ResponseClientErrorsModel data) =>
    json.encode(data.toJson());

class ResponseClientErrorsModel {
  ResponseClientErrorsModel({
    required this.success,
    required this.message,
  });

  bool success;
  Message message;

  factory ResponseClientErrorsModel.fromJson(Map<String, dynamic> json) =>
      ResponseClientErrorsModel(
        success: json["success"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message.toJson(),
      };
}

class Message {
  Message({
    this.number,
    this.name,
  });

  List<String>? number;
  List<String>? name;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        number: json["number"] == null
            ? null
            : List<String>.from(json["number"].map((x) => x)),
        name: json["name"] == null
            ? null
            : List<String>.from(json["name"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "number":
            number == null ? null : List<dynamic>.from(number!.map((x) => x)),
        "name": name == null ? null : List<dynamic>.from(name!.map((x) => x)),
      };
}
