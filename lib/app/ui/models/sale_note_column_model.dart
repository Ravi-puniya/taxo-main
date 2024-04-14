import 'dart:convert';

SaleNoteColumnModel saleNoteColumnModelFromJson(String str) {
  return SaleNoteColumnModel.fromJson(json.decode(str));
}

String saleNoteColumnModelToJson(SaleNoteColumnModel data) {
  return json.encode(data.toJson());
}

class SaleNoteColumnModel {
  SaleNoteColumnModel({
    required this.id,
    required this.description,
  });

  String id;
  String description;

  factory SaleNoteColumnModel.fromJson(Map<String, dynamic> json) {
    return SaleNoteColumnModel(
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
