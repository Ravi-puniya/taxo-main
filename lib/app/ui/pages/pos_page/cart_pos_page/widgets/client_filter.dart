import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/empty_choices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/shared/string_ext.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/api/models/customer_pos_model.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';

class ClientFilter extends GetView<PosController> {
  const ClientFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SmartSelect<CustomerPosModel?>.single(
        title: 'Clientes',
        selectedValue: controller.selectedCustomer.value,
        onChange: (selected) {
          controller.onSelectCustomer(customer: selected);
        },
        choiceType: S2ChoiceType.radios,
        // ignore: invalid_use_of_protected_member
        choiceItems: controller.clients.value,
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
          CustomerPosModel? selected = state.selected!.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: controller.clientValidation.isNotEmpty
                          ? Colors.red.shade500
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: S2Tile.fromState(
                    state,
                    hideValue: true,
                    dense: true,
                    loadingText: "Cargando...",
                    title: selected == null
                        ? Text("Seleccione cliente...")
                        : Text(
                            selected.name.toTitleCase(),
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black,
                            ),
                          ),
                  ),
                );
              }),
            ],
          );
        },
      );
    });
  }
}
