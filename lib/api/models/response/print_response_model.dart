import 'dart:convert';

PrintResponseModel printResponseModelFromJson(String str) {
  return PrintResponseModel.fromJson(json.decode(str));
}

String printResponseModelToJson(PrintResponseModel data) {
  return json.encode(data.toJson());
}

class PrintResponseModel {
  PrintResponseModel({
    required this.data,
  });

  PrintData data;

  factory PrintResponseModel.fromJson(Map<String, dynamic> json) {
    return PrintResponseModel(
      data: PrintData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data.toJson(),
    };
  }
}

class PrintData {
  PrintData({
    required this.id,
    required this.externalId,
    required this.groupId,
    required this.number,
    required this.regularizeShipping,
    required this.dateOfIssue,
    required this.customerEmail,
    required this.downloadPdf,
    required this.printTicket,
    required this.printA4,
    required this.printA5,
    required this.imageDetraction,
    this.detraction,
    required this.responseMessage,
    required this.responseType,
    this.customerTelephone,
    required this.messageText,
    required this.sendToPse,
    this.responseSignaturePse,
    this.responseSendCdrPse,
  });

  int id;
  String externalId;
  String groupId;
  String number;
  bool regularizeShipping;
  String dateOfIssue;
  String? customerEmail;
  String downloadPdf;
  String printTicket;
  String printA4;
  String printA5;
  bool imageDetraction;
  dynamic detraction;
  String? responseMessage;
  String? responseType;
  String? customerTelephone;
  String messageText;
  bool sendToPse;
  dynamic responseSignaturePse;
  dynamic responseSendCdrPse;

  factory PrintData.fromJson(Map<String, dynamic> json) {
    return PrintData(
      id: json["id"],
      externalId: json["external_id"],
      groupId: json["group_id"],
      number: json["number"],
      regularizeShipping: json["regularize_shipping"],
      dateOfIssue: json["date_of_issue"],
      customerEmail:
          json["customer_email"] == null ? null : json["customer_email"],
      downloadPdf: json["download_pdf"],
      printTicket: json["print_ticket"],
      printA4: json["print_a4"],
      printA5: json["print_a5"],
      imageDetraction: json["image_detraction"],
      detraction: json["detraction"] == null ? null : json["detraction"],
      responseMessage:
          json["response_message"] == null ? null : json["response_message"],
      responseType:
          json["response_type"] == null ? null : json["response_type"],
      customerTelephone: json["customer_telephone"] == null
          ? null
          : json["customer_telephone"],
      messageText: json["message_text"],
      sendToPse: json["send_to_pse"],
      responseSignaturePse: json["response_signature_pse"] == null
          ? null
          : json["response_signature_pse"],
      responseSendCdrPse: json["response_send_cdr_pse"] == null
          ? null
          : json["response_send_cdr_pse"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "external_id": externalId,
      "group_id": groupId,
      "number": number,
      "regularize_shipping": regularizeShipping,
      "date_of_issue": dateOfIssue,
      "customer_email": customerEmail == null ? null : customerEmail,
      "download_pdf": downloadPdf,
      "print_ticket": printTicket,
      "print_a4": printA4,
      "print_a5": printA5,
      "image_detraction": imageDetraction,
      "detraction": detraction == null ? null : detraction,
      "response_message": responseMessage == null ? null : responseMessage,
      "response_type": responseType == null ? null : responseType,
      "customer_telephone":
          customerTelephone == null ? null : customerTelephone,
      "message_text": messageText,
      "send_to_pse": sendToPse,
      "response_signature_pse":
          responseSignaturePse == null ? null : responseSignaturePse,
      "response_send_cdr_pse":
          responseSendCdrPse == null ? null : responseSendCdrPse,
    };
  }
}
