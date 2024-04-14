import 'dart:convert';

ProductRetrievedModel productRetrievedModelFromJson(String str) {
  return ProductRetrievedModel.fromJson(json.decode(str));
}

String productRetrievedModelToJson(ProductRetrievedModel data) {
  return json.encode(data.toJson());
}

class ProductRetrievedModel {
  ProductRetrievedModel({
    this.data,
  });

  RetrievedItem? data;

  factory ProductRetrievedModel.fromJson(Map<String, dynamic> json) {
    return ProductRetrievedModel(
      data: json["data"] == null ? null : RetrievedItem.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data == null ? null : data!.toJson(),
    };
  }
}

class RetrievedItem {
  RetrievedItem({
    required this.id,
    required this.description,
    this.name,
    this.model,
    this.barcode,
    this.warehouseId,
    this.internalId,
    this.currencyTypeId,
    required this.saleUnitPrice,
    required this.purchaseUnitPrice,
    required this.unitTypeId,
    required this.stock,
    required this.stockMin,
    required this.saleAffectationIgvTypeId,
    required this.purchaseAffectationIgvTypeId,
    required this.calculateQuantity,
    required this.hasIgv,
    required this.purchaseHasIgv,
    required this.itemUnitTypes,
    this.categoryId,
    this.brandId,
    this.dateOfDue,
  });

  int id;
  String description;
  String? name;
  String? model;
  String? barcode;
  int? warehouseId;
  String? internalId;
  String? currencyTypeId;
  double saleUnitPrice;
  double purchaseUnitPrice;
  String unitTypeId;
  String stock;
  String stockMin;
  String saleAffectationIgvTypeId;
  String purchaseAffectationIgvTypeId;
  bool calculateQuantity;
  bool hasIgv;
  bool purchaseHasIgv;
  List<ItemUnitTypeRetrieve> itemUnitTypes;
  int? categoryId;
  int? brandId;
  String? dateOfDue;

  factory RetrievedItem.fromJson(Map<String, dynamic> json) => RetrievedItem(
        id: json["id"],
        description: json["description"],
        name: json["name"] == null ? null : json["name"],
        model: json["model"] == null ? null : json["model"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        warehouseId: json["warehouse_id"] == null ? null : json["warehouse_id"],
        internalId: json["internal_id"] == null ? null : json["internal_id"],
        currencyTypeId:
            json["currency_type_id"] == null ? null : json["currency_type_id"],
        saleUnitPrice: json["sale_unit_price"].toDouble(),
        purchaseUnitPrice: json["purchase_unit_price"].toDouble(),
        unitTypeId: json["unit_type_id"],
        stock: json["stock"],
        stockMin: json["stock_min"],
        saleAffectationIgvTypeId: json["sale_affectation_igv_type_id"],
        purchaseAffectationIgvTypeId: json["purchase_affectation_igv_type_id"],
        calculateQuantity: json["calculate_quantity"],
        hasIgv: json["has_igv"],
        purchaseHasIgv: json["purchase_has_igv"],
        itemUnitTypes: List<ItemUnitTypeRetrieve>.from(
          json["item_unit_types"].map((x) => ItemUnitTypeRetrieve.fromJson(x)),
        ),
        categoryId: json["category_id"] == null ? null : json["category_id"],
        brandId: json["brand_id"] == null ? null : json["brand_id"],
        dateOfDue: json["date_of_due"] == null ? null : json["date_of_due"],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "name": name == null ? null : name,
      "model": model == null ? null : model,
      "barcode": barcode == null ? null : barcode,
      "warehouse_id": warehouseId == null ? null : warehouseId,
      "internal_id": internalId == null ? null : internalId,
      "currency_type_id": currencyTypeId == null ? null : currencyTypeId,
      "sale_unit_price": saleUnitPrice,
      "purchase_unit_price": purchaseUnitPrice,
      "unit_type_id": unitTypeId,
      "stock": stock,
      "stock_min": stockMin,
      "sale_affectation_igv_type_id": saleAffectationIgvTypeId,
      "purchase_affectation_igv_type_id": purchaseAffectationIgvTypeId,
      "calculate_quantity": calculateQuantity,
      "has_igv": hasIgv,
      "purchase_has_igv": purchaseHasIgv,
      "item_unit_types":
          List<dynamic>.from(itemUnitTypes.map((x) => x.toJson())),
      "category_id": categoryId == null ? null : categoryId,
      "brand_id": brandId == null ? null : brandId,
      "date_of_due": dateOfDue == null ? null : dateOfDue,
    };
  }
}

class ItemUnitTypeRetrieve {
  ItemUnitTypeRetrieve({
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
  UnitTypeRetrieved unitType;

  factory ItemUnitTypeRetrieve.fromJson(Map<String, dynamic> json) {
    return ItemUnitTypeRetrieve(
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
      unitType: UnitTypeRetrieved.fromJson(json["unit_type"]),
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

class UnitTypeRetrieved {
  UnitTypeRetrieved({
    required this.id,
    required this.active,
    this.symbol,
    required this.description,
  });

  String id;
  int active;
  String? symbol;
  String description;

  factory UnitTypeRetrieved.fromJson(Map<String, dynamic> json) {
    return UnitTypeRetrieved(
      id: json["id"],
      active: json["active"],
      symbol: json["symbol"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "active": active,
      "symbol": symbol,
      "description": description,
    };
  }
}
