import 'package:facturadorpro/app/controllers/product/product_form_controller.dart';
import 'package:facturadorpro/app/ui/widgets/bottom_sheet_top_line.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ExpirationDateSelector extends GetView<ProductFormController> {
  const ExpirationDateSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final expiration = controller.pickedExpiration.value;
        controller.expirationCnt.selectedDate = expiration;
        Get.bottomSheet(
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                BottomSeetTopLine(),
                spaceH(8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue.shade50,
                  ),
                  child: Text(
                    "Seleccione la fecha de expiración del producto.",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
                spaceH(8),
                Expanded(
                  child: SfDateRangePicker(
                    controller: controller.expirationCnt,
                    selectionMode: DateRangePickerSelectionMode.single,
                    initialSelectedDate:
                        controller.pickedExpiration.value ?? DateTime.now(),
                    backgroundColor: Colors.white,
                    headerStyle: DateRangePickerHeaderStyle(
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selectionTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelectionChanged: (selected) {
                      if (selected.value != null) {
                        controller.pickedExpiration.value = selected.value;
                      }
                    },
                    onSubmit: (_) {
                      DateTime? expiration = controller.pickedExpiration.value;
                      String frm = "yyyy-MM-dd";
                      if (expiration != null) {
                        String expirationDate = DateFormat(frm).format(
                          expiration,
                        );
                        controller.expirationDate.value = expirationDate;
                      }
                      Get.back();
                    },
                    onCancel: () {
                      controller.expirationCnt.selectedDate = null;
                      controller.expirationDate.value = null;
                      controller.pickedExpiration.value = null;
                      Get.back();
                    },
                    showTodayButton: true,
                    showActionButtons: true,
                    cancelText: "CANCELAR",
                  ),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          backgroundColor: Colors.white,
        ).whenComplete(() {
          DateTime? emissionDate = null;
          if (controller.expirationDate.value != null) {
            emissionDate = DateTime.parse(controller.expirationDate.value!);
          }
          controller.pickedExpiration.value = emissionDate;
          controller.expirationCnt.selectedDate = null;
        });
      },
      child: Container(
        height: 48,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade500),
        ),
        child: Row(
          children: [
            Obx(() {
              String label = "Fecha de expiración";
              String? expirationDate = controller.expirationDate.value;
              if (expirationDate != null)
                label = "Expira el: ${expirationDate}";
              return Text(
                label,
                style: TextStyle(
                  fontWeight: expirationDate != null
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              );
            }),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Colors.grey.shade500,
            )
          ],
        ),
      ),
    );
  }
}
