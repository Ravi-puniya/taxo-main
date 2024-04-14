import 'dart:convert';

VoucherSendModel voucherSendModelFromJson(String str) =>
    VoucherSendModel.fromJson(json.decode(str));

String voucherSendModelToJson(VoucherSendModel data) =>
    json.encode(data.toJson());

class VoucherSendModel {
  VoucherSendModel({
    required this.success,
    this.data,
  });

  bool success;
  DataSent? data;

  factory VoucherSendModel.fromJson(Map<String, dynamic> json) =>
      VoucherSendModel(
        success: json["success"],
        data: DataSent.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? null : data!.toJson(),
      };
}

class DataSent {
  DataSent({
    required this.id,
    required this.response,
  });

  int id;
  ResponseSent response;

  factory DataSent.fromJson(Map<String, dynamic> json) => DataSent(
        id: json["id"],
        response: ResponseSent.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "response": response.toJson(),
      };
}

class ResponseSent {
  ResponseSent({
    required this.sent,
    required this.code,
    required this.description,
    required this.notes,
  });

  bool sent;
  String code;
  String description;
  List<dynamic> notes;

  factory ResponseSent.fromJson(Map<String, dynamic> json) => ResponseSent(
        sent: json["sent"],
        code: json["code"],
        description: json["description"],
        notes: List<dynamic>.from(json["notes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sent": sent,
        "code": code,
        "description": description,
        "notes": List<dynamic>.from(notes.map((x) => x)),
      };
}
