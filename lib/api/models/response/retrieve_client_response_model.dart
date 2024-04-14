import 'dart:convert';

import 'package:facturadorpro/api/models/client_model.dart';

RetrieveClientResponseModel retrieveClientResponseModelFromJson(String str) {
  return RetrieveClientResponseModel.fromJson(json.decode(str));
}

String retrieveClientResponseModelToJson(RetrieveClientResponseModel data) {
  return json.encode(data.toJson());
}

class RetrieveClientResponseModel {
  RetrieveClientResponseModel({
    this.success,
    this.data,
  });

  bool? success;
  ClientData? data;

  factory RetrieveClientResponseModel.fromJson(Map<String, dynamic> json) {
    return RetrieveClientResponseModel(
      success: json["success"] == null ? null : json["success"],
      data: ClientData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success == null ? null : success,
      "data": data == null ? null : data!.toJson(),
    };
  }
}
