class Cotizacioniten {
  final dynamic item_id;
  final String price_type_id;
  final Map<String, dynamic> item;
  final String currency_type_id;
  final int quantity;
  final double unit_value;
  final String affectation_igv_type_id;
  final double total_base_igv;
  final double percentage_igv;
  final double total_igv;
  final double total_taxes;
  final double unit_price;
  final String input_unit_price_value;
  final double total_value;
  final double total;
  final double total_value_without_rounding;
  final double total_base_igv_without_rounding;
  final double total_igv_without_rounding;
  final double total_taxes_without_rounding;
  final double total_without_rounding;
  final double purchase_unit_price;
  final double purchase_unit_value;
  final bool purchase_has_igv;


  Cotizacioniten({
    required this.item_id,
    required this.item,
    required this.price_type_id,
    required this.currency_type_id,
    required this.quantity,
    required this.unit_value,
    required this.affectation_igv_type_id,
    required this.total_base_igv,
    required this.percentage_igv,
    required this.total_igv,
    required this.total_taxes,
    required this.unit_price,
    required this.input_unit_price_value,
    required this.total_value,
    required this.total,
    required this.total_value_without_rounding,
    required this.total_base_igv_without_rounding,
    required this.total_igv_without_rounding,
    required this.total_taxes_without_rounding,
    required this.total_without_rounding,
    required this.purchase_unit_price,
    required this.purchase_unit_value,
    required this.purchase_has_igv,
  });

  Map<String, dynamic> toJson() => {
    "item_id": item_id,
    "price_type_id": price_type_id,

      "item": item,
      "currency_type_id": currency_type_id,
      "quantity": quantity,
      "unit_value": unit_value,
      "affectation_igv_type_id": affectation_igv_type_id,
      "total_base_igv": total_base_igv,
      "percentage_igv": percentage_igv,
      "total_igv": total_igv,
      "total_taxes": total_taxes,
      "unit_price": unit_price,
      "input_unit_price_value": input_unit_price_value,
      "total_value": total_value,
      "total": total,
      "total_value_without_rounding": total_value_without_rounding,
      "total_base_igv_without_rounding": total_base_igv_without_rounding,
      "total_igv_without_rounding": total_igv_without_rounding,
      "total_taxes_without_rounding": total_taxes_without_rounding,
      "total_without_rounding": total_without_rounding,
      "purchase_unit_price": purchase_unit_price,
      "purchase_unit_value": purchase_unit_value,
      "purchase_has_igv": purchase_has_igv,
       
      };
}

 