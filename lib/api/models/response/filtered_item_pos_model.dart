import 'dart:convert';

import 'package:facturadorpro/api/models/part/pagination.dart';

FilteredItemPosModel filteredItemPosModelFromJson(String str) {
  return FilteredItemPosModel.fromJson(json.decode(str));
}

String filteredItemPosModelToJson(FilteredItemPosModel data) {
  return json.encode(data.toJson());
}

class FilteredItemPosModel {
  FilteredItemPosModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<ItemPos> data;
  Links links;
  Meta meta;

  factory FilteredItemPosModel.fromJson(Map<String, dynamic> json) {
    return FilteredItemPosModel(
      data: List<ItemPos>.from(json["data"].map((x) => ItemPos.fromJson(x))),
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

class ItemPos {
  ItemPos({
    required this.id,
    required this.itemId,
    this.stock,
    required this.fullDescription,
    required this.description,
    this.previousDescription,
    required this.currencyTypeId,
    this.internalId,
    required this.currencyTypeSymbol,
    required this.saleUnitPrice,
    required this.purchaseUnitPrice,
    required this.unitTypeId,
    required this.saleAffectationIgvTypeId,
    required this.purchaseAffectationIgvTypeId,
    required this.calculateQuantity,
    required this.hasIgv,
    required this.isSet,
    required this.editUnitPrice,
    required this.auxQuantity,
    required this.editSaleUnitPrice,
    required this.auxSaleUnitPrice,
    required this.imageUrl,
    required this.warehouses,
    this.categoryId,
    required this.unitType,
    required this.category,
    required this.brand,
    required this.hasPlasticBagTaxes,
    required this.amountPlasticBagTaxes,
    required this.hasIsc,
    required this.percentageIsc,
    required this.isBarcode,
    this.presentation,
  });

  int id;
  int itemId;
  String? stock;
  String fullDescription;
  String description;
  String? previousDescription;
  String currencyTypeId;
  String? internalId;
  String currencyTypeSymbol;
  String saleUnitPrice;
  double purchaseUnitPrice;
  String unitTypeId;
  String saleAffectationIgvTypeId;
  String purchaseAffectationIgvTypeId;
  bool calculateQuantity;
  bool hasIgv;
  bool isSet;
  bool editUnitPrice;
  int auxQuantity;
  String editSaleUnitPrice;
  String auxSaleUnitPrice;
  String imageUrl;
  List<Warehouse> warehouses;
  int? categoryId;
  List<Presentation> unitType;
  String category;
  String brand;
  bool hasPlasticBagTaxes;
  String amountPlasticBagTaxes;
  bool hasIsc;
  String percentageIsc;
  bool isBarcode;
  Presentation? presentation;

  factory ItemPos.fromJson(Map<String, dynamic> json) {
    return ItemPos(
      id: json["id"],
      itemId: json["item_id"],
      stock: json["stock"] == null ? null : json["stock"].toString(),
      fullDescription: json["full_description"],
      description: json["description"],
      currencyTypeId: json["currency_type_id"],
      internalId: json["internal_id"] == null ? null : json["internal_id"],
      currencyTypeSymbol: json["currency_type_symbol"],
      saleUnitPrice: json["sale_unit_price"],
      purchaseUnitPrice: json["purchase_unit_price"].toDouble(),
      unitTypeId: json["unit_type_id"],
      saleAffectationIgvTypeId: json["sale_affectation_igv_type_id"],
      purchaseAffectationIgvTypeId: json["purchase_affectation_igv_type_id"],
      calculateQuantity: json["calculate_quantity"],
      hasIgv: json["has_igv"],
      isSet: json["is_set"],
      editUnitPrice: json["edit_unit_price"],
      auxQuantity: json["aux_quantity"],
      editSaleUnitPrice: json["edit_sale_unit_price"],
      auxSaleUnitPrice: json["aux_sale_unit_price"],
      imageUrl: json["image_url"],
      warehouses: List<Warehouse>.from(
          json["warehouses"].map((x) => Warehouse.fromJson(x))),
      categoryId: json["category_id"] == null ? null : json["category_id"],
      unitType: List<Presentation>.from(
          json["unit_type"].map((x) => Presentation.fromJson(x))),
      category: json["category"],
      brand: json["brand"],
      hasPlasticBagTaxes: json["has_plastic_bag_taxes"],
      amountPlasticBagTaxes: json["amount_plastic_bag_taxes"],
      hasIsc: json["has_isc"],
      percentageIsc: json["percentage_isc"],
      isBarcode: json["isBarcode"] == null ? false : json["isBarcode"],
      presentation: json["presentation"] != null
          ? Presentation.fromJson(json["presentation"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "item_id": itemId,
      "stock": stock == null ? null : stock.toString(),
      "full_description": fullDescription,
      "description": description,
      "currency_type_id": currencyTypeId,
      "internal_id": internalId == null ? null : internalId,
      "currency_type_symbol": currencyTypeSymbol,
      "sale_unit_price": saleUnitPrice,
      "purchase_unit_price": purchaseUnitPrice,
      "unit_type_id": unitTypeId,
      "sale_affectation_igv_type_id": saleAffectationIgvTypeId,
      "purchase_affectation_igv_type_id": purchaseAffectationIgvTypeId,
      "calculate_quantity": calculateQuantity,
      "has_igv": hasIgv,
      "is_set": isSet,
      "edit_unit_price": editUnitPrice,
      "aux_quantity": auxQuantity,
      "edit_sale_unit_price": editSaleUnitPrice,
      "aux_sale_unit_price": auxSaleUnitPrice,
      "image_url": imageUrl,
      "warehouses": List<dynamic>.from(warehouses.map((x) => x.toJson())),
      "category_id": categoryId == null ? null : categoryId,
      "unit_type": List<dynamic>.from(unitType.map((x) => x)),
      "category": category,
      "brand": brand,
      "has_plastic_bag_taxes": hasPlasticBagTaxes,
      "amount_plastic_bag_taxes": amountPlasticBagTaxes,
      "has_isc": hasIsc,
      "percentage_isc": percentageIsc,
      "is_barcode": isBarcode,
      "presentation": presentation == null ? null : presentation,
    };
  }
}

class Warehouse {
  Warehouse({
    required this.warehouseDescription,
    required this.stock,
  });

  String warehouseDescription;
  String stock;

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      warehouseDescription: json["warehouse_description"],
      stock: json["stock"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "warehouse_description": warehouseDescription,
      "stock": stock.toString(),
    };
  }
}

class Presentation {
  Presentation({
    required this.id,
    required this.description,
    required this.itemId,
    required this.unitTypeId,
    required this.quantityUnit,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.priceDefault,
    this.barcode,
    required this.unitType,
  });

  int id;
  String description;
  int itemId;
  String unitTypeId;
  String quantityUnit;
  String price1;
  String price2;
  String price3;
  int priceDefault;
  String? barcode;
  UnitType unitType;

  factory Presentation.fromJson(Map<String, dynamic> json) {
    return Presentation(
      id: json["id"],
      description: json["description"],
      itemId: json["item_id"],
      unitTypeId: json["unit_type_id"],
      quantityUnit: json["quantity_unit"],
      price1: json["price1"],
      price2: json["price2"],
      price3: json["price3"],
      priceDefault: json["price_default"],
      barcode: json["barcode"] == null ? null : json["barcode"],
      unitType: UnitType.fromJson(json["unit_type"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "item_id": itemId,
      "unit_type_id": unitTypeId,
      "quantity_unit": quantityUnit,
      "price1": price1,
      "price2": price2,
      "price3": price3,
      "price_default": priceDefault,
      "barcode": barcode == null ? null : barcode,
      "unit_type": unitType.toJson(),
    };
  }
}

class UnitType {
  UnitType({
    required this.id,
    required this.active,
    this.symbol,
    required this.description,
  });

  String id;
  int active;
  String? symbol;
  String description;

  factory UnitType.fromJson(Map<String, dynamic> json) {
    return UnitType(
      id: json["id"],
      active: json["active"],
      symbol: json["symbol"] == null ? null : json["symbol"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "active": active,
      "symbol": symbol == null ? null : symbol,
      "description": description,
    };
  }
}
