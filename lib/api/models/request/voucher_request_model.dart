import 'dart:convert';

import 'package:facturadorpro/app/ui/models/items_in_cart_model.dart';
import 'package:facturadorpro/app/ui/models/payment_pos_model.dart';

VoucherRequestModel voucherRequestModelFromJson(String str) =>
    VoucherRequestModel.fromJson(json.decode(str));

String voucherRequestModelToJson(VoucherRequestModel data) =>
    json.encode(data.toJson());

class VoucherRequestModel {
  VoucherRequestModel({
    required this.establishmentId,
    required this.documentTypeId,
    required this.seriesId,
    this.prefix,
    required this.number,
    required this.dateOfIssue,
    required this.timeOfIssue,
    required this.customerId,
    required this.currencyTypeId,
    this.purchaseOrder,
    required this.exchangeRateSale,
    required this.totalPrepayment,
    required this.totalCharge,
    required this.totalDiscount,
    required this.totalExportation,
    required this.totalFree,
    required this.totalTaxed,
    required this.totalUnaffected,
    required this.totalExonerated,
    required this.totalIgv,
    required this.totalBaseIsc,
    required this.totalIsc,
    required this.totalBaseOtherTaxes,
    required this.totalOtherTaxes,
    required this.totalPlasticBagTaxes,
    required this.totalTaxes,
    required this.totalValue,
    required this.total,
    required this.subtotal,
    required this.totalIgvFree,
    required this.operationTypeId, // Concatenar el 01 de ventas con el codigo del tipo de documento
    required this.dateOfDue, // misma fecha que el comprobante
    required this.items,
    required this.charges,
    required this.discounts,
    required this.attributes,
    required this.guides,
    required this.payments,
    this.additionalInformation,
    required this.actions,
    this.referenceData,
    required this.isPrint,
    this.workerFullNameTips,
    required this.totalTips,
  });

  int establishmentId;
  String documentTypeId;
  int seriesId;
  dynamic prefix;
  String number;
  String dateOfIssue;
  String timeOfIssue;
  int customerId;
  String currencyTypeId;
  dynamic purchaseOrder;
  double exchangeRateSale;
  double totalPrepayment;
  double totalCharge;
  double totalDiscount;
  double totalExportation;
  double totalFree;
  double totalTaxed;
  double totalUnaffected;
  double totalExonerated;
  double totalIgv;
  double totalBaseIsc;
  double totalIsc;
  double totalBaseOtherTaxes;
  double totalOtherTaxes;
  double totalPlasticBagTaxes;
  double totalTaxes;
  double totalValue;
  double total;
  double subtotal;
  double totalIgvFree;
  String operationTypeId;
  String dateOfDue;
  List<ItemsInCartModel> items;
  List<dynamic> charges;
  List<dynamic> discounts;
  List<dynamic> attributes;
  List<dynamic> guides;
  List<PaymentPosModel> payments;
  dynamic additionalInformation;
  ActionsModel actions;
  dynamic referenceData;
  bool isPrint;
  dynamic workerFullNameTips;
  int totalTips;

  factory VoucherRequestModel.fromJson(Map<String, dynamic> json) =>
      VoucherRequestModel(
        establishmentId: json["establishment_id"],
        documentTypeId: json["document_type_id"],
        seriesId: json["series_id"],
        prefix: json["prefix"],
        number: json["number"],
        dateOfIssue: json["date_of_issue"],
        timeOfIssue: json["time_of_issue"],
        customerId: json["customer_id"],
        currencyTypeId: json["currency_type_id"],
        purchaseOrder: json["purchase_order"],
        exchangeRateSale: json["exchange_rate_sale"].toDouble(),
        totalPrepayment: json["total_prepayment"],
        totalCharge: json["total_charge"],
        totalDiscount: json["total_discount"],
        totalExportation: json["total_exportation"],
        totalFree: json["total_free"],
        totalTaxed: json["total_taxed"],
        totalUnaffected: json["total_unaffected"],
        totalExonerated: json["total_exonerated"],
        totalIgv: json["total_igv"],
        totalBaseIsc: json["total_base_isc"],
        totalIsc: json["total_isc"],
        totalBaseOtherTaxes: json["total_base_other_taxes"],
        totalOtherTaxes: json["total_other_taxes"],
        totalPlasticBagTaxes: json["total_plastic_bag_taxes"].toDouble(),
        totalTaxes: json["total_taxes"].toDouble(),
        totalValue: json["total_value"],
        total: json["total"].toDouble(),
        subtotal: json["subtotal"].toDouble(),
        totalIgvFree: json["total_igv_free"],
        operationTypeId: json["operation_type_id"],
        dateOfDue: json["date_of_due"],
        items: List<ItemsInCartModel>.from(
            json["items"].map((x) => ItemsInCartModel.fromJson(x))),
        charges: List<dynamic>.from(json["charges"].map((x) => x)),
        discounts: List<dynamic>.from(json["discounts"].map((x) => x)),
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        guides: List<dynamic>.from(json["guides"].map((x) => x)),
        payments: List<PaymentPosModel>.from(
            json["payments"].map((x) => PaymentPosModel.fromJson(x))),
        additionalInformation: json["additional_information"],
        actions: ActionsModel.fromJson(json["actions"]),
        referenceData: json["reference_data"],
        isPrint: json["is_print"],
        workerFullNameTips: json["worker_full_name_tips"],
        totalTips: json["total_tips"],
      );

  Map<String, dynamic> toJson() => {
        "establishment_id": establishmentId,
        "document_type_id": documentTypeId,
        "series_id": seriesId,
        "prefix": prefix,
        "number": number,
        "date_of_issue": dateOfIssue,
        "time_of_issue": timeOfIssue,
        "customer_id": customerId,
        "currency_type_id": currencyTypeId,
        "purchase_order": purchaseOrder,
        "exchange_rate_sale": exchangeRateSale,
        "total_prepayment": totalPrepayment,
        "total_charge": totalCharge,
        "total_discount": totalDiscount,
        "total_exportation": totalExportation,
        "total_free": totalFree,
        "total_taxed": totalTaxed,
        "total_unaffected": totalUnaffected,
        "total_exonerated": totalExonerated,
        "total_igv": totalIgv,
        "total_base_isc": totalBaseIsc,
        "total_isc": totalIsc,
        "total_base_other_taxes": totalBaseOtherTaxes,
        "total_other_taxes": totalOtherTaxes,
        "total_plastic_bag_taxes": totalPlasticBagTaxes,
        "total_taxes": totalTaxes,
        "total_value": totalValue,
        "total": total,
        "subtotal": subtotal,
        "total_igv_free": totalIgvFree,
        "operation_type_id": operationTypeId,
        "date_of_due": dateOfDue,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "charges": List<dynamic>.from(charges.map((x) => x)),
        "discounts": List<dynamic>.from(discounts.map((x) => x)),
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "guides": List<dynamic>.from(guides.map((x) => x)),
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
        "additional_information": additionalInformation,
        "actions": actions.toJson(),
        "reference_data": referenceData,
        "is_print": isPrint,
        "worker_full_name_tips": workerFullNameTips,
        "total_tips": totalTips,
      };
}

class ActionsModel {
  ActionsModel({
    required this.formatPdf,
  });

  String formatPdf;

  factory ActionsModel.fromJson(Map<String, dynamic> json) {
    return ActionsModel(
      formatPdf: json["format_pdf"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "format_pdf": formatPdf,
    };
  }
}
