import 'package:facturadorpro/api/models/response/product_retrieved_model.dart';
import 'package:facturadorpro/api/models/response/product_saved_response_model.dart';
import 'package:facturadorpro/api/models/response_model.dart';
import 'package:facturadorpro/app/controllers/product/products_controller.dart';
import 'package:facturadorpro/app/ui/models/product_param_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:facturadorpro/shared/getx.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/api/models/part/item_unit_type.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:facturadorpro/api/models/response/init_params_pos.dart';
import 'package:facturadorpro/api/models/init_params_product_model.dart';
import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';
import 'package:facturadorpro/app/ui/pages/products_page/constants/panel_list.dart';

class ProductFormController extends GetxController {
  GetStorage box = GetStorage();
  FacturadorProvider provider = Get.put(FacturadorProvider());
  ProductsController productCnt = Get.put(ProductsController());

  //controllers
  TextEditingController nameCnt = TextEditingController();
  TextEditingController secondaryNameCnt = TextEditingController();
  TextEditingController descriptionCnt = TextEditingController();
  TextEditingController modelCnt = TextEditingController();
  TextEditingController unitPriceCnt = TextEditingController(text: "0.00");
  TextEditingController unitPricePurchaseCnt =
      TextEditingController(text: "0.00");
  TextEditingController minimumStockCnt = TextEditingController(text: "1");
  TextEditingController initialStockCnt = TextEditingController(text: "0");
  DateRangePickerController expirationCnt = DateRangePickerController();
  TextEditingController barcodeCnt = TextEditingController();
  TextEditingController internalCodeCnt = TextEditingController();
  TextEditingController lotCodeController = TextEditingController();

  /** -- START STATES -- */
  RxList<bool> expandedPanels = [true, false, false, false].obs;

  RxBool isSaving = false.obs;
  RxBool isLoadingParams = false.obs;
  RxBool isRetrieving = false.obs;

  RxList<S2Choice<UnitType>> unitTypesChoices = <S2Choice<UnitType>>[].obs;
  RxList<S2Choice<AffectationIgvType>> affectationIgvTypesChoices =
      <S2Choice<AffectationIgvType>>[].obs;
  RxList<S2Choice<CurrencyType>> currencyTypesChoices =
      <S2Choice<CurrencyType>>[].obs;
  RxList<S2Choice<Warehouses>> warehousesChoices = <S2Choice<Warehouses>>[].obs;
  RxList<S2Choice<Category>> categoryChoices = <S2Choice<Category>>[].obs;
  RxList<S2Choice<Brand>> brandChoices = <S2Choice<Brand>>[].obs;
  RxList<S2Choice<Type>> attributeTypesChoices = <S2Choice<Type>>[].obs;

  // Form states
  Rx<UnitType?> unitTypeSelected = RxNullable<UnitType?>().setNull();
  Rx<AffectationIgvType?> affectationTypeSelected =
      RxNullable<AffectationIgvType?>().setNull();
  Rx<Warehouses?> warehouseSelected = RxNullable<Warehouses?>().setNull();
  Rx<CurrencyType?> currencyTypeSelected =
      RxNullable<CurrencyType?>().setNull();
  Rx<Category?> categorySelected = RxNullable<Category?>().setNull();
  Rx<Brand?> brandSelected = RxNullable<Brand?>().setNull();
  Rx<DateTime?> pickedExpiration = RxNullable<DateTime?>().setNull();
  Rx<String?> expirationDate = RxNullable<String?>().setNull();
  RxBool includeIgv = false.obs;
  RxBool includePurchaseIgv = false.obs;
  RxBool calculateQuantityPerPrice = false.obs;
  RxList<ItemUnitType> presentations = <ItemUnitType>[].obs;
  Rx<AffectationIgvType?> affectationIgvPurchase =
      RxNullable<AffectationIgvType?>().setNull();

  // Tracking inputs
  RxString model = "".obs;
  RxString unitPrice = "".obs;
  RxString unitPricePurchase = "".obs;
  RxString minimumStock = "".obs;
  RxString initialStock = "".obs;
  RxString barcode = "".obs;
  RxString internalCode = "".obs;

  Rx<int?> productId = RxNullable<int?>().setNull();
  /** -- ENDING STATES -- */

  @override
  void onInit() async {
    if (Get.arguments != null) {
      productId.value = Get.arguments;
      print(productId.value);
      await onInitForm(id: Get.arguments);
    } else {
      productId.value = null;
      await onInitForm();
    }
    super.onInit();
  }

