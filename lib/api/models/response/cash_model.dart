import 'dart:convert';

import 'package:facturadorpro/api/models/part/pagination.dart';

CashModel cashModelFromJson(String str) => CashModel.fromJson(json.decode(str));

String cashModelToJson(CashModel data) => json.encode(data.toJson());

class CashModel {
  CashModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<CashItemModel> data;
  Links links;
  Meta meta;

  factory CashModel.fromJson(Map<String, dynamic> json) => CashModel(
        data: List<CashItemModel>.from(
            json["data"].map((x) => CashItemModel.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class CashItemModel {
  CashItemModel({
    required this.id,
    required this.userId,
    required this.user,
    required this.dateOpening,
    required this.timeOpening,
    required this.opening,
    this.dateClosed,
    this.timeClosed,
    this.closed,
    required this.beginningBalance,
    required this.finalBalance,
    required this.income,
    this.expense,
    this.filename,
    required this.state,
    required this.stateDescription,
    this.referenceNumber,
  });

  int id;
  int userId;
  String user;
  String dateOpening;
  String timeOpening;
  String opening;
  String? dateClosed;
  String? timeClosed;
  String? closed;
  String beginningBalance;
  String finalBalance;
  String income;
  String? expense;
  String? filename;
  bool state;
  String stateDescription;
  String? referenceNumber;

  factory CashItemModel.fromJson(Map<String, dynamic> json) => CashItemModel(
        id: json["id"],
        userId: json["user_id"],
        user: json["user"],
        dateOpening: json["date_opening"],
        timeOpening: json["time_opening"],
        opening: json["opening"],
        dateClosed: json["date_closed"] == null ? null : json["date_closed"],
        timeClosed: json["time_closed"] == null ? null : json["time_closed"],
        closed: json["closed"] == null ? null : json["closed"],
        beginningBalance: json["beginning_balance"],
        finalBalance: json["final_balance"],
        income: json["income"],
        expense: json["expense"] == null ? null : json["expense"],
        filename: json["filename"] == null ? null : json["filename"],
        state: json["state"],
        stateDescription: json["state_description"],
        referenceNumber:
            json["reference_number"] == null ? null : json["reference_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user": user,
        "date_opening": dateOpening,
        "time_opening": timeOpening,
        "opening": opening,
        "date_closed": dateClosed == null ? null : dateClosed,
        "time_closed": timeClosed == null ? null : timeClosed,
        "closed": closed == null ? null : closed,
        "beginning_balance": beginningBalance,
        "final_balance": finalBalance,
        "income": income,
        "expense": expense == null ? null : expense,
        "filename": filename == null ? null : filename,
        "state": state,
        "state_description": stateDescription,
        "reference_number": referenceNumber == null ? null : referenceNumber,
      };
}
