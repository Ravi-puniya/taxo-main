class FilterSaleNoteReq {
  FilterSaleNoteReq({
    required this.page,
    this.column,
    this.series,
    this.totalCanceled,
    this.number,
    this.value,
  });

  int page;
  String? column;
  String? series;
  String? totalCanceled;
  String? value;
  String? number;
}
