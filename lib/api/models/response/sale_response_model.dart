import 'dart:convert';

SaleResponseModel saleResponseModelFromJson(String str) {
  return SaleResponseModel.fromJson(json.decode(str));
}

String saleResponseModelToJson(SaleResponseModel data) {
  return json.encode(data.toJson());
}

class SaleResponseModel {
  SaleResponseModel({
    required this.success,
    this.message,
    this.data,
  });

  bool success;
  String? message;
  SavedData? data;

  factory SaleResponseModel.fromJson(Map<String, dynamic> json) {
    return SaleResponseModel(
      success: json["success"],
      message: json["message"] == null ? null : json["message"],
      data: json["data"] == null ? null : SavedData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message == null ? null : message,
      "data": data == null ? null : data!.toJson(),
    };
  }
}

class SavedData {
  SavedData({
    required this.id,
    this.response,
  });

  int id;
  ResponseData? response;

  factory SavedData.fromJson(Map<String, dynamic> json) {
    return SavedData(
      id: json["id"],
      response: json["response"] == null
          ? null
          : ResponseData.fromJson(json["response"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "response": response == null ? null : response!.toJson(),
    };
  }
}

class ResponseData {
  ResponseData({
    this.id,
    this.sent,
    this.code,
    this.description,
    this.notes,
  });

  int? id;
  bool? sent;
  String? code;
  String? description;
  List<dynamic>? notes;

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      id: json["id"] == null ? null : json["id"],
      sent: json["sent"] == null ? null : json["sent"],
      code: json["code"] == null ? null : json["code"],
      description: json["description"] == null ? null : json["description"],
      notes: json["notes"] == null
          ? null
          : List<dynamic>.from(json["notes"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id == null ? null : id,
      "sent": sent == null ? null : sent,
      "code": code == null ? null : code,
      "description": description == null ? null : description,
      "notes": notes == null ? null : List<dynamic>.from(notes!.map((x) => x)),
    };
  }
}
