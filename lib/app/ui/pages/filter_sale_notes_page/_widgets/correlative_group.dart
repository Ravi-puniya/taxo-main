import 'package:facturadorpro/app/ui/pages/filter_sale_notes_page/_widgets/doc_number_field.dart';
import 'package:facturadorpro/app/ui/pages/filter_sale_notes_page/_widgets/series_select.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/controllers/sales_note_controller.dart';

class CorrelativeGroup extends GetView<SaleNotesController> {
  const CorrelativeGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          bool hasValue = controller.selectedSerie.value != null ||
              controller.correlative.isNotEmpty;
          return Row(
            children: [
              Icon(
                Icons.numbers,
                size: 14,
                color: textColor.shade400,
              ),
              spaceW(4),
              Text(
                "SERIE - CORRELATIVO",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: textColor.shade400,
                ),
              ),
              if (hasValue) Spacer(),
              if (hasValue)
                GestureDetector(
                  onTap: () {
                    controller.selectedSerie.value = null;
                    controller.correlative.value = "";
                    controller.docNumberCnt.text = "";
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
        Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(flex: 2, child: SeriesSelect()),
            spaceW(16),
            Flexible(flex: 1, child: DocNumberField()),
          ],
        ),
        spaceH(16),
        Divider(height: 8),
        spaceH(16),
      ],
    );
  }
}
