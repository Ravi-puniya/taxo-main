import 'dart:convert';

import 'package:facturadorpro/api/models/response/init_params_pos.dart';

List<PaymentPosModel> paymentPosModelFromJson(String str) {
  return List<PaymentPosModel>.from(
    json.decode(str).map((x) => PaymentPosModel.fromJson(x)),
  );
}

String paymentPosModelToJson(List<PaymentPosModel> data) {
  return json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

class PaymentPosModel {
  PaymentPosModel({
    this.id,
    this.documentId,
    this.saleNoteId,
    required this.dateOfPayment,
    required this.paymentMethodTypeId,
    required this.paymentDestinationId,
    this.reference,
    required this.payment,
    required this.paymentMethod,
  });

  dynamic id;
  dynamic documentId;
  dynamic saleNoteId;
  String dateOfPayment;
  String paymentMethodTypeId;
  String paymentDestinationId;
  String? reference;
  String payment;
  PaymentMethodType paymentMethod;

  factory PaymentPosModel.fromJson(Map<String, dynamic> json) {
    return PaymentPosModel(
      id: json["id"],
      documentId: json["document_id"],
      saleNoteId: json["sale_note_id"],
      dateOfPayment: json["date_of_payment"],
      paymentMethodTypeId: json["payment_method_type_id"],
      paymentDestinationId: json["payment_destination_id"],
      reference: json["reference"] == null ? null : json["reference"],
      payment: json["payment"],
      paymentMethod: PaymentMethodType.fromJson(json["payment_method"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "document_id": documentId,
      "sale_note_id": saleNoteId,
      "date_of_payment": dateOfPayment,
      "payment_method_type_id": paymentMethodTypeId,
      "payment_destination_id": paymentDestinationId,
      "reference": reference == null ? null : reference,
      "payment": payment,
      "payment_method": paymentMethod.toJson(),
    };
  }
}
