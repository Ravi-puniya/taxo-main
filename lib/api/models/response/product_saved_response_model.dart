import 'dart:convert';

ProductSavedResponseModel productSavedResponseModelFromJson(String str) {
  return ProductSavedResponseModel.fromJson(json.decode(str));
}

String productSavedResponseModelToJson(ProductSavedResponseModel data) {
  return json.encode(data.toJson());
}

class ProductSavedResponseModel {
  ProductSavedResponseModel({
    required this.success,
    required this.message,
    required this.id,
  });

  bool success;
  String message;
  int id;

  factory ProductSavedResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductSavedResponseModel(
      success: json["success"],
      message: json["message"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "id": id,
    };
  }
}
