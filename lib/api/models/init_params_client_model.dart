import 'dart:convert';

InitParamsClientModel initParamsClientModelFromJson(String str) =>
    InitParamsClientModel.fromJson(json.decode(str));

String initParamsClientModelToJson(InitParamsClientModel data) =>
    json.encode(data.toJson());

class InitParamsClientModel {
  InitParamsClientModel({
    required this.countries,
    required this.departments,
    required this.provinces,
    required this.districts,
    required this.identityDocumentTypes,
    required this.locations,
    required this.personTypes,
    this.apiServiceToken,
    required this.zones,
    required this.sellers,
  });

  List<Country> countries;
  List<Country> departments;
  List<Province> provinces;
  List<Country> districts;
  List<IdentityDocumentType> identityDocumentTypes;
  List<Location> locations;
  List<PersonType> personTypes;
  String? apiServiceToken;
  List<Zone> zones;
  List<Seller> sellers;

  factory InitParamsClientModel.fromJson(Map<String, dynamic> json) {
    return InitParamsClientModel(
      countries:
          List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
      departments: List<Country>.from(
          json["departments"].map((x) => Country.fromJson(x))),
      provinces: List<Province>.from(
          json["provinces"].map((x) => Province.fromJson(x))),
      districts:
          List<Country>.from(json["districts"].map((x) => Country.fromJson(x))),
      identityDocumentTypes: List<IdentityDocumentType>.from(
          json["identity_document_types"]
              .map((x) => IdentityDocumentType.fromJson(x))),
      locations: List<Location>.from(
          json["locations"].map((x) => Location.fromJson(x))),
      personTypes: List<PersonType>.from(
          json["person_types"].map((x) => PersonType.fromJson(x))),
      apiServiceToken:
          json["api_service_token"] == null ? null : json["api_service_token"],
      zones: List<Zone>.from(json["zones"].map((x) => Zone.fromJson(x))),
      sellers:
          List<Seller>.from(json["sellers"].map((x) => Seller.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
        "departments": List<dynamic>.from(departments.map((x) => x.toJson())),
        "provinces": List<dynamic>.from(provinces.map((x) => x.toJson())),
        "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
        "identity_document_types":
            List<dynamic>.from(identityDocumentTypes.map((x) => x.toJson())),
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "person_types": List<dynamic>.from(personTypes.map((x) => x.toJson())),
        "api_service_token": apiServiceToken == null ? null : apiServiceToken,
        "zones": List<dynamic>.from(zones.map((x) => x.toJson())),
        "sellers": List<dynamic>.from(sellers.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    required this.id,
    required this.departmentId,
    required this.description,
    required this.active,
    required this.districts,
  });

  String id;
  String departmentId;
  String description;
  int active;
  List<Country> districts;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        departmentId: json["department_id"],
        description: json["description"],
        active: json["active"],
        districts: json["districts"] != null
            ? List<Country>.from(
                json["districts"].map((x) => Country.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_id": departmentId,
        "description": description,
        "active": active,
        "districts": List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}

class Country {
  Country({
    required this.id,
    required this.description,
    required this.active,
    this.provinces,
    this.provinceId,
  });

  String id;
  String description;
  int active;
  List<Province>? provinces;
  String? provinceId;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        description: json["description"],
        active: json["active"],
        provinces: json["provinces"] == null
            ? null
            : List<Province>.from(
                json["provinces"].map((x) => Province.fromJson(x))),
        provinceId: json["province_id"] == null ? null : json["province_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "active": active,
        "provinces": provinces == null
            ? null
            : List<dynamic>.from(provinces!.map((x) => x.toJson())),
        "province_id": provinceId == null ? null : provinceId,
      };
}

class IdentityDocumentType {
  IdentityDocumentType({
    required this.id,
    required this.active,
    required this.description,
  });

  String id;
  bool active;
  String description;

  factory IdentityDocumentType.fromJson(Map<String, dynamic> json) =>
      IdentityDocumentType(
        id: json["id"],
        active: json["active"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "description": description,
      };
}

class Location {
  Location({
    required this.value,
    required this.label,
    required this.children,
  });

  String value;
  String label;
  List<LocationChild> children;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        value: json["value"],
        label: json["label"],
        children: List<LocationChild>.from(
            json["children"].map((x) => LocationChild.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class LocationChild {
  LocationChild({
    required this.value,
    required this.label,
    required this.children,
  });

  String value;
  String label;
  List<ChildChild> children;

  factory LocationChild.fromJson(Map<String, dynamic> json) => LocationChild(
        value: json["value"],
        label: json["label"],
        children: List<ChildChild>.from(
            json["children"].map((x) => ChildChild.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class ChildChild {
  ChildChild({
    required this.value,
    required this.label,
  });

  String value;
  String label;

  factory ChildChild.fromJson(Map<String, dynamic> json) => ChildChild(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}

class PersonType {
  PersonType({
    required this.id,
    required this.description,
  });

  int id;
  String description;

  factory PersonType.fromJson(Map<String, dynamic> json) => PersonType(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}

class Seller {
  Seller({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Zone {
  Zone({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
