import 'package:easy_debounce/easy_debounce.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/custom_text_field_form.dart';
import 'package:facturadorpro/app/controllers/product/product_form_controller.dart';
import 'package:facturadorpro/app/controllers/product/presentation_form_controller.dart';
import 'package:facturadorpro/app/ui/pages/products_page/presentation_form_page/widgets/presentation_unit_type_selector.dart';
import 'package:facturadorpro/app/ui/pages/products_page/presentation_form_page/widgets/default_price_selector.dart';

class PresentationFormPage extends GetView<PresentationFormController> {
  const PresentationFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productFormCnt = Get.find<ProductFormController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Obx(() {
          if (controller.presentationIndex.value == null) {
            return Text("Registrar Presentación");
          }
          String t = controller.presentationIndex.value != null
              ? "Editar"
              : "Registrar";
          return Text("$t Presentación");
        }),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
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
            PresentationUnitTypeSelector(),
            spaceH(16),
            Obx(() {
              return CustomTextFieldForm(
                label: "Descripción",
                controller: controller.descriptionCnt,
                onChanged: (value) => controller.description.value = value,
                suffix: controller.description.value.isNotEmpty
                    ? IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () {
                          controller.descriptionCnt.text = "";
                          controller.description.value = "";
                        },
                      )
                    : null,
              );
            }),
            spaceH(16),
            Obx(() {
              return CustomTextFieldForm(
                label: "Factor",
                inputType: TextInputType.number,
                controller: controller.factorCnt,
                textAlign: TextAlign.right,
                formatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyTextInputFormatter(
                    locale: 'en_us',
                    decimalDigits: 0,
                    symbol: "",
                  ),
                ],
                onChanged: (value) => controller.factor.value = value,
                suffix: controller.factor.value.isNotEmpty
                    ? IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () {
                          controller.factorCnt.text = "";
                          controller.factor.value = "";
                        },
                      )
                    : null,
              );
            }),
            spaceH(16),
            CustomTextFieldForm(
              label: "Precio 1",
              inputType: TextInputType.number,
              controller: controller.price1Cnt,
              textAlign: TextAlign.right,
              prefix: Text(productFormCnt.currencyTypeSelected.value!.symbol),
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
                controller.price1Cnt.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: controller.price1Cnt.value.text.length,
                );
              },
              onChanged: (value) {
                EasyDebounce.debounce(
                  'price1',
                  Duration(milliseconds: 1000),
                  () {
                    String val = formatMoney(
                      quantity: double.parse(value),
                      decimalDigits: 2,
                    );
                    controller.price1Cnt.text = val;
                    controller.price1Cnt.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controller.price1Cnt.value.text.length,
                    );
                    controller.price1.value = value.replaceAll(",", "");
                  },
                );
              },
            ),
            spaceH(16),
            CustomTextFieldForm(
              label: "Precio 2",
              inputType: TextInputType.number,
              controller: controller.price2Cnt,
              textAlign: TextAlign.right,
              prefix: Text(productFormCnt.currencyTypeSelected.value!.symbol),
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
                controller.price2Cnt.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: controller.price2Cnt.value.text.length,
                );
              },
              onChanged: (value) {
                EasyDebounce.debounce(
                  'price2',
                  Duration(milliseconds: 1000),
                  () {
                    String val = formatMoney(
                      quantity: double.parse(value),
                      decimalDigits: 2,
                    );
                    controller.price2Cnt.text = val;
                    controller.price2Cnt.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controller.price2Cnt.value.text.length,
                    );
                    controller.price2.value = value.replaceAll(",", "");
                  },
                );
              },
            ),
            spaceH(16),
            CustomTextFieldForm(
              label: "Precio 3",
              inputType: TextInputType.number,
              controller: controller.price3Cnt,
              textAlign: TextAlign.right,
              prefix: Text(productFormCnt.currencyTypeSelected.value!.symbol),
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
                controller.price3Cnt.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: controller.price3Cnt.value.text.length,
                );
              },
              onChanged: (value) {
                EasyDebounce.debounce(
                  'price2',
                  Duration(milliseconds: 1000),
                  () {
                    String val = formatMoney(
                      quantity: double.parse(value),
                      decimalDigits: 2,
                    );
                    controller.price3Cnt.text = val;
                    controller.price3Cnt.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controller.price3Cnt.value.text.length,
                    );
                    controller.price3.value = value.replaceAll(",", "");
                  },
                );
              },
            ),
            spaceH(16),
            DefaultPriceSelector(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            elevation: 0,
            onPressed: Get.back,
            label: Text(
              "CANCELAR",
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
            backgroundColor: Colors.grey.shade200,
            heroTag: null,
          ),
          const SizedBox(width: 12.0),
          FloatingActionButton.extended(
            elevation: 0,
            onPressed: () {
              FocusScope.of(context).unfocus();
              controller.onSavePresentation();
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            label: const Text(
              "GUARDAR",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: primaryColor,
            heroTag: null,
          ),
        ],
      ),
    );
  }
}
