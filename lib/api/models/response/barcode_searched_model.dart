import 'dart:convert';

import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';

BarcodeSearchedModel barcodeSearchedModelFromJson(String str) {
  return BarcodeSearchedModel.fromJson(json.decode(str));
}

String barcodeSearchedModelToJson(BarcodeSearchedModel data) {
  return json.encode(data.toJson());
}

class BarcodeSearchedModel {
  BarcodeSearchedModel({
    required this.items,
  });

  List<ItemPos> items;

  factory BarcodeSearchedModel.fromJson(Map<String, dynamic> json) {
    return BarcodeSearchedModel(
      items: List<ItemPos>.from(
        json["items"].map((x) => ItemPos.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
  }
}
