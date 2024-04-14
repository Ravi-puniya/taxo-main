import 'dart:convert';

import 'package:facturadorpro/api/models/customer_pos_model.dart';

InitParamsPos initParamsPosFromJson(String str) {
  return InitParamsPos.fromJson(json.decode(str));
}

String initParamsPosToJson(InitParamsPos data) {
  return json.encode(data.toJson());
}

class InitParamsPos {
  InitParamsPos({
    required this.affectationIgvTypes,
    required this.establishment,
    required this.user,
    required this.customers,
    required this.currencyTypes,
    required this.categories,
  });

  List<AffectationIgvType> affectationIgvTypes;
  EstablishmentPos establishment;
  UserPos user;
  List<CustomerPosModel> customers;
  List<CurrencyType> currencyTypes;
  List<Category> categories;

  factory InitParamsPos.fromJson(Map<String, dynamic> json) {
    return InitParamsPos(
      affectationIgvTypes: List<AffectationIgvType>.from(
        json["affectation_igv_types"].map(
          (x) => AffectationIgvType.fromJson(x),
        ),
      ),
      establishment: EstablishmentPos.fromJson(json["establishment"]),
      user: UserPos.fromJson(json["user"]),
      customers: List<CustomerPosModel>.from(
        json["customers"].map((x) => CustomerPosModel.fromJson(x)),
      ),
      currencyTypes: List<CurrencyType>.from(
        json["currency_types"].map((x) => CurrencyType.fromJson(x)),
      ),
      categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "affectation_igv_types":
          List<dynamic>.from(affectationIgvTypes.map((x) => x.toJson())),
      "establishment": establishment.toJson(),
      "user": user.toJson(),
      "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
      "currency_types":
          List<dynamic>.from(currencyTypes.map((x) => x.toJson())),
      "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
  }
}

class AffectationIgvType {
  AffectationIgvType({
    required this.id,
    required this.active,
    required this.exportation,
    required this.free,
    required this.description,
  });

  String id;
  int active;
  int exportation;
  int free;
  String description;

  factory AffectationIgvType.fromJson(Map<String, dynamic> json) =>
      AffectationIgvType(
        id: json["id"],
        active: json["active"],
        exportation: json["exportation"],
        free: json["free"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "exportation": exportation,
        "free": free,
        "description": description,
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

class CurrencyType {
  CurrencyType({
    required this.id,
    required this.active,
    required this.symbol,
    required this.description,
  });

  String id;
  int active;
  String symbol;
  String description;

  factory CurrencyType.fromJson(Map<String, dynamic> json) => CurrencyType(
        id: json["id"],
        active: json["active"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        description: json["description"],
      );

  factory CurrencyType.empty() => CurrencyType(
        id: "",
        active: 0,
        symbol: "",
        description: "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "symbol": symbol,
        "description": description,
      };
}

class InvoiceType {
  InvoiceType({
    required this.id,
    required this.description,
  });

  String id;
  String description;

  factory InvoiceType.fromJson(Map<String, dynamic> json) => InvoiceType(
        id: json["id"],
        description: json["description"],
      );

  factory InvoiceType.empty() => InvoiceType(
        id: "",
        description: "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}

class EstablishmentPos {
  EstablishmentPos({
    required this.id,
    required this.description,
  });

  int id;
  String description;

  factory EstablishmentPos.fromJson(Map<String, dynamic> json) =>
      EstablishmentPos(
        id: json["id"],
        description: json["description"],
      );

  factory EstablishmentPos.empty() => EstablishmentPos(
        id: 0,
        description: "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}

class PaymentMethodType {
  PaymentMethodType({
    required this.id,
    required this.description,
    required this.hasCard,
    this.charge,
    this.numberDays,
    required this.isCredit,
    required this.isCash,
  });

  String id;
  String description;
  int hasCard;
  String? charge;
  int? numberDays;
  int isCredit;
  int isCash;

  factory PaymentMethodType.fromJson(Map<String, dynamic> json) =>
      PaymentMethodType(
        id: json["id"],
        description: json["description"],
        hasCard: json["has_card"],
        charge: json["charge"] == null ? null : json["charge"],
        numberDays: json["number_days"] == null ? null : json["number_days"],
        isCredit: json["is_credit"],
        isCash: json["is_cash"],
      );

  factory PaymentMethodType.empty() => PaymentMethodType(
        id: "",
        description: "",
        hasCard: 0,
        charge: null,
        numberDays: null,
        isCredit: 0,
        isCash: 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "has_card": hasCard,
        "charge": charge == null ? null : charge,
        "number_days": numberDays == null ? null : numberDays,
        "is_credit": isCredit,
        "is_cash": isCash,
      };
}

class UserPos {
  UserPos({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
  });

  int id;
  String name;
  String email;
  String type;

  factory UserPos.fromJson(Map<String, dynamic> json) => UserPos(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "type": type,
      };
}
