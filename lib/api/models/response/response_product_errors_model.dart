import 'dart:convert';

ResponseProductErrorsModel responseProductErrorsModelFromJson(String str) =>
    ResponseProductErrorsModel.fromJson(json.decode(str));

String responseProductErrorsModelToJson(ResponseProductErrorsModel data) =>
    json.encode(data.toJson());

class ResponseProductErrorsModel {
  ResponseProductErrorsModel({
    this.success,
    this.message,
    this.file,
    this.line,
  });

  bool? success;
  Message? message;
  String? file;
  int? line;

  factory ResponseProductErrorsModel.fromJson(Map<String, dynamic> json) =>
      ResponseProductErrorsModel(
        success: json["success"] == null ? null : json["success"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        file: json["file"] == null ? null : json["file"],
        line: json["line"] == null ? null : json["line"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message!.toJson(),
        "file": file == null ? null : file,
        "line": line == null ? null : line,
      };
}

class Message {
  Message({
    this.description,
    this.unitTypeId,
    this.currencyTypeId,
    this.saleUnitPrice,
    this.purchaseUnitPrice,
    this.stock,
    this.stockMin,
    this.saleAffectationIgvTypeId,
    this.purchaseAffectationIgvTypeId,
  });

  List<String>? description;
  List<String>? unitTypeId;
  List<String>? currencyTypeId;
  List<String>? saleUnitPrice;
  List<String>? purchaseUnitPrice;
  List<String>? stock;
  List<String>? stockMin;
  List<String>? saleAffectationIgvTypeId;
  List<String>? purchaseAffectationIgvTypeId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        description: json["description"] == null
            ? null
            : List<String>.from(json["description"].map((x) => x)),
        unitTypeId: json["unit_type_id"] == null
            ? null
            : List<String>.from(json["unit_type_id"].map((x) => x)),
        currencyTypeId: json["currency_type_id"] == null
            ? null
            : List<String>.from(json["currency_type_id"].map((x) => x)),
        saleUnitPrice: json["sale_unit_price"] == null
            ? null
            : List<String>.from(json["sale_unit_price"].map((x) => x)),
        purchaseUnitPrice: json["purchase_unit_price"] == null
            ? null
            : List<String>.from(json["purchase_unit_price"].map((x) => x)),
        stock: json["stock"] == null
            ? null
            : List<String>.from(json["stock"].map((x) => x)),
        stockMin: json["stock_min"] == null
            ? null
            : List<String>.from(json["stock_min"].map((x) => x)),
        saleAffectationIgvTypeId: json["sale_affectation_igv_type_id"] == null
            ? null
            : List<String>.from(
                json["sale_affectation_igv_type_id"].map((x) => x)),
        purchaseAffectationIgvTypeId:
            json["purchase_affectation_igv_type_id"] == null
                ? null
                : List<String>.from(
                    json["purchase_affectation_igv_type_id"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description == null
            ? null
            : List<dynamic>.from(description!.map((x) => x)),
        "unit_type_id": unitTypeId == null
            ? null
            : List<dynamic>.from(unitTypeId!.map((x) => x)),
        "currency_type_id": currencyTypeId == null
            ? null
            : List<dynamic>.from(currencyTypeId!.map((x) => x)),
        "sale_unit_price": saleUnitPrice == null
            ? null
            : List<dynamic>.from(saleUnitPrice!.map((x) => x)),
        "purchase_unit_price": purchaseUnitPrice == null
            ? null
            : List<dynamic>.from(purchaseUnitPrice!.map((x) => x)),
        "stock":
            stock == null ? null : List<dynamic>.from(stock!.map((x) => x)),
        "stock_min": stockMin == null
            ? null
            : List<dynamic>.from(stockMin!.map((x) => x)),
        "sale_affectation_igv_type_id": saleAffectationIgvTypeId == null
            ? null
            : List<dynamic>.from(saleAffectationIgvTypeId!.map((x) => x)),
        "purchase_affectation_igv_type_id": purchaseAffectationIgvTypeId == null
            ? null
            : List<dynamic>.from(purchaseAffectationIgvTypeId!.map((x) => x)),
      };
}
