import 'dart:convert';

import 'package:facturadorpro/api/models/part/pagination.dart';
import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';

ProductListResponseModel productListResponseModelFromJson(String str) {
  return ProductListResponseModel.fromJson(json.decode(str));
}

String productListResponseModelToJson(ProductListResponseModel data) {
  return json.encode(data.toJson());
}

class ProductListResponseModel {
  ProductListResponseModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<ProductData> data;
  Links links;
  Meta meta;

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductListResponseModel(
      data: List<ProductData>.from(
        json["data"].map((x) => ProductData.fromJson(x)),
      ),
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

class ProductData {
  ProductData({
    required this.id,
    required this.unitTypeId,
    required this.unitTypeText,
    required this.description,
    this.name,
    this.model,
    this.barcode,
    this.brand,
    this.categoryDescription,
    this.internalId,
    required this.stock,
    required this.stockMin,
    required this.currencyTypeId,
    required this.currencyTypeSymbol,
    required this.saleAffectationIgvTypeId,
    required this.purchaseAffectationIgvTypeId,
    required this.amountSaleUnitPrice,
    required this.calculateQuantity,
    required this.hasIgv,
    required this.active,
    required this.hasIgvDescription,
    required this.purchaseHasIgvDescription,
    required this.saleUnitPrice,
    required this.saleUnitPriceWithIgv,
    required this.purchaseUnitPrice,
    required this.warehouses,
    required this.imageUrl,
    required this.imageUrlMedium,
    required this.imageUrlSmall,
    required this.itemUnitTypes,
    required this.itemWarehousePrices,
  });

  int id;
  String unitTypeId;
  String unitTypeText;
  String description;
  String? name;
  String? model;
  String? barcode;
  String? brand;
  String? categoryDescription;
  String? internalId;
  String stock;
  String stockMin;
  String currencyTypeId;
  String currencyTypeSymbol;
  String saleAffectationIgvTypeId;
  String purchaseAffectationIgvTypeId;
  double amountSaleUnitPrice;
  bool calculateQuantity;
  bool hasIgv;
  bool active;
  String hasIgvDescription;
  String purchaseHasIgvDescription;
  String saleUnitPrice;
  String saleUnitPriceWithIgv;
  String purchaseUnitPrice;
  List<Warehouse> warehouses;
  String imageUrl;
  String imageUrlMedium;
  String imageUrlSmall;
  List<ItemUnitTypeList> itemUnitTypes;
  List<ItemWarehousePrice> itemWarehousePrices;

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json["id"],
      unitTypeId: json["unit_type_id"],
      unitTypeText: json["unit_type_text"],
      description: json["description"],
      name: json["name"] == null ? null : json["name"],
      model: json["model"] == null ? null : json["model"],
      barcode: json["barcode"] == null ? null : json["barcode"],
      brand: json["brand"] == null ? null : json["brand"],
      categoryDescription: json["category_description"] == null
          ? null
          : json["category_description"],
      internalId: json["internal_id"] == null ? null : json["internal_id"],
      stock: json["stock"],
      stockMin: json["stock_min"],
      currencyTypeId: json["currency_type_id"],
      currencyTypeSymbol: json["currency_type_symbol"],
      saleAffectationIgvTypeId: json["sale_affectation_igv_type_id"],
      purchaseAffectationIgvTypeId: json["purchase_affectation_igv_type_id"],
      amountSaleUnitPrice: json["amount_sale_unit_price"] is String
          ? double.parse(json["amount_sale_unit_price"])
          : json["amount_sale_unit_price"].toDouble(),
      calculateQuantity: json["calculate_quantity"],
      hasIgv: json["has_igv"],
      active: json["active"],
      hasIgvDescription: json["has_igv_description"],
      purchaseHasIgvDescription: json["purchase_has_igv_description"],
      saleUnitPrice: json["sale_unit_price"],
      saleUnitPriceWithIgv: json["sale_unit_price_with_igv"],
      purchaseUnitPrice: json["purchase_unit_price"],
      warehouses: List<Warehouse>.from(
        json["warehouses"].map((x) => Warehouse.fromJson(x)),
      ),
      imageUrl: json["image_url"],
      imageUrlMedium: json["image_url_medium"],
      imageUrlSmall: json["image_url_small"],
      itemUnitTypes: List<ItemUnitTypeList>.from(
        json["item_unit_types"].map((x) => ItemUnitTypeList.fromJson(x)),
      ),
      itemWarehousePrices: List<ItemWarehousePrice>.from(
        json["item_warehouse_prices"].map(
          (x) => ItemWarehousePrice.fromJson(x),
        ),
      ),
    );
  }
  dynamic convertToNumberOrString(dynamic value) {
    if (value is String) {
      return double.tryParse(value) ?? value;
    } else {
      return value;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "unit_type_id": unitTypeId,
      "unit_type_text": unitTypeText,
      "description": description,
      "name": name == null ? null : name,
      "model": model == null ? null : model,
      "barcode": barcode == null ? null : barcode,
      "brand": brand == null ? null : brand,
      "category_description":
          categoryDescription == null ? null : categoryDescription,
      "internal_id": internalId == null ? null : internalId,
      "stock": stock,
      "stock_min": stockMin,
      "currency_type_id": currencyTypeId,
      "currency_type_symbol": currencyTypeSymbol,
      "sale_affectation_igv_type_id": saleAffectationIgvTypeId,
      "purchase_affectation_igv_type_id": purchaseAffectationIgvTypeId,
      "amount_sale_unit_price": amountSaleUnitPrice,
      "calculate_quantity": calculateQuantity,
      "has_igv": hasIgv,
      "active": active,
      "has_igv_description": hasIgvDescription,
      "purchase_has_igv_description": purchaseHasIgvDescription,
      "sale_unit_price": saleUnitPrice,
      "sale_unit_price_with_igv": saleUnitPriceWithIgv,
      "purchase_unit_price": purchaseUnitPrice,
      "warehouses": List<dynamic>.from(warehouses.map((x) => x.toJson())),
      "image_url": imageUrl,
      "image_url_medium": imageUrlMedium,
      "image_url_small": imageUrlSmall,
      "item_unit_types": List<dynamic>.from(
        itemUnitTypes.map((x) => x.toJson()),
      ),
      "item_warehouse_prices": List<dynamic>.from(
        itemWarehousePrices.map((x) => x.toJson()),
      ),
    };
  }
}

class ItemUnitTypeList {
  ItemUnitTypeList({
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

  factory ItemUnitTypeList.fromJson(Map<String, dynamic> json) {
    return ItemUnitTypeList(
      id: json["id"],
      description: json["description"],
      itemId: json["item_id"],
      unitTypeId: json["unit_type_id"],
      quantityUnit: json["quantity_unit"],
      price1: json["price1"],
      price2: json["price2"],
      price3: json["price3"],
      priceDefault: json["price_default"],
      barcode: json["barcode"],
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
      "barcode": barcode,
    };
  }
}

class ItemWarehousePrice {
  ItemWarehousePrice({
    required this.id,
    required this.itemId,
    required this.warehouseId,
    required this.price,
    required this.description,
  });

  int id;
  int itemId;
  int warehouseId;
  double price;
  String description;

  factory ItemWarehousePrice.fromJson(Map<String, dynamic> json) {
    return ItemWarehousePrice(
      id: json["id"],
      itemId: json["item_id"],
      warehouseId: json["warehouse_id"],
      price: double.parse(json["price"].toString()),
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "item_id": itemId,
      "warehouse_id": warehouseId,
      "price": price,
      "description": description,
    };
  }
}
