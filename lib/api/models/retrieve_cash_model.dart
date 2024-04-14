import 'dart:convert';

import 'package:facturadorpro/api/models/response/cash_model.dart';

RetrieveCashModel retrieveCashModelFromJson(String str) =>
    RetrieveCashModel.fromJson(json.decode(str));

String retrieveCashModelToJson(RetrieveCashModel data) =>
    json.encode(data.toJson());

class RetrieveCashModel {
  RetrieveCashModel({
    required this.data,
  });

  CashItemModel data;

  factory RetrieveCashModel.fromJson(Map<String, dynamic> json) =>
      RetrieveCashModel(
        data: CashItemModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}
