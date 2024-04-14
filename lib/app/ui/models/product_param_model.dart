import 'package:facturadorpro/api/models/part/item_unit_type.dart';

class ProductParamModel {
  ProductParamModel({
    this.id,
    required this.itemTypeId,
    this.internalId,
    required this.name,
    required this.unitTypeId,
    required this.currencyTypeId,
    required this.saleUnitPrice,
    required this.purchaseUnitPrice,
    required this.saleAffectationIgvTypeId,
    required this.purchaseAffectationIgvTypeId,
    required this.calculateQuantity,
    required this.stock,
    required this.stockMin,
    required this.hasIgv,
    required this.itemUnitTypes,
    this.categoryId,
    this.brandId,
    this.dateOfDue,
    required this.purchaseHasIgv,
    this.model,
    required this.warehouseId,
    this.barcode,
    required this.itemWarehousePrices,
  });

  int? id;
  String itemTypeId;
  String? internalId;
  String name;
  String unitTypeId;
  String currencyTypeId;
  String saleUnitPrice;
  String purchaseUnitPrice;
  String saleAffectationIgvTypeId;
  String purchaseAffectationIgvTypeId;
  bool calculateQuantity;
  String stock;
  int stockMin;
  bool hasIgv;
  List<ItemUnitType> itemUnitTypes;
  int? categoryId;
  int? brandId;
  String? dateOfDue;
  bool purchaseHasIgv;
  String? model;
  int warehouseId;
  String? barcode;
  List<ItemWarehousePrice> itemWarehousePrices;
}

class ItemWarehousePrice {
  ItemWarehousePrice({
    this.id,
    this.itemId,
    required this.warehouseId,
    this.price,
    required this.description,
  });

  int? id;
  int? itemId;
  int warehouseId;
  double? price;
  String description;
}