  Future<void> onInitForm({int? id = null}) async {
    try {
      isLoadingParams.value = true;
      final Response res = await provider.initParamsProduct();
      if (res.statusCode == 200) {
        InitParamsProductModel result = initParamsProductModelFromJson(
          res.bodyString!,
        );
        unitTypesChoices.value = result.unitTypes.map((e) {
          return S2Choice(value: e, title: e.description);
        }).toList();

        final affectationIgvTypes = result.affectationIgvTypes;

        affectationIgvTypesChoices.value = affectationIgvTypes.map((e) {
          return S2Choice(value: e, title: e.description);
        }).toList();

        currencyTypesChoices.value = result.currencyTypes.map((e) {
          return S2Choice(value: e, title: e.description);
        }).toList();

        warehousesChoices.value = result.warehouses.map((e) {
          return S2Choice(value: e, title: e.description);
        }).toList();

        categoryChoices.value = result.categories.map((e) {
          return S2Choice(value: e, title: e.name);
        }).toList();

        brandChoices.value = result.brands.map((e) {
          return S2Choice(value: e, title: e.name);
        }).toList();

        attributeTypesChoices.value = result.attributeTypes.map((e) {
          return S2Choice(value: e, title: e.description);
        }).toList();

        if (result.configuration.includeIgv) {
          affectationIgvPurchase.value = affectationIgvTypes.firstWhereOrNull(
            (e) => e.id == "10",
          );
        }

        if (id != null) {
          await onRetrieveInfoProduct(id: id);
        } else {
          includeIgv.value = result.configuration.includeIgv;

          warehouseSelected.value = result.warehouses.firstWhereOrNull(
            (e) => e.id == result.configuration.warehouseId,
          );

          currencyTypeSelected.value = result.currencyTypes.firstWhere(
            (e) => e.id == "PEN",
          );

          affectationTypeSelected.value = affectationIgvTypes.firstWhereOrNull(
            (e) => e.id == result.configuration.affectationIgvTypeId,
          );

          unitTypeSelected.value = result.unitTypes.firstWhere(
            (e) => e.id == "NIU",
          );
        }
      }
    } catch (error) {
      print(error);
      displayErrorMessage();
    } finally {
      isLoadingParams.value = false;
    }
  }

