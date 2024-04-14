class FilterVoucherReq {
  FilterVoucherReq({
    required this.page,
    this.categoryId,
    this.customerId,
    this.startDate,
    this.endingDate,
    this.dateOfIssue,
    this.documentTypeId,
    this.itemId,
    this.number,
    this.pendingPayment,
    this.series,
    this.stateTypeId,
  });

  int page;
  String? categoryId;
  String? customerId;
  String? startDate;
  String? endingDate;
  String? dateOfIssue;
  String? documentTypeId;
  String? itemId;
  String? number;
  String? pendingPayment;
  String? series;
  String? stateTypeId;
}
