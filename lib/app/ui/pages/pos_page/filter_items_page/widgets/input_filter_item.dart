import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';

class InputFilterItem extends GetView<PosController> {
  const InputFilterItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 10.0,
        right: 8.0,
        bottom: 16.0,
      ),
      child: TextField(
        onChanged: (value) {
          EasyDebounce.debounce(
            'productItem',
            Duration(milliseconds: 1000),
            () => controller.filterItemsFromInput(value: value),
          );
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          hintText: "Buscar productos o items",
          prefixIcon: Icon(Icons.search_outlined),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.filter_center_focus_rounded,
              size: 24.0,
            ),
            onPressed: () async {
              await controller.onScanBarcode(context);
            },
          ),
          hintStyle: TextStyle(color: Colors.grey.shade400),
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        cursorColor: primaryColor,
      ),
    );
  }
}
