import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/shared/mapping.dart';
import 'package:facturadorpro/api/models/response_model.dart';
import 'package:facturadorpro/app/ui/widgets/custom_alert.dart';
import 'package:facturadorpro/api/models/response/cash_model.dart';
import 'package:facturadorpro/app/ui/models/filter_column_model.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';

class CashController extends GetxController {
  GetStorage box = GetStorage();
  FacturadorProvider provider = Get.put(FacturadorProvider());

  final ScrollController scrollController = ScrollController();
  final TextEditingController fieldValueCnt = TextEditingController();

  RxInt page = 1.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasMorePages = false.obs;
  RxBool isDeleting = false.obs;
  RxBool isClosing = false.obs;

  RxInt currentIdAction = 0.obs;
  RxList<CashItemModel> cashBoxes = <CashItemModel>[].obs;

  // Filter states
  RxList<S2Choice<FilterColumnModel>> columns = cashBoxColumns.obs;

  Rx<FilterColumnModel> selectedColumn = cashBoxColumns[0].value.obs;
  Rx<String> fieldValue = "".obs;

  Rx<FilterColumnModel> prevColumn = cashBoxColumns[0].value.obs;
  Rx<String> prevFieldValue = "".obs;

  @override
  void onInit() async {
    filterCashBoxes();
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (hasMorePages.value == true) filterMoreCashBoxes();
    }
  }

  // Change selected item id
  void onChangeSelectedId({required int id, bool validate = true}) {
    if (validate == false || currentIdAction.value != id) {
      currentIdAction.value = id;
    } else {
      currentIdAction.value = 0;
    }
  }

  // Initial filter
  Future<void> filterCashBoxes({bool? useLoader = true}) async {
    try {
      if (useLoader == true) isLoading.value = true;
      final Response res = await provider.filterCashBoxes(
        page: 1,
        column: selectedColumn.value.id,
        value: fieldValue.value,
      );
      if (res.statusCode == 200) {
        CashModel response = cashModelFromJson(res.bodyString!);
        if (response.data.isNotEmpty) {
          hasMorePages.value = response.links.next != null;
          cashBoxes.value = response.data;
          page.value = 1;
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      if (useLoader == true) isLoading.value = false;
    }
  }

  // Load more - pagination
  Future<void> filterMoreCashBoxes() async {
    try {
      isLoadingMore.value = true;
      final Response res = await provider.filterCashBoxes(
        page: page.value + 1,
        column: selectedColumn.value.id,
        value: fieldValue.value,
      );
      if (res.statusCode == 200) {
        CashModel response = cashModelFromJson(res.bodyString!);
        hasMorePages.value = response.links.next != null;
        cashBoxes.addAll(response.data);
        page.value++;
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingMore.value = false;
    }
  }

  // Delete item
  Future<void> deleteItem({
    required int id,
    required BuildContext context,
  }) async {
    try {
      isDeleting.value = true;
      Navigator.pop(context);
      customAlert(
        context: context,
        type: CoolAlertType.loading,
        message: "Eliminando caja chica....",
      );
      final Response res = await provider.deleteCashBox(id: id);
      if (res.statusCode == 200) {
        ResponseModel response = responseModelFromJson(res.bodyString!);
        Navigator.pop(context);
        if (response.success == true) {
          List<CashItemModel> f = cashBoxes.where((e) => e.id != id).toList();
          cashBoxes.value = f;
          customAlert(
            context: context,
            type: CoolAlertType.success,
            title: "¡Eliminación exitosa!",
            message: response.message,
          );
        } else {
          customAlert(
            context: context,
            type: CoolAlertType.error,
            title: "Error al eliminar",
            message: response.message,
          );
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isDeleting.value = false;
    }
  }

  // Close cash box
  Future<void> closeCashBox({
    required int id,
    required BuildContext context,
  }) async {
    try {
      isClosing.value = true;
      Navigator.pop(context);
      customAlert(
        context: context,
        type: CoolAlertType.loading,
        message: "Cerrando caja chica....",
      );
      final Response res = await provider.closeCashBox(id: id);
      if (res.statusCode == 200) {
        ResponseModel response = responseModelFromJson(res.bodyString!);
        Navigator.pop(context);
        if (response.success == true) {
          await filterCashBoxes(useLoader: false);
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
            title: "Error al eliminar",
            message: response.message,
          );
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isClosing.value = false;
    }
  }

  // Filter functions
  void saveOnPreviousValue() {
    prevColumn.value = selectedColumn.value;
    prevFieldValue.value = fieldValue.value;
  }

  void onClearFilters() {
    selectedColumn.value = cashBoxColumns[0].value;
    fieldValueCnt.text = "";
    fieldValue.value = "";
  }

  void resetPreviousValues() {
    selectedColumn.value = prevColumn.value;
    fieldValue.value = prevFieldValue.value;
    fieldValueCnt.text = prevFieldValue.value;
  }

  void onSelectColumn({required S2SingleSelected selected}) {
    selectedColumn.value = selected.value;
  }
}
