import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/widgets/empty_choices.dart';
import 'package:facturadorpro/app/ui/models/filter_column_model.dart';
import 'package:facturadorpro/app/controllers/cash/cash_controller.dart';

class ColumnSelectCashBox extends GetView<CashController> {
  const ColumnSelectCashBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.file_present_outlined,
                size: 14,
                color: textColor.shade400,
              ),
              spaceW(4),
              Text(
                "COLUMNA A FILTRAR",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: textColor.shade400,
                ),
              ),
            ],
          ),
          spaceH(8),
          SmartSelect<FilterColumnModel>.single(
            title: 'Columnas',
            selectedValue: controller.selectedColumn.value,
            onChange: (selected) {
              controller.onSelectColumn(selected: selected);
            },
            choiceType: S2ChoiceType.radios,
            // ignore: invalid_use_of_protected_member
            choiceItems: controller.columns.value,
            modalFilter: true,
            modalHeaderStyle: S2ModalHeaderStyle(
              backgroundColor: Colors.white,
              textStyle: TextStyle(color: textColor),
              actionsIconTheme: IconThemeData(color: textColor.shade500),
              iconTheme: IconThemeData(color: textColor.shade500),
            ),
            choiceEmptyBuilder: (_, __) {
              return EmptyChoices();
            },
            choiceStyle: S2ChoiceStyle(
              highlightColor: Colors.yellow.shade500,
            ),
            choiceLayout: S2ChoiceLayout.list,
            modalFilterHint: "Buscar columna",
            tileBuilder: (context, state) {
              FilterColumnModel? selected = state.selected!.value;
              return Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: S2Tile.fromState(
                  state,
                  hideValue: true,
                  dense: true,
                  loadingText: "Cargando...",
                  title: Text(
                    selected.description.toUpperCase(),
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          ),
          spaceH(16),
        ],
      );
    });
  }
}
