import 'package:facturadorpro/api/models/part/item_unit_type.dart';

class ProductRequestModel {
  ProductRequestModel({
    this.id,
    this.colors,
    this.itemTypeId,
    this.internalId,
    this.itemCode,
    this.itemCodeGs1,
    this.description,
    this.name,
    this.secondName,
    this.unitTypeId,
    this.currencyTypeId,
    this.saleUnitPrice,
    this.purchaseUnitPrice,
    this.hasIsc,
    this.systemIscTypeId,
    this.percentageIsc,
    this.suggestedPrice,
    this.saleAffectationIgvTypeId,
    this.purchaseAffectationIgvTypeId,
    this.calculateQuantity,
    this.stock,
    this.stockMin,
    this.hasIgv,
    this.hasPerception,
    this.itemUnitTypes,
    this.percentageOfProfit,
    this.percentagePerception,
    this.image,
    this.imageUrl,
    this.tempPath,
    this.isSet,
    this.accountId,
    this.categoryId,
    this.brandId,
    this.dateOfDue,
    this.lotCode,
    this.line,
    this.lotsEnabled,
    this.lots,
    this.attributes,
    this.seriesEnabled,
    this.purchaseHasIgv,
    this.webPlatformId,
    this.hasPlasticBagTaxes,
    this.itemWarehousePrices,
    this.itemSupplies,
    this.purchaseHasIsc,
    this.purchaseSystemIscTypeId,
    this.purchasePercentageIsc,
    this.subjectToDetraction,
    this.warehouseId,
    this.barcode,
  });

  dynamic id;
  List<dynamic>? colors;
  String? itemTypeId;
  String? internalId;
  dynamic? itemCode;
  dynamic? itemCodeGs1;
  String? description;
  String? name;
  String? secondName;
  String? unitTypeId;
  String? currencyTypeId;
  String? saleUnitPrice;
  int? purchaseUnitPrice;
  bool? hasIsc;
  dynamic? systemIscTypeId;
  int? percentageIsc;
  int? suggestedPrice;
  String? saleAffectationIgvTypeId;
  String? purchaseAffectationIgvTypeId;
  bool? calculateQuantity;
  String? stock;
  String? stockMin;
  bool? hasIgv;
  bool? hasPerception;
  List<ItemUnitType>? itemUnitTypes;
  int? percentageOfProfit;
  dynamic? percentagePerception;
  dynamic? image;
  dynamic? imageUrl;
  dynamic? tempPath;
  bool? isSet;
  dynamic accountId;
  dynamic categoryId;
  dynamic brandId;
  dynamic dateOfDue;
  dynamic lotCode;
  dynamic line;
  bool? lotsEnabled;
  List<dynamic>? lots;
  List<dynamic>? attributes;
  bool? seriesEnabled;
  bool? purchaseHasIgv;
  dynamic? webPlatformId;
  bool? hasPlasticBagTaxes;
  List<ItemWarehousePrice>? itemWarehousePrices;
  List<dynamic>? itemSupplies;
  bool? purchaseHasIsc;
  dynamic? purchaseSystemIscTypeId;
  int? purchasePercentageIsc;
  bool? subjectToDetraction;
  int? warehouseId;
  String? barcode;
}

class ItemWarehousePrice {
  ItemWarehousePrice({
    this.id,
    this.itemId,
    this.warehouseId,
    this.price,
    this.description,
  });

  dynamic? id;
  dynamic? itemId;
  int? warehouseId;
  String? price;
  String? description;
}
