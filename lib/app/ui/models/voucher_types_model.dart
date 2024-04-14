import 'package:flutter/material.dart';

class VoucherTypesModel {
  VoucherTypesModel({
    required this.voucherId,
    required this.textColor,
    required this.borderColor,
    required this.backgroundColor,
  });

  String voucherId;
  Color textColor;
  Color borderColor;
  Color backgroundColor;
}
