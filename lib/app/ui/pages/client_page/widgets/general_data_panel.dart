import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/client/client_form_controller.dart';
import 'package:facturadorpro/app/ui/theme/spacing.dart';
import 'package:facturadorpro/app/ui/widgets/custom_select_form.dart';
import 'package:facturadorpro/app/ui/widgets/custom_text_field_form.dart';
import 'package:facturadorpro/app/ui/widgets/text_field_errors.dart';
import 'package:facturadorpro/shared/enums.dart';
import 'package:select_form_field/select_form_field.dart';

class GeneralDataPanel extends GetView<ClientFormController> {
  const GeneralDataPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 4.0),
          Obx(() {
            return CustomSelectForm(
              title: "Tipo Doc. Identidad (*)",
              // ignore: invalid_use_of_protected_member
              items: controller.documentTypes.value,
              onChanged: (String option) {
                controller.onChangeSelect(
                  option: option,
                  type: SelectTypes.DOCUMENT_TYPE,
                );
              },
              controller: controller.docTypeCnt,
            );
          }),
          SizedBox(height: 20.0),
          Obx(() {
            return CustomTextFieldForm(
              focusNode: controller.docNumberFocus,
              label: "Nro. Doc. Identidad (*)",
              inputType: TextInputType.number,
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(
                  controller.maxLengthDocNumber.value,
                ),
              ],
              controller: controller.docNumberCnt,
              onChanged: controller.resetErrorNumber,
              suffix: controller.isEnabledSunat.value == true
                  ? TextButton.icon(
                      onPressed: () async {
                        await controller.onRequestSunatInfo(context);
                      },
                      label: Text("Consultar"),
                      icon: Icon(Icons.search),
                    )
                  : null,
            );
          }),
          Obx(() {
            if (controller.errorsDocNumber.length > 0) {
              return TextFieldErrors(errors: controller.errorsDocNumber);
            }
            return SizedBox();
          }),
          SizedBox(height: 20.0),
          CustomTextFieldForm(
            focusNode: controller.nameFocus,
            label: "Nombre (*)",
            inputType: TextInputType.name,
            controller: controller.nameCnt,
            onChanged: controller.resetErrorNames,
          ),
          Obx(() {
            if (controller.errorsName.length > 0) {
              return TextFieldErrors(errors: controller.errorsName);
            }
            return SizedBox();
          }),
          SizedBox(height: 20.0),
          CustomTextFieldForm(
            label: "Nombre Comercial",
            inputType: TextInputType.name,
            controller: controller.businessNameCnt,
          ),
          SizedBox(height: 20),
          Flex(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: CustomTextFieldForm(
                  label: "Días de atraso",
                  inputType: TextInputType.number,
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  controller: controller.daysLateCnt,
                ),
              ),
              SizedBox(width: 20.0),
              Flexible(
                flex: 1,
                child: Obx(() {
                  return SelectFormField(
                    controller: controller.personTypeCnt,
                    type: SelectFormFieldType.dropdown,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          kDefaultPadding / 2,
                        ),
                      ),
                      labelText: "Tipo",
                      isDense: true,
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    items: controller.personTypes.value,
                    onChanged: (String option) {
                      controller.onChangeSelect(
                        option: option,
                        type: SelectTypes.CUSTOMER_TYPE,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          CustomTextFieldForm(
            label: "Código interno",
            inputType: TextInputType.name,
            controller: controller.internalCodeCnt,
          ),
          SizedBox(height: 20),
          CustomTextFieldForm(
            label: "Código de barras",
            inputType: TextInputType.number,
            formatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: controller.barcodeCnt,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
