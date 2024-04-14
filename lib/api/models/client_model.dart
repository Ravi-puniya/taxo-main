import 'dart:convert';

import 'package:facturadorpro/api/models/part/pagination.dart';

ClientModel clientModelFromJson(String str) =>
    ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
  ClientModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<ClientData> data;
  Links links;
  Meta meta;

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      data: List<ClientData>.from(
          json["data"].map((x) => ClientData.fromJson(x))),
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

class ClientData {
  ClientData({
    required this.id,
    required this.description,
    required this.name,
    required this.number,
    this.identityDocumentTypeId,
    this.identityDocumentTypeCode,
    this.address,
    this.internalCode,
    this.barcode,
    this.observation,
    this.seller,
    this.sellerId,
    this.website,
    required this.documentType,
    required this.enabled,
    required this.createdAt,
    this.updatedAt,
    this.type,
    this.tradeName,
    this.countryId,
    this.departmentId,
    this.department,
    this.provinceId,
    this.province,
    this.districtId,
    this.district,
    this.telephone,
    this.email,
    this.perceptionAgent,
    this.percentagePerception,
    this.state,
    this.condition,
    this.personTypeId,
    this.personType,
    this.contact,
    this.comment,
    required this.addresses,
    this.parentId,
    this.creditDays,
    required this.optionalEmail,
    this.optionalEmailSend,
  });

  int id;
  String description;
  String name;
  String number;
  String? identityDocumentTypeId;
  String? identityDocumentTypeCode;
  String? address;
  String? internalCode;
  String? barcode;
  String? observation;
  Seller? seller;
  int? sellerId;
  String? website;
  String documentType;
  bool enabled;
  String createdAt;
  String? updatedAt;
  String? type;
  String? tradeName;
  String? countryId;
  String? departmentId;
  Department? department;
  String? provinceId;
  Department? province;
  String? districtId;
  Department? district;
  String? telephone;
  String? email;
  bool? perceptionAgent;
  int? percentagePerception;
  String? state;
  String? condition;
  int? personTypeId;
  String? personType;
  Contact? contact;
  String? comment;
  List<Address> addresses;
  int? parentId;
  int? creditDays;
  List<OptionalEmail> optionalEmail;
  String? optionalEmailSend;

