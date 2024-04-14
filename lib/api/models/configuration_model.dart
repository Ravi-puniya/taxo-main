import 'dart:convert';

ConfigurationModel configurationModelFromJson(String str) =>
    ConfigurationModel.fromJson(json.decode(str));

String configurationModelToJson(ConfigurationModel data) =>
    json.encode(data.toJson());

class ConfigurationModel {
  ConfigurationModel({
    required this.data,
  });

  ConfigurationData data;

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) =>
      ConfigurationModel(
        data: ConfigurationData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class ConfigurationData {
  ConfigurationData({
    required this.id,
    required this.company,
    required this.establishment,
  });

  int id;
  Company company;
  Establishment establishment;

  factory ConfigurationData.fromJson(Map<String, dynamic> json) =>
      ConfigurationData(
        id: json["id"],
        company: Company.fromJson(json["company"]),
        establishment: Establishment.fromJson(json["establishment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company": company.toJson(),
        "establishment": establishment.toJson(),
      };
}

class Company {
  Company({
    required this.id,
    required this.name,
    required this.tradeName,
    this.logo,
  });

  int id;
  String name;
  String tradeName;
  String? logo;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        tradeName: json["trade_name"],
        logo: json["logo"] == null ? null : json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "trade_name": tradeName,
        "logo": logo == null ? null : logo,
      };
}

class Establishment {
  Establishment({
    required this.id,
    required this.description,
    this.logo,
  });

  int id;
  String description;
  String? logo;

  factory Establishment.fromJson(Map<String, dynamic> json) => Establishment(
        id: json["id"],
        description: json["description"],
        logo: json["logo"] == null ? null : json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "logo": logo == null ? null : logo,
      };
}
