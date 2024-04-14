class PanelOptionsVoucherModel {
  PanelOptionsVoucherModel({
    required this.pdfLinkTck,
    required this.pdfLinkA4,
    required this.message,
    required this.documentId,
    required this.correlative,
    this.canCancel,
  });

  String pdfLinkTck;
  String pdfLinkA4;
  String message;
  int documentId;
  String correlative;
  bool? canCancel = false;
}
