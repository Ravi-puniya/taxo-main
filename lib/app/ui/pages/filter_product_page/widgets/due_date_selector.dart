import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/widgets/bottom_sheet_top_line.dart';
import 'package:facturadorpro/app/controllers/product/products_controller.dart';

class DueDateSelector extends GetView<ProductsController> {
  const DueDateSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedColumn.value.id != "date_of_due") {
        return SizedBox();
      }
      bool hasValue = controller.dueDate.value != null;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasValue)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 14,
                  color: textColor.shade400,
                ),
                spaceW(4),
                Text(
                  "FECHA SELECCIONADA",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: textColor.shade400,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    controller.pickedDueDate.value = null;
                    controller.dueDate.value = null;
                  },
                  child: Row(
                    children: [
                      Text(
                        "Quitar",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      spaceW(2),
                      Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.red,
                      ),
                    ],
                  ),
                )
              ],
            ),
          if (hasValue) spaceH(8),
          GestureDetector(
            onTap: () {
              final due = controller.pickedDueDate.value;
              controller.dueDateCnt.selectedDate = due;
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
                          controller: controller.dueDateCnt,
                          selectionMode: DateRangePickerSelectionMode.single,
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
                              controller.pickedDueDate.value = selected.value;
                            }
                          },
                          onSubmit: (_) {
                            DateTime? due = controller.pickedDueDate.value;
                            String frm = "yyyy-MM-dd";
                            if (due != null) {
                              String dueDate = DateFormat(frm).format(due);
                              controller.dueDate.value = dueDate;
                            }
                            Get.back();
                          },
                          onCancel: () {
                            controller.dueDateCnt.selectedDate = null;
                            controller.dueDate.value = null;
                            controller.pickedDueDate.value = null;
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
                DateTime? dueDate = null;
                if (controller.dueDate.value != null) {
                  dueDate = DateTime.parse(controller.dueDate.value!);
                }
                controller.pickedDueDate.value = dueDate;
                controller.dueDateCnt.selectedDate = null;
              });
            },
            child: Container(
              height: 48,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Obx(() {
                    String label = "Seleccione fecha...";
                    String? dueDate = controller.dueDate.value;
                    if (dueDate != null) label = "${dueDate}";
                    return Text(
                      label,
                      style: TextStyle(
                        color: dueDate != null ? null : Colors.grey.shade500,
                        fontWeight: dueDate != null
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
          ),
          spaceH(16),
          Divider(height: 8),
          spaceH(16),
        ],
      );
    });
  }
}
