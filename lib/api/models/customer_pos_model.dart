import 'dart:convert';

List<CustomerPosModel> customerPosModelFromJson(String str) =>
    List<CustomerPosModel>.from(
        json.decode(str).map((x) => CustomerPosModel.fromJson(x)));

String customerPosModelToJson(List<CustomerPosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerPosModel {
  CustomerPosModel({
    required this.id,
    this.description,
    required this.name,
    required this.number,
    required this.identityDocumentTypeId,
    this.identityDocumentTypeCode,
  });

  int id;
  String? description;
  String name;
  String number;
  String identityDocumentTypeId;
  String? identityDocumentTypeCode;

  factory CustomerPosModel.fromJson(Map<String, dynamic> json) =>
      CustomerPosModel(
        id: json["id"],
        description: json["description"] == null ? null : json["description"],
        name: json["name"],
        number: json["number"],
        identityDocumentTypeId: json["identity_document_type_id"],
        identityDocumentTypeCode: json["identity_document_type_code"] == null
            ? null
            : json["identity_document_type_code"],
      );

  factory CustomerPosModel.empty() => CustomerPosModel(
        id: 0,
        description: "",
        name: "",
        number: "",
        identityDocumentTypeId: "",
        identityDocumentTypeCode: null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description == null ? null : description,
        "name": name,
        "number": number,
        "identity_document_type_id": identityDocumentTypeId,
        "identity_document_type_code":
            identityDocumentTypeCode == null ? null : identityDocumentTypeCode,
      };
}
