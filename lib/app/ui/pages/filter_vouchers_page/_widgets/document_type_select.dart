import 'package:facturadorpro/app/ui/widgets/empty_choices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/controllers/sunat_voucher_controller.dart';
import 'package:facturadorpro/api/models/response/filter_voucher_params_response_model.dart';

class DocumentTypeSelect extends GetView<SunatVoucherController> {
  const DocumentTypeSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool hasValue = controller.selectedDocType.value != null;
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
                "COMPROBANTE",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: textColor.shade400,
                ),
              ),
              if (hasValue) Spacer(),
              if (hasValue)
                GestureDetector(
                  onTap: () {
                    controller.selectedDocType.value = null;
                    controller.selectedSerie.value = null;
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
          ),
          spaceH(8),
          SmartSelect<DocumentType?>.single(
            title: 'Tipo documento',
            selectedValue: controller.selectedDocType.value,
            onChange: (selected) {
              controller.onSelectDocumentType(selected: selected);
            },
            choiceType: S2ChoiceType.radios,
            // ignore: invalid_use_of_protected_member
            choiceItems: controller.documentTypes.value,
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
            choiceGrid: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              crossAxisCount: 2,
            ),
            modalFilterHint: "Buscar tipo de documento",
            tileBuilder: (context, state) {
              DocumentType? selected = state.selected!.value;
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
                          "Seleccione tipo documento...",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        )
                      : Text(
                          selected.description,
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
