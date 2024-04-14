import 'dart:convert';

ExchangeSunatModel exchangeSunatModelFromJson(String str) =>
    ExchangeSunatModel.fromJson(json.decode(str));

String exchangeSunatModelToJson(ExchangeSunatModel data) =>
    json.encode(data.toJson());

class ExchangeSunatModel {
  ExchangeSunatModel({
    required this.date,
    required this.sale,
    required this.purchase,
  });

  String date;
  double sale;
  double purchase;

  factory ExchangeSunatModel.fromJson(Map<String, dynamic> json) =>
      ExchangeSunatModel(
        date: json["date"],
        sale: json["sale"].toDouble(),
        purchase: json["purchase"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "sale": sale,
        "purchase": purchase,
      };
}
