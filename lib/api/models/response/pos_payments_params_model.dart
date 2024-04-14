import 'dart:convert';

import 'package:facturadorpro/api/models/response/init_params_pos.dart';
import 'package:facturadorpro/api/models/response/print_response_model.dart';

PosPaymentsParamsModel posPaymentsParamsModelFromJson(String str) {
  return PosPaymentsParamsModel.fromJson(json.decode(str));
}

String posPaymentsParamsModelToJson(PosPaymentsParamsModel data) {
  return json.encode(data.toJson());
}

class PosPaymentsParamsModel {
  PosPaymentsParamsModel({
    required this.series,
    required this.paymentMethodTypes,
    required this.cardsBrand,
    required this.paymentDestinations,
    required this.globalDiscountTypes,
  });

  List<Series> series;
  List<PaymentMethodType> paymentMethodTypes;
  List<CardsBrand> cardsBrand;
  List<PaymentDestination> paymentDestinations;
  List<GlobalDiscountType> globalDiscountTypes;

  factory PosPaymentsParamsModel.fromJson(Map<String, dynamic> json) =>
      PosPaymentsParamsModel(
        series:
            List<Series>.from(json["series"].map((x) => Series.fromJson(x))),
        paymentMethodTypes: List<PaymentMethodType>.from(
            json["payment_method_types"]
                .map((x) => PaymentMethodType.fromJson(x))),
        cardsBrand: List<CardsBrand>.from(
            json["cards_brand"].map((x) => CardsBrand.fromJson(x))),
        paymentDestinations: List<PaymentDestination>.from(
            json["payment_destinations"]
                .map((x) => PaymentDestination.fromJson(x))),
        globalDiscountTypes: List<GlobalDiscountType>.from(
            json["global_discount_types"]
                .map((x) => GlobalDiscountType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "series": List<dynamic>.from(series.map((x) => x.toJson())),
        "payment_method_types":
            List<dynamic>.from(paymentMethodTypes.map((x) => x.toJson())),
        "cards_brand": List<dynamic>.from(cardsBrand.map((x) => x.toJson())),
        "payment_destinations":
            List<dynamic>.from(paymentDestinations.map((x) => x.toJson())),
        "global_discount_types":
            List<dynamic>.from(globalDiscountTypes.map((x) => x.toJson())),
      };
}

class CardsBrand {
  CardsBrand({
    required this.id,
    required this.description,
    required this.active,
  });

  String id;
  String description;
  int active;

  factory CardsBrand.fromJson(Map<String, dynamic> json) => CardsBrand(
        id: json["id"],
        description: json["description"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "active": active,
      };
}

class GlobalDiscountType {
  GlobalDiscountType({
    required this.id,
    required this.active,
    required this.base,
    required this.level,
    required this.type,
    required this.description,
  });

  String id;
  int active;
  int base;
  String level;
  String type;
  String description;

  factory GlobalDiscountType.fromJson(Map<String, dynamic> json) =>
      GlobalDiscountType(
        id: json["id"],
        active: json["active"],
        base: json["base"],
        level: json["level"],
        type: json["type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "base": base,
        "level": level,
        "type": type,
        "description": description,
      };
}

class PaymentDestination {
  PaymentDestination({
    required this.id,
    this.cashId,
    required this.description,
  });

  String id;
  int? cashId;
  String description;

  factory PaymentDestination.fromJson(Map<String, dynamic> json) {
    return PaymentDestination(
      id: json["id"].toString(),
      cashId: json["cash_id"] == null ? null : json["cash_id"],
      description: json["description"],
    );
  }

  factory PaymentDestination.empty() {
    return PaymentDestination(
      id: "0",
      cashId: null,
      description: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "cash_id": cashId == null ? null : cashId,
      "description": description,
    };
  }
}

class Series {
  Series({
    required this.id,
    required this.establishmentId,
    required this.documentTypeId,
    required this.number,
    required this.contingency,
  });

  int id;
  int establishmentId;
  String documentTypeId;
  String number;
  int contingency;

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        id: json["id"],
        establishmentId: json["establishment_id"],
        documentTypeId: json["document_type_id"],
        number: json["number"],
        contingency: json["contingency"],
      );

  factory Series.empty() => Series(
        id: -1,
        establishmentId: -1,
        documentTypeId: "",
        number: "",
        contingency: 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "establishment_id": establishmentId,
        "document_type_id": documentTypeId,
        "number": number,
        "contingency": contingency,
      };
}
