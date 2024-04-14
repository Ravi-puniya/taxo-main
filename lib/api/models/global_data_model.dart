import 'dart:convert';

GlobalData globalDataFromJson(String str) =>
    GlobalData.fromJson(json.decode(str));

String globalDataToJson(GlobalData data) => json.encode(data.toJson());

class GlobalData {
  GlobalData({
    required this.totalCpe,
    required this.documentTotalGlobal,
    required this.saleNoteTotalGlobal,
  });

  int totalCpe;
  double documentTotalGlobal;
  double saleNoteTotalGlobal;

  factory GlobalData.fromJson(Map<String, dynamic> json) => GlobalData(
        totalCpe: json["total_cpe"],
        documentTotalGlobal: double.parse(json["document_total_global"]),
        saleNoteTotalGlobal: double.parse(json["sale_note_total_global"]),
      );

  Map<String, dynamic> toJson() => {
        "total_cpe": totalCpe,
        "document_total_global": documentTotalGlobal,
        "sale_note_total_global": saleNoteTotalGlobal,
      };
}
