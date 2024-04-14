import 'dart:convert';

UserActiveCashModel userActiveCashModelFromJson(String str) =>
    UserActiveCashModel.fromJson(json.decode(str));

String userActiveCashModelToJson(UserActiveCashModel data) =>
    json.encode(data.toJson());

class UserActiveCashModel {
  UserActiveCashModel({
    this.cash,
  });

  CashItem? cash;

  factory UserActiveCashModel.fromJson(Map<String, dynamic> json) =>
      UserActiveCashModel(
        cash: json["cash"] == null ? null : CashItem.fromJson(json["cash"]),
      );

  Map<String, dynamic> toJson() => {
        "cash": cash == null ? null : cash!.toJson(),
      };
}

class CashItem {
  CashItem({
    required this.id,
  });

  int id;

  factory CashItem.fromJson(Map<String, dynamic> json) => CashItem(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