  Future<void> onRetrieveInfoProduct({required int id}) async {
    try {
      isRetrieving.value = true;
      Response res = await provider.retrieveProduct(id: id);
      if (res.statusCode == 200) {
        ProductRetrievedModel result = productRetrievedModelFromJson(
          res.bodyString!,
        );
        if (result.data != null) {
          RetrievedItem info = result.data!;
          // General
          includeIgv.value = info.hasIgv;
          calculateQuantityPerPrice.value = info.calculateQuantity;
          nameCnt.text = info.description;
          if (info.model != null) {
            modelCnt.text = info.model!;
            model.value = info.model!;
          }
          unitTypeSelected.value = unitTypesChoices
              .firstWhere((e) => e.value.id == info.unitTypeId)
              .value;
          currencyTypeSelected.value = currencyTypesChoices
              .firstWhere((e) => e.value.id == info.currencyTypeId)
              .value;
          String price = formatMoney(
            quantity: info.saleUnitPrice,
            decimalDigits: 2,
          );
          unitPriceCnt.text = price;
          unitPrice.value = price;
          affectationTypeSelected.value = affectationIgvTypesChoices
              .firstWhere((e) => e.value.id == info.saleAffectationIgvTypeId)
              .value;
          if (info.warehouseId != null) {
            warehouseSelected.value = warehousesChoices
                .firstWhere((e) => e.value.id == info.warehouseId)
                .value;
          }
          String minStock = double.parse(info.stockMin).toStringAsFixed(0);
          String stock = double.parse(info.stock).toStringAsFixed(0);
          minimumStockCnt.text = minStock;
          minimumStock.value = minStock;
          initialStockCnt.text = stock;
          initialStock.value = stock;
          if (info.dateOfDue != null) {
            expirationDate.value = DateFormat("yyyy-MM-dd").format(
              DateTime.parse(info.dateOfDue!),
            );
            pickedExpiration.value = DateTime.parse(info.dateOfDue!);
          }
          if (info.barcode != null) {
            barcodeCnt.text = info.barcode!;
            barcode.value = info.barcode!;
          }
          if (info.internalId != null) {
            internalCodeCnt.text = info.internalId!;
            internalCode.value = info.internalId!;
          }
          // Presentaciones
          if (info.itemUnitTypes.length > 0) {
            List<ItemUnitType> _presentations = [];
            info.itemUnitTypes.forEach((e) {
              ItemUnitType presentation = ItemUnitType(
                id: e.id,
                description: e.description,
                unitTypeId: e.unitTypeId,
                quantityUnit: e.quantityUnit,
                price1: e.price1,
                price2: e.price2,
                price3: e.price3,
                priceDefault: e.priceDefault,
                unitType: UnitType(
                  id: e.unitType.id,
                  description: e.unitType.description,
                  active: e.unitType.active,
                  symbol: e.unitType.symbol,
                ),
              );
              _presentations.add(presentation);
            });
            presentations.value = _presentations;
          }
          // Atributos
          if (info.categoryId != null) {
            categorySelected.value = categoryChoices
                .firstWhere((e) => e.value.id == info.categoryId)
                .value;
          }
          if (info.brandId != null) {
            brandSelected.value = brandChoices
                .firstWhere((e) => e.value.id == info.brandId)
                .value;
          }
          // Compra
          affectationIgvPurchase.value = affectationIgvTypesChoices.firstWhere(
            (e) {
              return e.value.id == info.purchaseAffectationIgvTypeId;
            },
          ).value;
          String purchasePrice = formatMoney(
            quantity: info.purchaseUnitPrice,
            decimalDigits: 2,
          );
          unitPricePurchaseCnt.text = purchasePrice;
          includePurchaseIgv.value = info.purchaseHasIgv;
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isRetrieving.value = false;
    }
  }

  void onExpandedPanel({required int index, required bool isExpanded}) {
    for (int i = 0; i < panelList.length; i++) {
      if (index == i) {
        expandedPanels[index] = !isExpanded;
      } else {
        expandedPanels[i] = false;
      }
    }
    update();
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
        barcode.value = barcodeScanRes;
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

  Future<void> removePresentations({
    required int index,
    required ItemUnitType itemUnitType,
  }) async {
    try {
      if (itemUnitType.id != null) {
        showLoader(status: "Espere...");
        Response res = await provider.deleteUnitTypeOfProduct(
          id: itemUnitType.id!,
        );
        if (res.statusCode == 200) {
          ResponseModel result = responseModelFromJson(res.bodyString!);
          if (result.success) {
            presentations.removeAt(index);
            displaySuccessMessage(message: result.message);
          } else {
            displayWarningMessage(message: result.message);
          }
        }
      } else {
        presentations.removeAt(index);
      }
      update();
    } catch (error) {
      displayErrorMessage();
    } finally {
      dismissLoader();
    }
  }

  Future<void> onSaveProduct(BuildContext context) async {
    try {
      if (nameCnt.text.isEmpty) {
        Navigator.of(context).pop();
        return displayWarningMessage(
          message: "Por favor ingrese el nombre del producto",
        );
      }
      if (unitPriceCnt.text.isEmpty) {
        Navigator.of(context).pop();
        return displayWarningMessage(
          message: "Por favor ingrese el precio unitario de venta",
        );
      }
      if (unitPricePurchaseCnt.text.isEmpty) {
        Navigator.of(context).pop();
        return displayWarningMessage(
          message: "Por favor ingrese el precio unitario de compra",
        );
      }
      if (warehouseSelected.value == null) {
        Navigator.of(context).pop();
        return displayWarningMessage(
          message: "Por favor seleccione el almacén",
        );
      }
      Get.back();
      showLoader(status: "Espere...");
      final item = ProductParamModel(
        itemTypeId: "01",
        name: nameCnt.text,
        unitTypeId: unitTypeSelected.value!.id,
        currencyTypeId: currencyTypeSelected.value!.id,
        saleUnitPrice: unitPriceCnt.text.replaceAll(",", ""),
        saleAffectationIgvTypeId: affectationTypeSelected.value!.id,
        purchaseAffectationIgvTypeId: affectationIgvPurchase.value!.id,
        calculateQuantity: calculateQuantityPerPrice.value,
        stock: initialStockCnt.text,
        stockMin: int.parse(minimumStockCnt.text),
        hasIgv: includeIgv.value,
        itemUnitTypes: presentations,
        purchaseHasIgv: includePurchaseIgv.value,
        warehouseId: warehouseSelected.value!.id,
        itemWarehousePrices: <ItemWarehousePrice>[
          ItemWarehousePrice(
            warehouseId: warehouseSelected.value!.id,
            description: warehouseSelected.value!.description,
          ),
        ],
        purchaseUnitPrice: unitPricePurchaseCnt.text.replaceAll(",", ""),
      );
      if (productId.value != null) {
        item.id = productId.value;
      }
      if (barcodeCnt.text.isNotEmpty) {
        item.barcode = barcodeCnt.text;
      }
      if (brandSelected.value != null) {
        item.brandId = brandSelected.value!.id;
      }
      if (categorySelected.value != null) {
        item.categoryId = categorySelected.value!.id;
      }
      if (expirationDate.value != null) {
        item.dateOfDue = expirationDate.value;
      }
      if (internalCodeCnt.text.isNotEmpty) {
        item.internalId = internalCodeCnt.text;
      }
      if (modelCnt.text.isNotEmpty) {
        item.model = modelCnt.text;
      }
      Response res = await provider.saveProduct(item: item);
      if (res.statusCode == 200) {
        ProductSavedResponseModel result = productSavedResponseModelFromJson(
          res.bodyString!,
        );
        if (result.success) {
          productCnt.filterProducts(useLoader: false);
          Get.back();
          displaySuccessMessage(message: result.message);
        } else {
          displayWarningMessage(message: result.message);
        }
      }
    } catch (error) {
      displayErrorMessage(message: error.toString());
    } finally {
      dismissLoader();
    }
  }
}
