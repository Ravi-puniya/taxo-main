import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/sales_note_controller.dart';

class ClientField extends GetView<SaleNotesController> {
  const ClientField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedColumn.value.id == "customer") {
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
                  controller: controller.clientCnt,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Razón social del cliente",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                    isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.all(8),
                  ),
                  onChanged: (value) {
                    controller.clientName.value = value;
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
      return SizedBox();
    });
  }
}
