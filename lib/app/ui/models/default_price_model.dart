import 'dart:convert';

DefaultPriceModel defaultPriceModelFromJson(String str) {
  return DefaultPriceModel.fromJson(json.decode(str));
}

String defaultPriceModelToJson(DefaultPriceModel data) {
  return json.encode(data.toJson());
}

class DefaultPriceModel {
  DefaultPriceModel({
    required this.id,
    required this.description,
  });

  int id;
  String description;

  factory DefaultPriceModel.fromJson(Map<String, dynamic> json) {
    return DefaultPriceModel(
      id: json["id"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
    };
  }
}
