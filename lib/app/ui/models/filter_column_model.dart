import 'dart:convert';

FilterColumnModel filterColumnModelFromJson(String str) {
  return FilterColumnModel.fromJson(json.decode(str));
}

String filterColumnModelToJson(FilterColumnModel data) {
  return json.encode(data.toJson());
}

class FilterColumnModel {
  FilterColumnModel({
    required this.id,
    required this.description,
  });

  String id;
  String description;

  factory FilterColumnModel.fromJson(Map<String, dynamic> json) {
    return FilterColumnModel(
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
