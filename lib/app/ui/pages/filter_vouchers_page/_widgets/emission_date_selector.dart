import 'package:facturadorpro/app/controllers/sunat_voucher_controller.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/widgets/bottom_sheet_top_line.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EmissionDateSelector extends GetView<SunatVoucherController> {
  const EmissionDateSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          bool hasValue = controller.emissionDate.value != null;
          return Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 14,
                color: textColor.shade400,
              ),
              spaceW(4),
              Text(
                "FECHA DE EMISIÓN",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: textColor.shade400,
                ),
              ),
              if (hasValue) Spacer(),
              if (hasValue)
                GestureDetector(
                  onTap: () {
                    controller.pickedEmission.value = null;
                    controller.emissionDate.value = null;
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
                ),
            ],
          );
        }),
        spaceH(8),
        GestureDetector(
          onTap: () {
            final emission = controller.pickedEmission.value;
            controller.emissionCnt.selectedDate = emission;
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
                        "Seleccione la fecha de emisión del comprobante.",
                        style: TextStyle(
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                    spaceH(8),
                    Expanded(
                      child: SfDateRangePicker(
                        controller: controller.emissionCnt,
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
                            controller.pickedEmission.value = selected.value;
                          }
                        },
                        onSubmit: (_) {
                          DateTime? emission = controller.pickedEmission.value;
                          String frm = "yyyy-MM-dd";
                          if (emission != null) {
                            String emissionDate = DateFormat(frm).format(
                              emission,
                            );
                            controller.emissionDate.value = emissionDate;
                          }
                          Get.back();
                        },
                        onCancel: () {
                          controller.emissionCnt.selectedDate = null;
                          controller.emissionDate.value = null;
                          controller.pickedEmission.value = null;
                          Get.back();
                        },
                        showTodayButton: true,
                        showActionButtons: true,
                        cancelText: "CANCELAR",
                        maxDate: DateTime.now(),
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
              if (controller.emissionDate.value != null) {
                emissionDate = DateTime.parse(controller.emissionDate.value!);
              }
              controller.pickedEmission.value = emissionDate;
              controller.emissionCnt.selectedDate = null;
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
                  String? emissionDate = controller.emissionDate.value;
                  if (emissionDate != null) label = "${emissionDate}";
                  return Text(
                    label,
                    style: TextStyle(
                      color: emissionDate != null ? null : Colors.grey.shade500,
                      fontWeight: emissionDate != null
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
  }
}
