import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/enums.dart';
import 'package:facturadorpro/app/ui/widgets/horizontal_line.dart';
import 'package:facturadorpro/app/ui/widgets/custom_select_form.dart';
import 'package:facturadorpro/app/ui/widgets/custom_text_field_form.dart';
import 'package:facturadorpro/app/controllers/client/client_form_controller.dart';

class OtherDataPanel extends GetView<ClientFormController> {
  const OtherDataPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          HorizontalLine(
            label: "CONTACTO",
            position: HeadLinePosition.LEFT,
          ),
          SizedBox(height: 20.0),
          CustomTextFieldForm(
            label: "Nombre y apellido",
            inputType: TextInputType.name,
            controller: controller.contactNameCnt,
          ),
          SizedBox(height: 20.0),
          CustomTextFieldForm(
            label: "Teléfono",
            inputType: TextInputType.phone,
            controller: controller.contactPhoneCnt,
          ),
          SizedBox(height: 20.0),
          HorizontalLine(
            label: "ADICIONAL",
            position: HeadLinePosition.LEFT,
          ),
          SizedBox(height: 20.0),
          CustomTextFieldForm(
            label: "Sitio Web",
            inputType: TextInputType.url,
            controller: controller.websiteCnt,
          ),
          SizedBox(height: 20.0),
          CustomTextFieldForm(
            label: "Observaciones",
            maxLines: 4,
            minLines: 2,
            controller: controller.observationCnt,
          ),
          SizedBox(height: 20.0),
          Obx(() {
            return CustomSelectForm(
              title: "Vendedor",
              controller: controller.sellerCnt,
              // ignore: invalid_use_of_protected_member
              items: controller.sellers.value,
              onChanged: (String option) {
                controller.onChangeSelect(
                  option: option,
                  type: SelectTypes.SELLER,
                );
              },
            );
          }),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
