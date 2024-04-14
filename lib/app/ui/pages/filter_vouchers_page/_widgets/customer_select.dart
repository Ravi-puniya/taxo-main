import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/empty_choices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/controllers/sunat_voucher_controller.dart';
import 'package:facturadorpro/api/models/response/filter_voucher_params_response_model.dart';

class CustomerSelect extends GetView<SunatVoucherController> {
  const CustomerSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            bool hasValue = controller.selectedCustomer.value != null;
            return Row(
              children: [
                Icon(
                  Icons.group_outlined,
                  size: 14,
                  color: textColor.shade400,
                ),
                spaceW(4),
                Text(
                  "CLIENTE",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: textColor.shade400,
                  ),
                ),
                if (hasValue) Spacer(),
                if (hasValue)
                  GestureDetector(
                    onTap: () {
                      controller.selectedCustomer.value = null;
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
          SmartSelect<CustomerFilter?>.single(
            title: 'Clientes',
            selectedValue: controller.selectedCustomer.value,
            onChange: (selected) {
              controller.selectedCustomer.value = selected.value;
            },
            choiceType: S2ChoiceType.radios,
            // ignore: invalid_use_of_protected_member
            choiceItems: controller.customers.value,
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
            choiceBuilder: (context, state, choice) {
              final client = choice.value;
              return Card(
                elevation: 0,
                margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                color: choice.selected ? Colors.green : Colors.white,
                child: InkWell(
                  onTap: () => choice.select?.call(true),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: choice.selected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: Colors.grey.shade100,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/default_avatar.png",
                          ),
                          child: choice.selected
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        spaceW(12),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                client!.name.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: choice.selected
                                      ? Colors.white
                                      : textColor.shade600,
                                ),
                                maxLines: 1,
                              ),
                              Column(
                                children: [
                                  const SizedBox(height: 4.0),
                                  Text(
                                    choice.value!.number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: choice.selected
                                          ? Colors.white
                                          : textColor.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            modalFilterHint: "Buscar cliente",
            tileBuilder: (context, state) {
              CustomerFilter? selected = state.selected!.value;
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
                          "Seleccione cliente...",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        )
                      : Text(
                          selected.name,
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
          spaceH(16),
        ],
      );
    });
  }
}
