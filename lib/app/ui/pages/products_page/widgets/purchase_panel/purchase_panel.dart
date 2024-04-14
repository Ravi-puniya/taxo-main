import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/widgets/custom_text_field_form.dart';
import 'package:facturadorpro/app/controllers/product/product_form_controller.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/purchase_panel/widgets/affectation_type_selector.dart';

class PurchasePanel extends GetView<ProductFormController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AffectationTypeSelector(),
          spaceH(16),
          Obx(() {
            return CustomTextFieldForm(
              label: "Precio Unitario",
              inputType: TextInputType.number,
              controller: controller.unitPricePurchaseCnt,
              textAlign: TextAlign.right,
              formatters: [
                FilteringTextInputFormatter.deny(
                  ',',
                  replacementString: '.',
                ),
                FilteringTextInputFormatter.allow(
                  RegExp(r'(^\d*\.?\d{0,2})'),
                ),
              ],
              onTap: () {
                controller.unitPricePurchaseCnt.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset:
                      controller.unitPricePurchaseCnt.value.text.length,
                );
              },
              onChanged: (value) {
                EasyDebounce.debounce(
                  'unitPricePurchase',
                  Duration(milliseconds: 1000),
                  () {
                    String val = formatMoney(
                      quantity: double.parse(value),
                      decimalDigits: 2,
                    );
                    controller.unitPricePurchaseCnt.text = val;
                    controller.unitPricePurchaseCnt.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset:
                          controller.unitPricePurchaseCnt.value.text.length,
                    );
                    controller.unitPricePurchase.value =
                        value.replaceAll(",", "");
                  },
                );
              },
              prefix: Text(
                controller.currencyTypeSelected.value != null
                    ? controller.currencyTypeSelected.value!.symbol
                    : "",
              ),
            );
          }),
          spaceH(16),
          Obx(() {
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CheckboxListTile(
                title: Text(
                  "Incluye Igv",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                value: controller.includePurchaseIgv.value,
                onChanged: (value) {
                  controller.includePurchaseIgv.value = value ?? false;
                },
                dense: true,
              ),
            );
          }),
          spaceH(16),
        ],
      ),
    );
  }
}
