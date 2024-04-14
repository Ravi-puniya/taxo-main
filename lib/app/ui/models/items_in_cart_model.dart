import 'dart:convert';

import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';
import 'package:facturadorpro/api/models/response/init_params_pos.dart';

List<ItemsInCartModel> itemsInCartModelFromJson(String str) =>
    List<ItemsInCartModel>.from(
        json.decode(str).map((x) => ItemsInCartModel.fromJson(x)));

String itemsInCartModelToJson(List<ItemsInCartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemsInCartModel {
  ItemsInCartModel({
    required this.item,
    this.presentation,
    required this.itemId,
    required this.currencyTypeId,
    required this.quantity,
    required this.unitValue,
    required this.affectationIgvTypeId,
    required this.affectationIgvType,
    required this.totalBaseIgv,
    required this.percentageIgv,
    required this.totalIgv,
    this.systemIscTypeId,
    required this.totalBaseIsc,
    required this.percentageIsc,
    required this.totalIsc,
    required this.totalBaseOtherTaxes,
    required this.percentageOtherTaxes,
    required this.totalOtherTaxes,
    required this.totalPlasticBagTaxes,
    required this.totalTaxes,
    required this.priceTypeId,
    required this.unitPrice,
    required this.totalValue,
    required this.totalDiscount,
    required this.totalCharge,
    required this.total,
    required this.attributes,
    required this.charges,
    required this.discounts,
    this.recordId,
    required this.totalValueWithoutRounding,
    required this.totalBaseIgvWithoutRounding,
    required this.totalIgvWithoutRounding,
    required this.totalTaxesWithoutRounding,
    required this.totalWithoutRounding,
    required this.unitTypeId,
  });

  ItemPos item;
  Presentation? presentation;
  int itemId;
  String currencyTypeId;
  double quantity;
  double unitValue;
  String affectationIgvTypeId;
  AffectationIgvType affectationIgvType;
  double totalBaseIgv;
  int percentageIgv;
  double totalIgv;
  int? systemIscTypeId;
  double totalBaseIsc;
  int percentageIsc;
  double totalIsc;
  double totalBaseOtherTaxes;
  int percentageOtherTaxes;
  double totalOtherTaxes;
  double totalPlasticBagTaxes;
  double totalTaxes;
  String priceTypeId;
  double unitPrice;
  double totalValue;
  double totalDiscount;
  double totalCharge;
  double total;
  List<dynamic> attributes;
  List<dynamic> charges;
  List<dynamic> discounts;
  dynamic recordId;
  double totalValueWithoutRounding;
  double totalBaseIgvWithoutRounding;
  double totalIgvWithoutRounding;
  double totalTaxesWithoutRounding;
  double totalWithoutRounding;
  String unitTypeId;

  factory ItemsInCartModel.fromJson(Map<String, dynamic> json) =>
      ItemsInCartModel(
        item: ItemPos.fromJson(json["item"]),
        presentation: json["presentation"] != null
            ? Presentation.fromJson(json["presentation"])
            : null,
        itemId: json["item_id"],
        currencyTypeId: json["currency_type_id"],
        quantity: json["quantity"].toDouble(),
        unitValue: json["unit_value"].toDouble(),
        affectationIgvTypeId: json["affectation_igv_type_id"],
        affectationIgvType:
            AffectationIgvType.fromJson(json["affectation_igv_type"]),
        totalBaseIgv: json["total_base_igv"].toDouble(),
        percentageIgv: json["percentage_igv"],
        totalIgv: json["total_igv"].toDouble(),
        systemIscTypeId: json["system_isc_type_id"] == null
            ? null
            : json["system_isc_type_id"],
        totalBaseIsc: json["total_base_isc"].toDouble(),
        percentageIsc: json["percentage_isc"],
        totalIsc: json["total_isc"].toDouble(),
        totalBaseOtherTaxes: json["total_base_other_taxes"].toDouble(),
        percentageOtherTaxes: json["percentage_other_taxes"],
        totalOtherTaxes: json["total_other_taxes"].toDouble(),
        totalPlasticBagTaxes: json["total_plastic_bag_taxes"].toDouble(),
        totalTaxes: json["total_taxes"].toDouble(),
        priceTypeId: json["price_type_id"],
        unitPrice: json["unit_price"].toDouble(),
        totalValue: json["total_value"].toDouble(),
        totalDiscount: json["total_discount"].toDouble(),
        totalCharge: json["total_charge"].toDouble(),
        total: json["total"].toDouble(),
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        charges: List<dynamic>.from(json["charges"].map((x) => x)),
        discounts: List<dynamic>.from(json["discounts"].map((x) => x)),
        recordId: json["record_id"] == null ? null : json["record_id"],
        totalValueWithoutRounding:
            json["total_value_without_rounding"].toDouble(),
        totalBaseIgvWithoutRounding:
            json["total_base_igv_without_rounding"].toDouble(),
        totalIgvWithoutRounding: json["total_igv_without_rounding"].toDouble(),
        totalTaxesWithoutRounding:
            json["total_taxes_without_rounding"].toDouble(),
        totalWithoutRounding: json["total_without_rounding"].toDouble(),
        unitTypeId: json["unit_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "presentation": presentation == null ? null : presentation,
        "item_id": itemId,
        "currency_type_id": currencyTypeId,
        "quantity": quantity,
        "unit_value": unitValue,
        "affectation_igv_type_id": affectationIgvTypeId,
        "affectation_igv_type": affectationIgvType.toJson(),
        "total_base_igv": totalBaseIgv,
        "percentage_igv": percentageIgv,
        "total_igv": totalIgv,
        "system_isc_type_id": systemIscTypeId == null ? null : systemIscTypeId,
        "total_base_isc": totalBaseIsc,
        "percentage_isc": percentageIsc,
        "total_isc": totalIsc,
        "total_base_other_taxes": totalBaseOtherTaxes,
        "percentage_other_taxes": percentageOtherTaxes,
        "total_other_taxes": totalOtherTaxes,
        "total_plastic_bag_taxes": totalPlasticBagTaxes,
        "total_taxes": totalTaxes,
        "price_type_id": priceTypeId,
        "unit_price": unitPrice,
        "total_value": totalValue,
        "total_discount": totalDiscount,
        "total_charge": totalCharge,
        "total": total,
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "charges": List<dynamic>.from(charges.map((x) => x)),
        "discounts": List<dynamic>.from(discounts.map((x) => x)),
        "record_id": recordId == null ? null : recordId,
        "total_value_without_rounding": totalValueWithoutRounding,
        "total_base_igv_without_rounding": totalBaseIgvWithoutRounding,
        "total_igv_without_rounding": totalIgvWithoutRounding,
        "total_taxes_without_rounding": totalTaxesWithoutRounding,
        "total_without_rounding": totalWithoutRounding,
        "unit_type_id": unitTypeId,
      };
}
