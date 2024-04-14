import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/widgets/empty_choices.dart';
import 'package:facturadorpro/app/controllers/sunat_voucher_controller.dart';
import 'package:facturadorpro/api/models/response/pos_payments_params_model.dart';

class SeriesSelect extends GetView<SunatVoucherController> {
  const SeriesSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SmartSelect<Series?>.single(
        title: 'Serie',
        selectedValue: controller.selectedSerie.value,
        onChange: (selected) {
          controller.selectedSerie.value = selected.value;
        },
        choiceType: S2ChoiceType.radios,
        // ignore: invalid_use_of_protected_member
        choiceItems: controller.seriesDoctype.value,
        modalFilter: true,
        modalHeaderStyle: S2ModalHeaderStyle(
          backgroundColor: Colors.white,
          textStyle: TextStyle(color: textColor),
          actionsIconTheme: IconThemeData(color: textColor.shade500),
          iconTheme: IconThemeData(color: textColor.shade500),
        ),
        choiceStyle: S2ChoiceStyle(
          highlightColor: Colors.yellow.shade500,
        ),
        choiceLayout: S2ChoiceLayout.list,
        choiceGrid: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 2,
        ),
        choiceEmptyBuilder: (_, __) {
          return EmptyChoices();
        },
        modalFilterHint: "Buscar serie",
        tileBuilder: (context, state) {
          Series? selected = state.selected!.value;
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
                      "Seleccione serie...",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    )
                  : Text(
                      selected.number,
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
      );
    });
  }
}
