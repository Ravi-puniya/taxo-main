import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facturadorpro/shared/enums.dart';

import 'package:select_form_field/select_form_field.dart';
import 'package:facturadorpro/app/ui/widgets/custom_select_form.dart';
import 'package:facturadorpro/app/ui/widgets/custom_text_field_form.dart';
import 'package:facturadorpro/app/controllers/client/client_form_controller.dart';

class AddressDataPanel extends GetView<ClientFormController> {
  const AddressDataPanel({Key? key}) : super(key: key);

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
              title: "Departamento",
              // ignore: invalid_use_of_protected_member
              // initialValue: controller.departmentId.value,
              items: controller.departments.value,
              type: SelectFormFieldType.dialog,
              dialogTitle: "Departamentos",
              onChanged: controller.onChangedDepartment,
              controller: controller.departmentCnt,
            );
          }),
          SizedBox(height: 20.0),
          Obx(() {
            return CustomSelectForm(
              title: "Provincia",
              // ignore: invalid_use_of_protected_member
              items: controller.provinces.value,
              enabled: controller.provinces.length > 0,
              type: SelectFormFieldType.dialog,
              onChanged: controller.onChangedProvince,
              controller: controller.provinceCnt,
            );
          }),
          SizedBox(height: 20.0),
          Obx(() {
            return CustomSelectForm(
              title: "Distritos",
              // ignore: invalid_use_of_protected_member
              items: controller.districts.value,
              enabled: controller.districts.length > 0,
              type: SelectFormFieldType.dialog,
              onChanged: (String option) {
                controller.onChangeSelect(
                  option: option,
                  type: SelectTypes.DISTRICT,
                );
              },
              controller: controller.districtCnt,
            );
          }),
          SizedBox(height: 20.0),
          CustomTextFieldForm(
            label: "Dirección",
            inputType: TextInputType.streetAddress,
            maxLines: 4,
            minLines: 2,
            controller: controller.addressCnt,
          ),
          SizedBox(height: 20.0),
          CustomTextFieldForm(
            label: "Teléfono",
            inputType: TextInputType.phone,
            controller: controller.cellphoneCnt,
          ),
          SizedBox(height: 20.0),
          CustomTextFieldForm(
            label: "Correo electrónico",
            inputType: TextInputType.emailAddress,
            controller: controller.emailCnt,
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
