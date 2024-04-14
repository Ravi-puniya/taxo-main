import 'cotizacion_item.dart';

class Cotizacion {
  String prefix;
  int? establishmentId;
  String dateOfIssue;
  String timeOfIssue;
  int customerId;
  String currencyTypeId;
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
  double totalIgvFree;
  double totalBaseIsc;
  double totalIsc;
  double totalBaseOtherTaxes;
  double totalOtherTaxes;
  double totalTaxes;
  double totalValue;
  double total;
  double subtotal;
  List<Cotizacioniten> items;
  String paymentMethodTypeId;
  int? customerAddressId;
  dynamic additionalInformation;
  dynamic shippingAddress;
  dynamic accountNumber;
  dynamic termsCondition;
  bool activeTermsCondition;
  Map<String, dynamic> actions;
  List<dynamic> payments;
  dynamic saleOpportunityId;
  dynamic contact;
  dynamic phone;

  Cotizacion({
    required this.prefix,
    this.establishmentId,
    required this.dateOfIssue,
    required this.timeOfIssue,
    required this.customerId,
    required this.currencyTypeId,
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
    required this.totalIgvFree,
    required this.totalBaseIsc,
    required this.totalIsc,
    required this.totalBaseOtherTaxes,
    required this.totalOtherTaxes,
    required this.totalTaxes,
    required this.totalValue,
    required this.total,
    required this.subtotal,
    required this.items,
    required this.paymentMethodTypeId,
    this.customerAddressId,
    this.additionalInformation,
    this.shippingAddress,
    this.accountNumber,
    this.termsCondition,
    required this.activeTermsCondition,
    required this.actions,
    required this.payments,
    this.saleOpportunityId,
    this.contact,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        "prefix": prefix,
        "establishment_id": establishmentId,
        "date_of_issue": dateOfIssue,
        "time_of_issue": timeOfIssue,
        "customer_id": customerId,
        "currency_type_id": currencyTypeId,
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
        "total_igv_free": totalIgvFree,
        "total_base_isc": totalBaseIsc,
        "total_isc": totalIsc,
        "total_base_other_taxes": totalBaseOtherTaxes,
        "total_other_taxes": totalOtherTaxes,
        "total_taxes": totalTaxes,
        "total_value": totalValue,
        "total": total,
        "subtotal": subtotal,
        "items": items.map((e) => e.toJson()).toList(),
        "payment_method_type_id": paymentMethodTypeId,
        "customer_address_id": customerAddressId,
        "additional_information": additionalInformation,
        "shipping_address": shippingAddress,
        "account_number": accountNumber,
        "terms_condition": termsCondition,
        "active_terms_condition": activeTermsCondition,
        "actions": actions,
        "payments": payments,
        "sale_opportunity_id": saleOpportunityId,
        "contact": contact,
        "phone": phone,
      };
}
