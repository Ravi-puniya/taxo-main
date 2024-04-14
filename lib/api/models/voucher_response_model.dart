import 'dart:convert';

import 'package:facturadorpro/api/models/part/pagination.dart';

VoucherResponseModel voucherResponseModelFromJson(String str) {
  return VoucherResponseModel.fromJson(json.decode(str));
}

String voucherResponseModelToJson(VoucherResponseModel data) {
  return json.encode(data.toJson());
}

class VoucherResponseModel {
  VoucherResponseModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<Voucher> data;
  Links links;
  Meta meta;

  factory VoucherResponseModel.fromJson(Map<String, dynamic> json) {
    return VoucherResponseModel(
      data: List<Voucher>.from(json["data"].map((x) => Voucher.fromJson(x))),
      links: Links.fromJson(json["links"]),
      meta: Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": List<dynamic>.from(data.map((x) => x.toJson())),
      "links": links.toJson(),
      "meta": meta.toJson(),
    };
  }
}

class Voucher {
  Voucher({
    required this.id,
    required this.groupId,
    required this.soapTypeId,
    required this.soapTypeDescription,
    required this.dateOfIssue,
    this.dateOfDue,
    required this.number,
    required this.customerName,
    required this.customerNumber,
    this.customerTelephone,
    required this.currencyTypeId,
    required this.totalExportation,
    required this.totalFree,
    required this.totalUnaffected,
    required this.totalExonerated,
    required this.totalTaxed,
    required this.totalIgv,
    required this.total,
    required this.stateTypeId,
    required this.stateTypeDescription,
    required this.documentTypeDescription,
    required this.documentTypeId,
    required this.hasXml,
    required this.hasPdf,
    required this.hasCdr,
    required this.downloadXml,
    required this.downloadPdf,
    required this.downloadCdr,
    required this.btnVoided,
    required this.btnNote,
    required this.btnGuide,
    required this.btnResend,
    required this.btnConsultCdr,
    required this.btnConstancyDetraction,
    required this.btnRecreateDocument,
    required this.btnChangeToRegisteredStatus,
    required this.btnDeleteDocType03,
    required this.sendServer,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.userEmail,
    required this.userId,
    required this.emailSendIt,
    required this.emailSendItArray,
    required this.externalId,
    required this.balance,
    this.messageRegularizeShipping,
    required this.regularizeShipping,
    this.purchaseOrder,
    required this.isEditable,
    required this.soapType,
    required this.totalCharge,
  });

