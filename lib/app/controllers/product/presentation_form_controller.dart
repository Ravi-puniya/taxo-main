import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:facturadorpro/shared/getx.dart';
import 'package:facturadorpro/shared/mapping.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/api/models/part/item_unit_type.dart';
import 'package:facturadorpro/app/ui/models/default_price_model.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';
import 'package:facturadorpro/app/controllers/product/product_form_controller.dart';

class PresentationFormController extends GetxController {
  GetStorage box = GetStorage();
  FacturadorProvider provider = Get.put(FacturadorProvider());
  ProductFormController productFormCnt = Get.put(ProductFormController());

  //controllers
  TextEditingController nameCnt = TextEditingController();
  TextEditingController barcodeCnt = TextEditingController();
  TextEditingController descriptionCnt = TextEditingController();
  TextEditingController factorCnt = TextEditingController();
  TextEditingController price1Cnt = TextEditingController(text: "0");
  TextEditingController price2Cnt = TextEditingController(text: "0");
  TextEditingController price3Cnt = TextEditingController(text: "0");

  /** -- START STATES -- */
  Rx<int?> presentationIndex = RxNullable<int?>().setNull();
  Rx<UnitType?> unitTypeSelected = RxNullable<UnitType?>().setNull();
  Rx<DefaultPriceModel?> defaultPriceSelected =
      RxNullable<DefaultPriceModel?>().setNull();

  // Tracking inputs
  RxString barcode = "".obs;
  RxString description = "".obs;
  RxString factor = "".obs;
  RxString price1 = "0".obs;
  RxString price2 = "0".obs;
  RxString price3 = "0".obs;

  /** -- ENDING STATES -- */

  @override
  void onInit() async {
    if (Get.arguments != null) {
      presentationIndex.value = Get.arguments;
      onFirstSelection(index: Get.arguments);
    } else {
      onFirstSelection();
    }
    super.onInit();
  }

  void onFirstSelection({int? index = null}) {
    List<S2Choice<UnitType>> choices = productFormCnt.unitTypesChoices;
    List<S2Choice<DefaultPriceModel>> choicesPrices = defaultPriceChoices;
    if (index == null) {
      final unitTypeChoice = choices.firstWhere((e) {
        return e.value.id == "NIU";
      });
      final defaultPrice = choicesPrices.firstWhere((e) {
        return e.value.id == 2;
      });
      unitTypeSelected.value = unitTypeChoice.value;
      defaultPriceSelected.value = defaultPrice.value;
    } else {
      ItemUnitType presentation = productFormCnt.presentations[index];
      final unitTypeChoice = choices.firstWhere((e) {
        return e.value.id == presentation.unitTypeId;
      });
      final defaultPrice = choicesPrices.firstWhere((e) {
        return e.value.id == presentation.priceDefault;
      });
      unitTypeSelected.value = unitTypeChoice.value;
      defaultPriceSelected.value = defaultPrice.value;
      if (presentation.barcode != null) {
        barcodeCnt.text = presentation.barcode!;
        barcode.value = presentation.barcode!;
      }
      descriptionCnt.text = presentation.description;
      description.value = presentation.description;
      String _factor = double.parse(
        presentation.quantityUnit,
      ).toStringAsFixed(0);
      factorCnt.text = _factor;
      factor.value = _factor;
      String _price1 = formatMoney(
        quantity: double.parse(presentation.price1),
        decimalDigits: 2,
      );
      price1.value = presentation.price1;
      String _price2 = formatMoney(
        quantity: double.parse(presentation.price2),
        decimalDigits: 2,
      );
      price2.value = presentation.price2;
      String _price3 = formatMoney(
        quantity: double.parse(presentation.price3),
        decimalDigits: 2,
      );
      price3.value = presentation.price3;
      price1Cnt.text = _price1;
      price2Cnt.text = _price2;
      price3Cnt.text = _price3;
    }
  }

  Future<void> onScanBarcode(BuildContext context) async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        hexPrimaryColor,
        'Cancelar',
        true,
        ScanMode.BARCODE,
      );
      if (barcodeScanRes != "-1") {
        barcodeCnt.text = barcodeScanRes;
      }
    } on PlatformException {
      displayErrorMessage(
        message: "La plataforma no es válida para el scanner.",
      );
    } catch (error) {
      displayErrorMessage(
        message: "El código de barras no es válido.",
      );
    }
  }

  void onSavePresentation() {
    if (descriptionCnt.text.isEmpty ||
        factorCnt.text.isEmpty ||
        unitTypeSelected.value == null) {
      return displayWarningMessage(
        message: "Por favor ingrese la información requerida",
      );
    }
    String pricing = "";
    if (defaultPriceSelected.value!.id == 1) pricing = price1.value;
    if (defaultPriceSelected.value!.id == 2) pricing = price2.value;
    if (defaultPriceSelected.value!.id == 3) pricing = price3.value;
    if (pricing.isEmpty || double.parse(pricing) == 0) {
      int number = defaultPriceSelected.value!.id;
      return displayWarningMessage(
        message: "El precio $number debe ser mayor a 0",
      );
    }
    ItemUnitType presentation = ItemUnitType(
      description: descriptionCnt.text,
      unitTypeId: unitTypeSelected.value!.id,
      quantityUnit: factorCnt.text,
      price1: price1.value,
      price2: price2.value,
      price3: price3.value,
      priceDefault: defaultPriceSelected.value!.id,
      unitType: unitTypeSelected.value!,
    );
    if (presentationIndex.value != null) {
      int index = presentationIndex.value!;
      ItemUnitType? recordEdition = productFormCnt.presentations[index];
      presentation.id = recordEdition.id;
    }
    if (presentationIndex.value != null) {
      int index = presentationIndex.value!;
      productFormCnt.presentations[index] = presentation;
    } else {
      productFormCnt.presentations.add(presentation);
    }
    Get.back();
  }
}
