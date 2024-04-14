import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:facturadorpro/app/controllers/cash/cash_controller.dart';
import 'package:facturadorpro/api/models/response/cash_model.dart';
import 'package:facturadorpro/api/models/init_params_cash_model.dart';
import 'package:facturadorpro/api/models/response_model.dart';
import 'package:facturadorpro/api/models/retrieve_cash_model.dart';
import 'package:facturadorpro/api/models/user_active_cash_model.dart';
import 'package:facturadorpro/app/ui/widgets/custom_alert.dart';

class CashFormController extends GetxController {
  GetStorage box = GetStorage();
  FacturadorProvider provider = Get.put(FacturadorProvider());
  final cashController = Get.find<CashController>();

  final ScrollController scrollController = ScrollController();
  final TextEditingController balanceCnt = TextEditingController();
  final TextEditingController referenceCnt = TextEditingController();

  RxInt cashBoxId = 0.obs;
  RxBool isLoadingParams = true.obs;
  RxBool isSaving = false.obs;
  RxBool isRetrieving = false.obs;

  RxList<Map<String, dynamic>> sellers = <Map<String, dynamic>>[].obs;
  RxString sellerId = "".obs;
  RxDouble initialBalance = 0.0.obs;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      await onInitForm(id: Get.arguments);
    } else {
      await onInitForm();
    }
    super.onInit();
  }

  void onChangeSeller({required int id}) {
    sellerId.value = id.toString();
  }

  void onChangedInitialValue(String value) {
    if (value.isNotEmpty) {
      initialBalance.value = double.parse(value.replaceAll(",", ""));
    } else {
      initialBalance.value = 0;
    }
  }

  void resetValues() {
    sellerId.value = "";
    sellers.value = <Map<String, dynamic>>[];
    cashBoxId.value = 0;
    initialBalance.value = 0.0;
    Get.back();
  }

  Future<void> onInitForm({int? id}) async {
    try {
      isLoadingParams.value = true;
      final Response res = await provider.initParamsCashBox();
      if (res.statusCode == 200) {
        InitParamsCashModel result = initParamsCashModelFromJson(
          res.bodyString!,
        );
        List<Map<String, dynamic>> _sellers = <Map<String, dynamic>>[];
        for (var element in result.users) {
          Map<String, dynamic> seller = {
            "value": element.id,
            "label": element.name,
          };
          _sellers.add(seller);
        }
        sellers.value = _sellers.toList();
        sellerId.value = result.user.id.toString();
        update();
        if (id != null) await retrieveCashInfo(id: id);
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingParams.value = false;
    }
  }

  Future<void> retrieveCashInfo({required int id}) async {
    try {
      isRetrieving.value = true;
      final Response res = await provider.retrieveCashInfo(id: id);
      if (res.statusCode == 200) {
        RetrieveCashModel result = retrieveCashModelFromJson(res.bodyString!);
        CashItemModel retrievedInfo = result.data;
        cashBoxId.value = retrievedInfo.id;
        sellerId.value = retrievedInfo.userId.toString();
        if (retrievedInfo.referenceNumber != null) {
          referenceCnt.value = TextEditingValue(
            text: retrievedInfo.referenceNumber!,
          );
        }
        initialBalance.value = double.parse(retrievedInfo.beginningBalance);
        balanceCnt.value = TextEditingValue(
          text: formatMoney(
            quantity: double.parse(retrievedInfo.beginningBalance),
            decimalDigits: 2,
          ),
        );
        update();
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isRetrieving.value = false;
    }
  }

  Future<void> onSaveCashBox(BuildContext context) async {
    if (cashBoxId.value != 0) {
      await updateCashBox(context);
    } else {
      await registerCashBox(context);
    }
  }

  Future<void> registerCashBox(BuildContext context) async {
    try {
      isSaving.value = true;
      Navigator.pop(context);
      customAlert(
        context: context,
        type: CoolAlertType.loading,
        message: "Guardando registro....",
      );
      final Response resCheck = await provider.checkCashByUser(
        id: int.parse(sellerId.value),
      );
      if (resCheck.statusCode == 200) {
        UserActiveCashModel result = userActiveCashModelFromJson(
          resCheck.bodyString!,
        );
        if (result.cash == null) {
          final Response res = await provider.registerCashBox(
            initialBalance: initialBalance.value,
            sellerId: int.parse(sellerId.value),
            referenceCode: referenceCnt.text,
          );
          if (res.statusCode == 200) {
            ResponseModel response = responseModelFromJson(res.bodyString!);
            Navigator.pop(context);
            if (response.success == true) {
              await cashController.filterCashBoxes(useLoader: false);
              resetValues();
              customAlert(
                context: context,
                type: CoolAlertType.success,
                title: "¡Petición exitosa!",
                message: response.message,
              );
            } else {
              customAlert(
                context: context,
                type: CoolAlertType.error,
                title: "¡Error en petición!",
                message: response.message,
              );
            }
          }
        } else {
          Navigator.pop(context);
          customAlert(
            context: context,
            type: CoolAlertType.warning,
            title: "¡Advertencia!",
            message: "Ya existe una caja aperturada para el usuario",
          );
        }
      }
    } catch (error) {
      Navigator.pop(context);
      displayErrorMessage();
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> updateCashBox(BuildContext context) async {
    try {
      isSaving.value = true;
      Navigator.pop(context);
      customAlert(
        context: context,
        type: CoolAlertType.loading,
        message: "Guardando datos....",
      );
      final Response res = await provider.updateCashBox(
        cashId: cashBoxId.value,
        initialBalance: initialBalance.value,
        sellerId: int.parse(sellerId.value),
        referenceCode: referenceCnt.text,
      );
      if (res.statusCode == 200) {
        ResponseModel response = responseModelFromJson(res.bodyString!);
        Navigator.pop(context);
        if (response.success == true) {
          await cashController.filterCashBoxes(useLoader: false);
          resetValues();
          customAlert(
            context: context,
            type: CoolAlertType.success,
            title: "¡Perfecto!",
            message: response.message,
          );
        } else {
          customAlert(
            context: context,
            type: CoolAlertType.error,
            title: "¡Error!",
            message: response.message,
          );
        }
      }
    } catch (error) {
      Navigator.pop(context);
      displayErrorMessage();
    } finally {
      isSaving.value = false;
    }
  }
}
