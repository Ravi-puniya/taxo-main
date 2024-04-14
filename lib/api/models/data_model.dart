import 'dart:convert';

DataGraph dataGraphFromJson(String str) => DataGraph.fromJson(json.decode(str));

String dataGraphToJson(DataGraph data) => json.encode(data.toJson());

class DataGraph {
  DataGraph({
    this.data,
  });

  Data? data;

  factory DataGraph.fromJson(Map<String, dynamic> json) => DataGraph(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.document,
    this.saleNote,
    this.general,
    this.balance,
    this.items,
  });

  Document? document;
  Document? saleNote;
  General? general;
  Balance? balance;
  List<Item>? items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        document: Document.fromJson(json["document"]),
        saleNote: Document.fromJson(json["sale_note"]),
        general: General.fromJson(json["general"]),
        balance: Balance.fromJson(json["balance"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "document": document?.toJson(),
        "sale_note": saleNote?.toJson(),
        "general": general?.toJson(),
        "balance": balance?.toJson(),
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Balance {
  Balance({
    this.totals,
    this.graph,
  });

  BalanceTotals? totals;
  BalanceGraph? graph;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        totals: BalanceTotals.fromJson(json["totals"]),
        graph: BalanceGraph.fromJson(json["graph"]),
      );

  Map<String, dynamic> toJson() => {
        "totals": totals!.toJson(),
        "graph": graph!.toJson(),
      };
}

class BalanceGraph {
  BalanceGraph({
    this.labels,
    this.datasets,
  });

  List<String>? labels;
  List<PurpleDataset>? datasets;

  factory BalanceGraph.fromJson(Map<String, dynamic> json) => BalanceGraph(
        labels: List<String>.from(json["labels"].map((x) => x)),
        datasets: List<PurpleDataset>.from(
            json["datasets"].map((x) => PurpleDataset.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "labels": List<dynamic>.from(labels!.map((x) => x)),
        "datasets": List<dynamic>.from(datasets!.map((x) => x.toJson())),
      };
}

class MainGraphModel {
  MainGraphModel({
    required this.label,
    required this.value,
  });

  String label;
  double value;
}

class TotalGraphModel {
  TotalGraphModel({
    required this.label,
    required this.totalSalesNotes,
    required this.totalVouchers,
    this.total,
  });

  String label;
  double totalSalesNotes;
  double totalVouchers;
  double? total;
}

class PurpleDataset {
  PurpleDataset({
    this.label,
    this.data,
    this.backgroundColor,
  });

  String? label;
  List<double>? data;
  List<String>? backgroundColor;

  factory PurpleDataset.fromJson(Map<String, dynamic> json) => PurpleDataset(
        label: json["label"],
        data: List<double>.from(json["data"].map((x) => x.toDouble())),
        backgroundColor:
            List<String>.from(json["backgroundColor"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "data": List<dynamic>.from(data!.map((x) => x)),
        "backgroundColor": List<dynamic>.from(backgroundColor!.map((x) => x)),
      };
}

class BalanceTotals {
  BalanceTotals({
    this.totalDocument,
    this.totalPaymentDocument,
    this.totalSaleNote,
    this.totalPaymentSaleNote,
    this.totalPurchase,
    this.totalPaymentPurchase,
    this.totalExpense,
    this.totalPaymentExpense,
    this.allTotals,
    this.allTotalsPayment,
  });

  String? totalDocument;
  String? totalPaymentDocument;
  String? totalSaleNote;
  String? totalPaymentSaleNote;
  String? totalPurchase;
  String? totalPaymentPurchase;
  String? totalExpense;
  String? totalPaymentExpense;
  String? allTotals;
  String? allTotalsPayment;

  factory BalanceTotals.fromJson(Map<String, dynamic> json) => BalanceTotals(
        totalDocument: json["total_document"],
        totalPaymentDocument: json["total_payment_document"],
        totalSaleNote: json["total_sale_note"],
        totalPaymentSaleNote: json["total_payment_sale_note"],
        totalPurchase: json["total_purchase"],
        totalPaymentPurchase: json["total_payment_purchase"],
        totalExpense: json["total_expense"],
        totalPaymentExpense: json["total_payment_expense"],
        allTotals: json["all_totals"],
        allTotalsPayment: json["all_totals_payment"],
      );

  Map<String, dynamic> toJson() => {
        "total_document": totalDocument,
        "total_payment_document": totalPaymentDocument,
        "total_sale_note": totalSaleNote,
        "total_payment_sale_note": totalPaymentSaleNote,
        "total_purchase": totalPurchase,
        "total_payment_purchase": totalPaymentPurchase,
        "total_expense": totalExpense,
        "total_payment_expense": totalPaymentExpense,
        "all_totals": allTotals,
        "all_totals_payment": allTotalsPayment,
      };
}

class Document {
  Document({
    this.totals,
    this.graph,
  });

  DocumentTotals? totals;
  BalanceGraph? graph;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        totals: DocumentTotals.fromJson(json["totals"]),
        graph: BalanceGraph.fromJson(json["graph"]),
      );

  Map<String, dynamic> toJson() => {
        "totals": totals!.toJson(),
        "graph": graph!.toJson(),
      };
}

class DocumentTotals {
  DocumentTotals({
    this.totalPayment,
    this.totalToPay,
    this.total,
  });

  String? totalPayment;
  String? totalToPay;
  String? total;

  factory DocumentTotals.fromJson(Map<String, dynamic> json) => DocumentTotals(
        totalPayment: json["total_payment"],
        totalToPay: json["total_to_pay"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total_payment": totalPayment,
        "total_to_pay": totalToPay,
        "total": total,
      };
}

class General {
  General({
    this.totals,
    this.graph,
  });

  GeneralTotals? totals;
  GeneralGraph? graph;

  factory General.fromJson(Map<String, dynamic> json) => General(
        totals: GeneralTotals.fromJson(json["totals"]),
        graph: GeneralGraph.fromJson(json["graph"]),
      );

  Map<String, dynamic> toJson() => {
        "totals": totals!.toJson(),
        "graph": graph!.toJson(),
      };
}

class GeneralGraph {
  GeneralGraph({
    this.labels,
    this.datasets,
  });

  List<String>? labels;
  List<FluffyDataset>? datasets;

  factory GeneralGraph.fromJson(Map<String, dynamic> json) => GeneralGraph(
        labels: List<String>.from(json["labels"].map((x) => x)),
        datasets: List<FluffyDataset>.from(
            json["datasets"].map((x) => FluffyDataset.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "labels": List<dynamic>.from(labels!.map((x) => x)),
        "datasets": List<dynamic>.from(datasets!.map((x) => x.toJson())),
      };
}

class FluffyDataset {
  FluffyDataset({
    this.label,
    this.data,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.fill,
    this.lineTension,
  });

  String? label;
  List<double>? data;
  String? backgroundColor;
  String? borderColor;
  int? borderWidth;
  bool? fill;
  int? lineTension;

  factory FluffyDataset.fromJson(Map<String, dynamic> json) => FluffyDataset(
        label: json["label"],
        data: List<double>.from(json["data"].map((x) => x.toDouble())),
        backgroundColor: json["backgroundColor"],
        borderColor: json["borderColor"],
        borderWidth: json["borderWidth"],
        fill: json["fill"],
        lineTension: json["lineTension"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "data": List<dynamic>.from(data!.map((x) => x)),
        "backgroundColor": backgroundColor,
        "borderColor": borderColor,
        "borderWidth": borderWidth,
        "fill": fill,
        "lineTension": lineTension,
      };
}

class GeneralTotals {
  GeneralTotals({
    this.totalDocuments,
    this.totalSaleNotes,
    this.total,
  });

  String? totalDocuments;
  String? totalSaleNotes;
  String? total;

  factory GeneralTotals.fromJson(Map<String, dynamic> json) => GeneralTotals(
        totalDocuments: json["total_documents"],
        totalSaleNotes: json["total_sale_notes"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total_documents": totalDocuments,
        "total_sale_notes": totalSaleNotes,
        "total": total,
      };
}

class Item {
  Item({
    this.id,
    this.description,
  });

  int? id;
  String? description;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}
