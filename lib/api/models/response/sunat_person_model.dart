import 'dart:convert';

SunatPersonModel sunatPersonModelFromJson(String str) =>
    SunatPersonModel.fromJson(json.decode(str));

String sunatPersonModelToJson(SunatPersonModel data) =>
    json.encode(data.toJson());

class SunatPersonModel {
  SunatPersonModel({
    required this.success,
    this.data,
    this.message,
  });

  bool success;
  DataSunat? data;
  String? message;

  factory SunatPersonModel.fromJson(Map<String, dynamic> json) =>
      SunatPersonModel(
        success: json["success"],
        data: json["data"] == null ? null : DataSunat.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? null : data!.toJson(),
        "message": message == null ? null : message,
      };
}

class DataSunat {
  DataSunat({
    required this.name,
    this.tradeName,
    this.locationId, // Cambio aquí
    this.address,
    this.departmentId,
    this.provinceId,
    this.districtId,
    this.condition,
    this.state,
  });

  String name;
  String? tradeName;
  List<dynamic>? locationId; // Modificación aquí
  String? address;
  String? departmentId;
  String? provinceId;
  String? districtId;
  String? condition;
  String? state;

  factory DataSunat.fromJson(Map<String, dynamic> json) => DataSunat(
        name: json["name"],
        tradeName: json["trade_name"] == null ? null : json["trade_name"],
        locationId: json["location_id"], // Modificación aquí
        address: json["address"] == null ? null : json["address"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        provinceId: json["province_id"] == null ? null : json["province_id"],
        districtId: json["district_id"] == null ? null : json["district_id"],
        condition: json["condition"] == null ? null : json["condition"],
        state: json["state"] == null ? null : json["state"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "trade_name": tradeName == null ? null : tradeName,
        "location_id": locationId, // Modificación aquí
        "address": address == null ? null : address,
        "department_id": departmentId == null ? null : departmentId,
        "province_id": provinceId == null ? null : provinceId,
        "district_id": districtId == null ? null : districtId,
        "condition": condition == null ? null : condition,
        "state": state == null ? null : state,
      };
}

