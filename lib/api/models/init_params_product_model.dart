import 'dart:convert';

import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';
import 'package:facturadorpro/api/models/response/init_params_pos.dart';

InitParamsProductModel initParamsProductModelFromJson(String str) {
  return InitParamsProductModel.fromJson(json.decode(str));
}

String initParamsProductModelToJson(InitParamsProductModel data) {
  return json.encode(data.toJson());
}

class InitParamsProductModel {
  InitParamsProductModel({
    required this.unitTypes,
    required this.currencyTypes,
    required this.attributeTypes,
    required this.affectationIgvTypes,
    required this.warehouses,
    required this.categories,
    required this.brands,
    required this.configuration,
  });

  List<UnitType> unitTypes;
  List<CurrencyType> currencyTypes;
  List<Type> attributeTypes;
  List<AffectationIgvType> affectationIgvTypes;
  List<Warehouses> warehouses;
  List<Category> categories;
  List<Brand> brands;
  Configuration configuration;

  factory InitParamsProductModel.fromJson(Map<String, dynamic> json) {
    return InitParamsProductModel(
      unitTypes: List<UnitType>.from(
        json["unit_types"].map((x) => UnitType.fromJson(x)),
      ),
      currencyTypes: List<CurrencyType>.from(
        json["currency_types"].map((x) => CurrencyType.fromJson(x)),
      ),
      attributeTypes: List<Type>.from(
        json["attribute_types"].map((x) => Type.fromJson(x)),
      ),
      affectationIgvTypes: List<AffectationIgvType>.from(
        json["affectation_igv_types"].map(
          (x) => AffectationIgvType.fromJson(x),
        ),
      ),
      warehouses: List<Warehouses>.from(
        json["warehouses"].map((x) => Warehouses.fromJson(x)),
      ),
      categories: List<Category>.from(
        json["categories"].map((x) => Category.fromJson(x)),
      ),
      brands: List<Brand>.from(
        json["brands"].map(
          (x) => Brand.fromJson(x),
        ),
      ),
      configuration: Configuration.fromJson(json["configuration"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "unit_types": List<dynamic>.from(unitTypes.map((x) => x.toJson())),
      "currency_types": List<dynamic>.from(
        currencyTypes.map((x) => x.toJson()),
      ),
      "attribute_types": List<dynamic>.from(
        attributeTypes.map((x) => x.toJson()),
      ),
      "affectation_igv_types": List<dynamic>.from(
        affectationIgvTypes.map((x) => x.toJson()),
      ),
      "warehouses": List<dynamic>.from(warehouses.map((x) => x.toJson())),
      "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      "brands": List<dynamic>.from(brands.map((x) => x.toJson())),
      "configuration": configuration.toJson(),
    };
  }
}

class Type {
  Type({
    required this.id,
    required this.active,
    required this.description,
    this.symbol,
  });

  String id;
  int active;
  String description;
  String? symbol;

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json["id"],
      active: json["active"],
      description: json["description"],
      symbol: json["symbol"] == null ? null : json["symbol"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "active": active,
      "description": description,
      "symbol": symbol == null ? null : symbol,
    };
  }
}

class Brand {
  Brand({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

class Warehouses {
  Warehouses({
    required this.id,
    required this.establishmentId,
    required this.description,
  });

  int id;
  int establishmentId;
  String description;

  factory Warehouses.fromJson(Map<String, dynamic> json) {
    return Warehouses(
      id: json["id"],
      establishmentId: json["establishment_id"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "establishment_id": establishmentId,
      "description": description,
    };
  }
}

class Configuration {
  Configuration({
    required this.affectationIgvTypeId,
    required this.warehouseId,
    required this.includeIgv,
  });

  String affectationIgvTypeId;
  int? warehouseId;
  bool includeIgv;

  factory Configuration.fromJson(Map<String, dynamic> json) {
    return Configuration(
      affectationIgvTypeId: json["affectation_igv_type_id"],
      warehouseId: json["warehouse_id"],
      includeIgv: json["include_igv"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "affectation_igv_type_id": affectationIgvTypeId,
      "warehouse_id": warehouseId,
      "include_igv": includeIgv,
    };
  }
}