  factory ClientData.fromJson(Map<String, dynamic> json) => ClientData(
        id: json["id"],
        description: json["description"],
        name: json["name"],
        number: json["number"],
        identityDocumentTypeId: json["identity_document_type_id"] == null
            ? null
            : json["identity_document_type_id"],
        identityDocumentTypeCode: json["identity_document_type_code"] == null
            ? null
            : json["identity_document_type_code"],
        address: json["address"] == null ? null : json["address"],
        internalCode:
            json["internal_code"] == null ? null : json["internal_code"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        observation: json["observation"] == null ? null : json["observation"],
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
        sellerId: json["seller_id"] == null ? null : json["seller_id"],
        website: json["website"] == null ? null : json["website"],
        documentType: json["document_type"],
        enabled: json["enabled"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        type: json["type"] == null ? null : json["type"],
        tradeName: json["trade_name"] == null ? null : json["trade_name"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        department: json["department"] == null
            ? null
            : Department.fromJson(json["department"]),
        provinceId: json["province_id"] == null ? null : json["province_id"],
        province: json["province"] == null
            ? null
            : Department.fromJson(json["province"]),
        districtId: json["district_id"] == null ? null : json["district_id"],
        district: json["district"] == null
            ? null
            : Department.fromJson(json["district"]),
        telephone: json["telephone"] == null ? null : json["telephone"],
        email: json["email"] == null ? null : json["email"],
        perceptionAgent:
            json["perception_agent"] == null ? null : json["perception_agent"],
        percentagePerception: json["percentage_perception"] == null
            ? null
            : json["percentage_perception"],
        state: json["state"] == null ? null : json["state"],
        condition: json["condition"] == null ? null : json["condition"],
        personTypeId:
            json["person_type_id"] == null ? null : json["person_type_id"],
        personType: json["person_type"] == null ? null : json["person_type"],
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        comment: json["comment"] == null ? null : json["comment"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        creditDays: json["credit_days"] == null ? null : json["credit_days"],
        optionalEmail: List<OptionalEmail>.from(
            json["optional_email"].map((x) => OptionalEmail.fromJson(x))),
        optionalEmailSend: json["optional_email_send"] == null
            ? null
            : json["optional_email_send"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "name": name,
        "number": number,
        "identity_document_type_id":
            identityDocumentTypeId == null ? null : identityDocumentTypeId,
        "identity_document_type_code":
            identityDocumentTypeCode == null ? null : identityDocumentTypeCode,
        "address": address == null ? null : address,
        "internal_code": internalCode == null ? null : internalCode,
        "barcode": barcode == null ? null : barcode,
        "observation": observation == null ? null : observation,
        "seller": seller == null ? null : seller!.toJson(),
        "seller_id": sellerId == null ? null : sellerId,
        "website": website == null ? null : website,
        "document_type": documentType,
        "enabled": enabled,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "type": type == null ? null : type,
        "trade_name": tradeName == null ? null : tradeName,
        "country_id": countryId == null ? null : countryId,
        "department_id": departmentId == null ? null : departmentId,
        "department": department == null ? null : department!.toJson(),
        "province_id": provinceId == null ? null : provinceId,
        "province": province == null ? null : province!.toJson(),
        "district_id": districtId == null ? null : districtId,
        "district": district == null ? null : district!.toJson(),
        "telephone": telephone == null ? null : telephone,
        "email": email == null ? null : email,
        "perception_agent": perceptionAgent == null ? null : perceptionAgent,
        "percentage_perception":
            percentagePerception == null ? null : percentagePerception,
        "state": state == null ? null : state,
        "condition": condition == null ? null : condition,
        "person_type_id": personTypeId == null ? null : personTypeId,
        "person_type": personType == null ? null : personType,
        "contact": contact == null ? null : contact!.toJson(),
        "comment": comment == null ? null : comment,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "parent_id": parentId == null ? null : parentId,
        "credit_days": creditDays == null ? null : creditDays,
        "optional_email":
            List<dynamic>.from(optionalEmail.map((x) => x.toJson())),
        "optional_email_send":
            optionalEmailSend == null ? null : optionalEmailSend,
      };
}

class Address {
  Address({
    required this.id,
    required this.personId,
    this.countryId,
    this.departmentId,
    this.provinceId,
    this.districtId,
    required this.address,
    this.phone,
    this.email,
    required this.main,
  });

  int id;
  int personId;
  String? countryId;
  String? departmentId;
  String? provinceId;
  String? districtId;
  String address;
  String? phone;
  String? email;
  int main;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        personId: json["person_id"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        provinceId: json["province_id"] == null ? null : json["province_id"],
        districtId: json["district_id"] == null ? null : json["district_id"],
        address: json["address"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        main: json["main"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "person_id": personId,
        "country_id": countryId == null ? null : countryId,
        "department_id": departmentId == null ? null : departmentId,
        "province_id": provinceId == null ? null : provinceId,
        "district_id": districtId == null ? null : districtId,
        "address": address,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "main": main,
      };
}

class Contact {
  Contact({
    this.phone,
    this.fullName,
  });

  String? phone;
  String? fullName;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        phone: json["phone"] == null ? null : json["phone"],
        fullName: json["full_name"] == null ? null : json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone == null ? null : phone,
        "full_name": fullName == null ? null : fullName,
      };
}

class Department {
  Department({
    required this.id,
    required this.description,
    required this.active,
  });

  String id;
  String description;
  int active;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        description: json["description"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "active": active,
      };
}

class OptionalEmail {
  OptionalEmail({
    required this.email,
  });

  String email;

  factory OptionalEmail.fromJson(Map<String, dynamic> json) => OptionalEmail(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

class Seller {
  Seller({
    required this.id,
    required this.email,
    required this.name,
    required this.apiToken,
    this.documentId,
    this.serieId,
    required this.establishmentDescription,
    required this.type,
    required this.locked,
  });

  int id;
  String email;
  String name;
  String apiToken;
  String? documentId;
  String? serieId;
  String establishmentDescription;
  String type;
  bool locked;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        apiToken: json["api_token"],
        documentId: json["document_id"] == null ? null : json["document_id"],
        serieId: json["serie_id"] == null ? null : json["serie_id"],
        establishmentDescription: json["establishment_description"],
        type: json["type"],
        locked: json["locked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "api_token": apiToken,
        "document_id": documentId == null ? null : documentId,
        "serie_id": serieId == null ? null : serieId,
        "establishment_description": establishmentDescription,
        "type": type,
        "locked": locked,
      };
}
