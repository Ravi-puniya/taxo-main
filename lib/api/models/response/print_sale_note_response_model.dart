import 'dart:convert';

PrintSaleNoteResponseModel printSaleNoteResponseModelFromJson(String str) {
  return PrintSaleNoteResponseModel.fromJson(json.decode(str));
}

String printSaleNoteResponseModelToJson(PrintSaleNoteResponseModel data) {
  return json.encode(data.toJson());
}

class PrintSaleNoteResponseModel {
  PrintSaleNoteResponseModel({
    required this.data,
  });

  PrintDataSaleNote data;

  factory PrintSaleNoteResponseModel.fromJson(Map<String, dynamic> json) {
    return PrintSaleNoteResponseModel(
      data: PrintDataSaleNote.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data.toJson(),
    };
  }
}

class PrintDataSaleNote {
  PrintDataSaleNote({
    required this.id,
    required this.externalId,
    required this.dateOfIssue,
    required this.timeOfIssue,
    required this.identifier,
    required this.fullNumber,
    required this.customerName,
    required this.customerNumber,
    this.customerEmail,
    this.customerTelephone,
    required this.printA4,
    required this.printTicket,
    required this.printA5,
    required this.printTicket58,
    required this.messageText,
  });

  int id;
  String externalId;
  String dateOfIssue;
  String timeOfIssue;
  String identifier;
  String fullNumber;
  String customerName;
  String customerNumber;
  String? customerEmail;
  String? customerTelephone;
  String printA4;
  String printTicket;
  String printA5;
  String printTicket58;
  String messageText;

  factory PrintDataSaleNote.fromJson(Map<String, dynamic> json) {
    return PrintDataSaleNote(
      id: json["id"],
      externalId: json["external_id"],
      dateOfIssue: json["date_of_issue"],
      timeOfIssue: json["time_of_issue"],
      identifier: json["identifier"],
      fullNumber: json["full_number"],
      customerName: json["customer_name"],
      customerNumber: json["customer_number"],
      customerEmail:
          json["customer_email"] == null ? null : json["customer_email"],
      customerTelephone: json["customer_telephone"] == null
          ? null
          : json["customer_telephone"],
      printA4: json["print_a4"],
      printTicket: json["print_ticket"],
      printA5: json["print_a5"],
      printTicket58: json["print_ticket_58"],
      messageText: json["message_text"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "external_id": externalId,
      "date_of_issue": dateOfIssue,
      "time_of_issue": timeOfIssue,
      "identifier": identifier,
      "full_number": fullNumber,
      "customer_name": customerName,
      "customer_number": customerNumber,
      "customer_email": customerEmail == null ? null : customerEmail,
      "customer_telephone": customerEmail == null ? null : customerTelephone,
      "print_a4": printA4,
      "print_ticket": printTicket,
      "print_a5": printA5,
      "print_ticket_58": printTicket58,
      "message_text": messageText,
    };
  }
}
