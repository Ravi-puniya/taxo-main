import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:facturadorpro/app/controllers/sunat_voucher_controller.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/widgets/bottom_sheet_top_line.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';

class RangeCalendarSelector extends GetView<SunatVoucherController> {
  const RangeCalendarSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SunatVoucherController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          bool hasValue = controller.startDate.value != null;
          return Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 14,
                color: textColor.shade400,
              ),
              spaceW(4),
              Text(
                "DESDE - HASTA",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: textColor.shade400,
                ),
              ),
              if (hasValue) Spacer(),
              if (hasValue)
                GestureDetector(
                  onTap: () {
                    controller.pickedRanges.value = PickerDateRange(null, null);
                    controller.startDate.value = null;
                    controller.endDate.value = null;
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
            controller.rangeCnt.selectedRange = controller.pickedRanges.value;
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
                        "Seleccione un rango de fechas, deslizando o haciendo selección en las fechas.",
                        style: TextStyle(
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                    spaceH(8),
                    Expanded(
                      child: SfDateRangePicker(
                        controller: controller.rangeCnt,
                        selectionMode: DateRangePickerSelectionMode.range,
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
                        onSelectionChanged: (range) {
                          if (range.value != null) {
                            controller.pickedRanges.value = range.value;
                          }
                        },
                        onSubmit: (_) {
                          PickerDateRange range = controller.pickedRanges.value;
                          String frm = "yyyy-MM-dd";
                          if (range.startDate != null) {
                            controller.startDate.value = DateFormat(frm).format(
                              range.startDate!,
                            );
                          }
                          controller.endDate.value = DateFormat(frm).format(
                            range.endDate != null
                                ? range.endDate!
                                : range.startDate!,
                          );
                          controller.pickedRanges.value = range;
                          Get.back();
                        },
                        onCancel: () {
                          controller.rangeCnt.selectedRange = null;
                          controller.startDate.value = null;
                          controller.endDate.value = null;
                          controller.pickedRanges.value = PickerDateRange(
                            null,
                            null,
                          );
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
              DateTime? startDate = null;
              DateTime? endDate = null;
              if (controller.startDate.value != null) {
                startDate = DateTime.parse(controller.startDate.value!);
              }
              if (controller.endDate.value != null) {
                endDate = DateTime.parse(controller.endDate.value!);
              }
              controller.pickedRanges.value = PickerDateRange(
                startDate,
                endDate,
              );
              controller.rangeCnt.selectedRange = null;
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
                  String label = "Seleccione rango de fechas...";
                  String? startDate = controller.startDate.value;
                  String? endDate = controller.endDate.value;
                  if (startDate != null) label = "${startDate}";
                  if (endDate != null) label += " / ${endDate}";
                  return Text(
                    label,
                    style: TextStyle(
                      color: startDate != null ? null : Colors.grey.shade500,
                      fontWeight: startDate != null
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
      ],
    );
  }
}
