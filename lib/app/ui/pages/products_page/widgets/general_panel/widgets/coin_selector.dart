import 'package:facturadorpro/api/models/response/init_params_pos.dart';
import 'package:facturadorpro/app/ui/widgets/empty_choices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/controllers/product/product_form_controller.dart';

class CoinSelector extends GetView<ProductFormController> {
  const CoinSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartSelect<CurrencyType?>.single(
      title: 'Moneda',
      selectedValue: controller.currencyTypeSelected.value,
      onChange: (selected) {
        controller.currencyTypeSelected.value = selected.value;
      },
      choiceType: S2ChoiceType.radios,
      // ignore: invalid_use_of_protected_member
      choiceItems: controller.currencyTypesChoices.value,
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
      choiceLayout: S2ChoiceLayout.list,
      choiceGrid: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 2,
      ),
      modalFilterHint: "Buscar moneda",
      tileBuilder: (context, state) {
        CurrencyType? selected = state.selected!.value;
        return Container(
          width: double.infinity,
          height: selected == null ? 52 : 68,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.shade500,
            ),
          ),
          child: S2Tile.fromState(
            state,
            dense: true,
            loadingText: "Cargando...",
            title: Text(
              "Moneda",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            hideValue: selected == null,
            isTwoLine: selected != null,
            value: selected != null
                ? Text(
                    selected.description.toUpperCase(),
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  )
                : SizedBox(),
          ),
        );
      },
    );
  }
}
