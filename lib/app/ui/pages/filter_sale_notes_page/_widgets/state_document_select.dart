import 'package:facturadorpro/app/ui/widgets/empty_choices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/models/sale_note_column_model.dart';
import 'package:facturadorpro/app/controllers/sales_note_controller.dart';

class StateDocSelect extends GetView<SaleNotesController> {
  const StateDocSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            bool hasValue = controller.selectedTotalPaid.value != null;
            return Row(
              children: [
                Icon(
                  Icons.layers_outlined,
                  size: 14,
                  color: textColor.shade400,
                ),
                spaceW(4),
                Text(
                  "ESTADO DE PAGO",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: textColor.shade400,
                  ),
                ),
                if (hasValue) Spacer(),
                if (hasValue)
                  GestureDetector(
                    onTap: () {
                      controller.selectedTotalPaid.value = null;
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
          SmartSelect<SaleNoteColumnModel?>.single(
            title: 'Estado de pago',
            selectedValue: controller.selectedTotalPaid.value,
            onChange: (selected) {
              controller.selectedTotalPaid.value = selected.value;
            },
            choiceType: S2ChoiceType.radios,
            // ignore: invalid_use_of_protected_member
            choiceItems: controller.totalPaid.value,
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
            modalFilterHint: "Buscar estado",
            tileBuilder: (context, state) {
              SaleNoteColumnModel? selected = state.selected!.value;
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
                  title: selected == null
                      ? Text(
                          "Seleccione estado...",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        )
                      : Text(
                          selected.description.toUpperCase(),
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
