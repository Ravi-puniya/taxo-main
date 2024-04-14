import 'dart:convert';

import 'package:facturadorpro/api/models/response/pos_payments_params_model.dart';

FilterVoucherParamsResponse filterVoucherParamsResponseFromJson(String str) {
  return FilterVoucherParamsResponse.fromJson(json.decode(str));
}

String filterVoucherParamsResponseToJson(FilterVoucherParamsResponse data) {
  return json.encode(data.toJson());
}

class FilterVoucherParamsResponse {
  FilterVoucherParamsResponse({
    required this.customers,
    required this.documentTypes,
    required this.series,
    required this.stateTypes,
  });

  List<CustomerFilter> customers;
  List<DocumentType> documentTypes;
  List<Series> series;
  List<StateType> stateTypes;

  factory FilterVoucherParamsResponse.fromJson(Map<String, dynamic> json) {
    return FilterVoucherParamsResponse(
      customers: List<CustomerFilter>.from(
        json["customers"].map((x) => CustomerFilter.fromJson(x)),
      ),
      documentTypes: List<DocumentType>.from(
        json["document_types"].map((x) => DocumentType.fromJson(x)),
      ),
      series: List<Series>.from(
        json["series"].map((x) => Series.fromJson(x)),
      ),
      stateTypes: List<StateType>.from(
        json["state_types"].map((x) => StateType.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
      "document_types": List<dynamic>.from(
        documentTypes.map((x) => x.toJson()),
      ),
      "series": List<dynamic>.from(series.map((x) => x.toJson())),
      "state_types": List<dynamic>.from(stateTypes.map((x) => x.toJson())),
    };
  }
}

class CustomerFilter {
  CustomerFilter({
    required this.id,
    required this.description,
    required this.name,
    required this.number,
  });

  int id;
  String description;
  String name;
  String number;

  factory CustomerFilter.fromJson(Map<String, dynamic> json) {
    return CustomerFilter(
      id: json["id"],
      description: json["description"],
      name: json["name"],
      number: json["number"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "name": name,
      "number": number,
    };
  }
}

class DocumentType {
  DocumentType({
    required this.id,
    required this.description,
    required this.short,
  });

  String id;
  String description;
  String short;

  factory DocumentType.fromJson(Map<String, dynamic> json) {
    return DocumentType(
      id: json["id"],
      description: json["description"],
      short: json["short"] == null ? null : json["short"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "short": short == null ? null : short,
    };
  }
}

class StateType {
  StateType({
    required this.id,
    required this.description,
  });

  String id;
  String description;

  factory StateType.fromJson(Map<String, dynamic> json) {
    return StateType(
      id: json["id"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
    };
  }
}
