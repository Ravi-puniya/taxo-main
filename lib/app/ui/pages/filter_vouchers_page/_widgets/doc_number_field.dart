import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/sunat_voucher_controller.dart';

class DocNumberField extends GetView<SunatVoucherController> {
  const DocNumberField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Obx(() {
        return Center(
          child: TextFormField(
            controller: controller.docNumberCnt,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            enabled: controller.selectedSerie.value != null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Correlativo",
              hintStyle: TextStyle(
                fontWeight: FontWeight.normal,
              ),
              isDense: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.all(8),
            ),
            onChanged: (value) {
              controller.correlative.value = value;
            },
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }),
    );
  }
}
