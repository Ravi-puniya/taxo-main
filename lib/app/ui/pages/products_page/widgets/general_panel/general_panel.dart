import 'package:easy_debounce/easy_debounce.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/general_panel/widgets/affectation_type_selector.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/general_panel/widgets/coin_selector.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/general_panel/widgets/expiration_date_selector.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/general_panel/widgets/general_unit_type_selector.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/general_panel/widgets/warehouse_selector.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/widgets/custom_text_field_form.dart';
import 'package:facturadorpro/app/controllers/product/product_form_controller.dart';

class GeneralPanel extends GetView<ProductFormController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
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
                    value: controller.includeIgv.value,
                    onChanged: (value) {
                      controller.includeIgv.value = value ?? false;
                    },
                    dense: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CheckboxListTile(
                    title: Text(
                      "Calcular cantidad por precio",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    value: controller.calculateQuantityPerPrice.value,
                    onChanged: (value) {
                      controller.calculateQuantityPerPrice.value =
                          value ?? false;
                    },
                    dense: true,
                  ),
                ),
              ],
            );
          }),
          spaceH(16),
          CustomTextFieldForm(
            label: "Nombre",
            inputType: TextInputType.name,
            controller: controller.nameCnt,
          ),
          spaceH(16),
          Obx(() {
            return CustomTextFieldForm(
              label: "Modelo",
              inputType: TextInputType.name,
              controller: controller.modelCnt,
              onChanged: (value) => controller.model.value = value,
              suffix: controller.model.value.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        controller.modelCnt.text = "";
                        controller.model.value = "";
                      },
                    )
                  : null,
            );
          }),
          spaceH(16),
          GeneralUnitTypeSelector(),
          spaceH(16),
          CoinSelector(),
          spaceH(16),
          Obx(() {
            return CustomTextFieldForm(
              label: "Precio Unitario",
              inputType: TextInputType.number,
              controller: controller.unitPriceCnt,
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
                controller.unitPriceCnt.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: controller.unitPriceCnt.value.text.length,
                );
              },
              /*prefix: Text(
                controller.currencyTypeSelected.value != null
                    ? controller.currencyTypeSelected.value!.symbol
                    : "",
              ),*/
              onChanged: (value) {
                EasyDebounce.debounce(
                  'quantity',
                  Duration(milliseconds: 1000),
                  () {
                    String val = formatMoney(
                      quantity: double.parse(value),
                      decimalDigits: 2,
                    );
                    controller.unitPriceCnt.text = val;
                    controller.unitPriceCnt.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controller.unitPriceCnt.value.text.length,
                    );
                    controller.unitPrice.value = value.replaceAll(",", "");
                  },
                );
              },
              suffix: controller.unitPrice.value.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        controller.unitPriceCnt.text = "";
                        controller.unitPrice.value = "";
                      },
                    )
                  : null,
            );
          }),
          spaceH(16),
          AffectationTypeSelector(),
          spaceH(16),
          WarehouseSelector(),
          spaceH(16),
          Obx(() {
            if (controller.productId.value != null) {
              return CustomTextFieldForm(
                label: "Stock Mínimo",
                inputType: TextInputType.number,
                controller: controller.minimumStockCnt,
                textAlign: TextAlign.right,
                formatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyTextInputFormatter(
                    locale: 'en_us',
                    decimalDigits: 0,
                    symbol: "",
                  ),
                ],
              );
            }
            return Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: CustomTextFieldForm(
                    label: "Stock Mínimo",
                    inputType: TextInputType.number,
                    controller: controller.minimumStockCnt,
                    textAlign: TextAlign.right,
                    formatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyTextInputFormatter(
                        locale: 'en_us',
                        decimalDigits: 0,
                        symbol: "",
                      ),
                    ],
                  ),
                ),
                spaceW(16),
                Flexible(
                  flex: 1,
                  child: CustomTextFieldForm(
                    label: "Stock Inicial",
                    inputType: TextInputType.number,
                    controller: controller.initialStockCnt,
                    textAlign: TextAlign.right,
                    formatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyTextInputFormatter(
                        locale: 'en_us',
                        decimalDigits: 0,
                        symbol: "",
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          spaceH(16),
          ExpirationDateSelector(),
          spaceH(16),
          Obx(() {
            return CustomTextFieldForm(
              label: "Código de barras",
              inputType: TextInputType.number,
              controller: controller.barcodeCnt,
              formatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => controller.barcode.value = value,
              suffix: Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (controller.barcode.value.isNotEmpty)
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () {
                          controller.barcodeCnt.text = "";
                          controller.barcode.value = "";
                        },
                      ),
                    IconButton(
                      icon: Icon(Icons.filter_center_focus_rounded),
                      onPressed: () async {
                        await controller.onScanBarcode(context);
                      },
                    )
                  ],
                ),
              ),
            );
          }),
          spaceH(16),
          Obx(() {
            return CustomTextFieldForm(
              label: "Código interno",
              controller: controller.internalCodeCnt,
              onChanged: (value) => controller.internalCode.value = value,
              suffix: controller.internalCode.value.isNotEmpty
                  ? IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        controller.internalCodeCnt.text = "";
                        controller.internalCode.value = "";
                      },
                    )
                  : null,
            );
          }),
          spaceH(16),
        ],
      ),
    );
  }
}
