import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';

class ItemUnitType {
  ItemUnitType({
    this.id,
    required this.description,
    required this.unitTypeId,
    required this.quantityUnit,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.priceDefault,
    this.barcode,
    required this.unitType,
  });

  int? id;
  String description;
  String unitTypeId;
  String quantityUnit;
  String price1;
  String price2;
  String price3;
  int priceDefault;
  String? barcode;
  UnitType unitType;
}