  int id;
  String groupId;
  String soapTypeId;
  String soapTypeDescription;
  String dateOfIssue;
  String? dateOfDue;
  String number;
  String customerName;
  String customerNumber;
  String? customerTelephone;
  String currencyTypeId;
  String totalExportation;
  String totalFree;
  String totalUnaffected;
  String totalExonerated;
  String totalTaxed;
  String totalIgv;
  String total;
  String stateTypeId;
  String stateTypeDescription;
  String documentTypeDescription;
  String documentTypeId;
  bool hasXml;
  bool hasPdf;
  bool hasCdr;
  String downloadXml;
  String downloadPdf;
  String downloadCdr;
  bool btnVoided;
  bool btnNote;
  bool btnGuide;
  bool btnResend;
  bool btnConsultCdr;
  bool btnConstancyDetraction;
  bool btnRecreateDocument;
  bool btnChangeToRegisteredStatus;
  bool btnDeleteDocType03;
  bool sendServer;
  String createdAt;
  String updatedAt;
  String userName;
  String userEmail;
  int userId;
  bool emailSendIt;
  List<EmailSendItArray> emailSendItArray;
  String externalId;
  String balance;
  String? messageRegularizeShipping;
  bool regularizeShipping;
  String? purchaseOrder;
  bool isEditable;
  SoapType soapType;
  String totalCharge;

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json["id"],
      groupId: json["group_id"],
      soapTypeId: json["soap_type_id"],
      soapTypeDescription: json["soap_type_description"],
      dateOfIssue: json["date_of_issue"],
      dateOfDue: json["date_of_due"] == null ? null : json["date_of_due"],
      number: json["number"],
      customerName: json["customer_name"],
      customerNumber: json["customer_number"],
      customerTelephone: json["customer_telephone"] == null
          ? null
          : json["customer_telephone"],
      currencyTypeId: json["currency_type_id"],
      totalExportation: json["total_exportation"],
      totalFree: json["total_free"],
      totalUnaffected: json["total_unaffected"],
      totalExonerated: json["total_exonerated"],
      totalTaxed: json["total_taxed"],
      totalIgv: json["total_igv"],
      total: json["total"].toString(),
      stateTypeId: json["state_type_id"],
      stateTypeDescription: json["state_type_description"],
      documentTypeDescription: json["document_type_description"],
      documentTypeId: json["document_type_id"],
      hasXml: json["has_xml"],
      hasPdf: json["has_pdf"],
      hasCdr: json["has_cdr"],
      downloadXml: json["download_xml"],
      downloadPdf: json["download_pdf"],
      downloadCdr: json["download_cdr"],
      btnVoided: json["btn_voided"],
      btnNote: json["btn_note"],
      btnGuide: json["btn_guide"],
      btnResend: json["btn_resend"],
      btnConsultCdr: json["btn_consult_cdr"],
      btnConstancyDetraction: json["btn_constancy_detraction"],
      btnRecreateDocument: json["btn_recreate_document"],
      btnChangeToRegisteredStatus: json["btn_change_to_registered_status"],
      btnDeleteDocType03: json["btn_delete_doc_type_03"],
      sendServer: json["send_server"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      userName: json["user_name"],
      userEmail: json["user_email"],
      userId: json["user_id"],
      emailSendIt: json["email_send_it"],
      emailSendItArray: List<EmailSendItArray>.from(
        json["email_send_it_array"].map(
          (x) => EmailSendItArray.fromJson(x),
        ),
      ),
      externalId: json["external_id"],
      balance: json["balance"],
      messageRegularizeShipping: json["message_regularize_shipping"],
      regularizeShipping: json["regularize_shipping"],
      purchaseOrder: json["purchase_order"],
      isEditable: json["is_editable"],
      soapType: SoapType.fromJson(json["soap_type"]),
      totalCharge: json["total_charge"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "group_id": groupId,
      "soap_type_id": soapTypeId,
      "soap_type_description": soapTypeDescription,
      "date_of_issue": dateOfIssue,
      "date_of_due": dateOfDue == null ? null : dateOfDue,
      "number": number,
      "customer_name": customerName,
      "customer_number": customerNumber,
      "customer_telephone":
          customerTelephone == null ? null : customerTelephone,
      "currency_type_id": currencyTypeId,
      "total_exportation": totalExportation,
      "total_free": totalFree,
      "total_unaffected": totalUnaffected,
      "total_exonerated": totalExonerated,
      "total_taxed": totalTaxed,
      "total_igv": totalIgv,
      "total": total,
      "state_type_id": stateTypeId,
      "state_type_description": stateTypeDescription,
      "document_type_description": documentTypeDescription,
      "document_type_id": documentTypeId,
      "has_xml": hasXml,
      "has_pdf": hasPdf,
      "has_cdr": hasCdr,
      "download_xml": downloadXml,
      "download_pdf": downloadPdf,
      "download_cdr": downloadCdr,
      "btn_voided": btnVoided,
      "btn_note": btnNote,
      "btn_guide": btnGuide,
      "btn_resend": btnResend,
      "btn_consult_cdr": btnConsultCdr,
      "btn_constancy_detraction": btnConstancyDetraction,
      "btn_recreate_document": btnRecreateDocument,
      "btn_change_to_registered_status": btnChangeToRegisteredStatus,
      "btn_delete_doc_type_03": btnDeleteDocType03,
      "send_server": sendServer,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "user_name": userName,
      "user_email": userEmail,
      "user_id": userId,
      "email_send_it": emailSendIt,
      "email_send_it_array": List<dynamic>.from(
        emailSendItArray.map((x) => x.toJson()),
      ),
      "external_id": externalId,
      "balance": balance,
      "message_regularize_shipping": messageRegularizeShipping,
      "regularize_shipping": regularizeShipping,
      "purchase_order": purchaseOrder,
      "is_editable": isEditable,
      "soap_type": soapType.toJson(),
      "total_charge": totalCharge,
    };
  }
}

class EmailSendItArray {
  EmailSendItArray({
    required this.email,
    required this.sendIt,
    required this.sendDate,
  });

  String email;
  bool sendIt;
  String sendDate;

  factory EmailSendItArray.fromJson(Map<String, dynamic> json) {
    return EmailSendItArray(
      email: json["email"],
      sendIt: json["send_it"],
      sendDate: json["send_date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "send_it": sendIt,
      "send_date": sendDate,
    };
  }
}

class SoapType {
  SoapType({
    required this.id,
    required this.description,
  });

  String id;
  String description;

  factory SoapType.fromJson(Map<String, dynamic> json) {
    return SoapType(
      id: json["id"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
    };
  }
}
