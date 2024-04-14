import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/controllers/cash/cash_controller.dart';

class CashBoxField extends GetView<CashController> {
  const CashBoxField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Center(
            child: TextFormField(
              controller: controller.fieldValueCnt,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Ingrese parámetro de búsqueda",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.all(8),
              ),
              onChanged: (value) {
                controller.fieldValue.value = value;
              },
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        spaceH(16),
      ],
    );
  }
}
