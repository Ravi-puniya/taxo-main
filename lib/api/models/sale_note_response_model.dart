import 'dart:convert';

import 'package:facturadorpro/api/models/part/pagination.dart';

SaleNoteResponseModel saleNoteResponseModelFromJson(String str) {
  return SaleNoteResponseModel.fromJson(json.decode(str));
}

String saleNoteResponseModelToJson(SaleNoteResponseModel data) {
  return json.encode(data.toJson());
}

class SaleNoteResponseModel {
  SaleNoteResponseModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<SaleNote> data;
  Links links;
  Meta meta;

  factory SaleNoteResponseModel.fromJson(Map<String, dynamic> json) {
    return SaleNoteResponseModel(
      data: List<SaleNote>.from(json["data"].map((x) => SaleNote.fromJson(x))),
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

class SaleNote {
  SaleNote({
    required this.id,
    required this.dateOfIssue,
    required this.fullNumber,
    required this.customerName,
    required this.customerNumber,
    this.customerTelephone,
    this.customerEmail,
    required this.stateTypeId,
    required this.stateTypeDescription,
    required this.printA4,
    required this.printTicket,
    required this.messageText,
    required this.paid,
  });

  int id;
  String dateOfIssue;
  String fullNumber;
  String customerName;
  String customerNumber;
  String? customerTelephone;
  String? customerEmail;
  String stateTypeId;
  String stateTypeDescription;
  String printA4;
  String printTicket;
  String messageText;
  bool paid;

  factory SaleNote.fromJson(Map<String, dynamic> json) {
    return SaleNote(
      id: json["id"],
      dateOfIssue: json["date_of_issue"],
      fullNumber: json["full_number"],
      customerName: json["customer_name"],
      customerNumber: json["customer_number"],
      customerTelephone: json["customer_telephone"] == null
          ? null
          : json["customer_telephone"],
      customerEmail:
          json["customer_email"] == null ? null : json["customer_email"],
      stateTypeId: json["state_type_id"],
      stateTypeDescription: json["state_type_description"],
      printA4: json["print_a4"],
      printTicket: json["print_ticket"],
      messageText: json["message_text"],
      paid: json["paid"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date_of_issue": dateOfIssue,
      "full_number": fullNumber,
      "customer_name": customerName,
      "customer_number": customerNumber,
      "customer_telephone":
          customerTelephone == null ? null : customerTelephone,
      "customer_email": customerEmail == null ? null : customerEmail,
      "state_type_id": stateTypeId,
      "state_type_description": stateTypeDescription,
      "print_a4": printA4,
      "print_ticket": printTicket,
      "message_text": messageText,
      "paid": paid,
    };
  }
}
