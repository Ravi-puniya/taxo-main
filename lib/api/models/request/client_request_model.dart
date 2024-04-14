import 'package:facturadorpro/api/models/client_model.dart';

class ClientRequestModel {
  ClientRequestModel({
    this.id,
    this.type,
    this.creditDays,
    required this.identityDocumentTypeId,
    required this.number,
    required this.name,
    this.tradeName,
    this.departmentId,
    this.provinceId,
    this.districtId,
    this.address,
    this.telephone,
    this.condition,
    this.state,
    this.email,
    this.personTypeId,
    this.comment,
    required this.contact,
    this.internalCode,
    this.barcode,
    this.website,
    this.observation,
    this.sellerId,
  });

  int? id;
  String? type;
  int? creditDays;
  String identityDocumentTypeId;
  String number;
  String name;
  String? tradeName;
  String? departmentId;
  String? provinceId;
  String? districtId;
  String? address;
  String? telephone;
  String? condition;
  String? state;
  String? email;
  int? personTypeId;
  String? comment;
  Contact contact;
  String? internalCode;
  String? barcode;
  String? website;
  String? observation;
  int? sellerId;
}

class Address {
  Address({
    this.id,
    required this.countryId,
    required this.locationId,
    required this.address,
    this.email,
    this.phone,
  });

  int? id;
  String countryId;
  List<String> locationId;
  String? address;
  String? email;
  String? phone;
}
