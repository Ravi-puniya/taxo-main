import 'dart:convert';

import 'package:facturadorpro/api/models/response/pos_payments_params_model.dart';

FilterSaleNotesParamsResponse filterSaleNotesParamsResponseFromJson(
  String str,
) {
  return FilterSaleNotesParamsResponse.fromJson(json.decode(str));
}

String filterSaleNotesParamsResponseToJson(
  FilterSaleNotesParamsResponse data,
) {
  return json.encode(data.toJson());
}

class FilterSaleNotesParamsResponse {
  FilterSaleNotesParamsResponse({
    required this.series,
  });

  List<Series> series;

  factory FilterSaleNotesParamsResponse.fromJson(Map<String, dynamic> json) {
    return FilterSaleNotesParamsResponse(
      series: List<Series>.from(json["series"].map((x) => Series.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "series": List<dynamic>.from(series.map((x) => x.toJson())),
    };
  }
}
