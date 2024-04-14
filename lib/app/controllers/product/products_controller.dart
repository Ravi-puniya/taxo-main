import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:facturadorpro/shared/getx.dart';
import 'package:facturadorpro/shared/mapping.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/api/models/product_list_response_model.dart';
import 'package:facturadorpro/api/models/response_model.dart';
import 'package:facturadorpro/app/ui/models/filter_column_model.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ProductsController extends GetxController {
  GetStorage box = GetStorage();
  FacturadorProvider provider = Get.put(FacturadorProvider());

  final ScrollController scrollController = ScrollController();
  final TextEditingController fieldValueCnt = TextEditingController();
  final DateRangePickerController dueDateCnt = DateRangePickerController();

  RxInt page = 1.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isDeleting = false.obs;
  RxBool hasMorePages = false.obs;

  RxInt currentIdAction = 0.obs;
  RxList<ProductData> products = <ProductData>[].obs;

  // Filter states
  RxList<S2Choice<FilterColumnModel>> columns = productColumns.obs;

  Rx<FilterColumnModel> selectedColumn = productColumns[0].value.obs;
  Rx<DateTime?> pickedDueDate = RxNullable<DateTime?>().setNull();
  Rx<String?> dueDate = RxNullable<String?>().setNull();
  Rx<String> fieldValue = "".obs;

  Rx<FilterColumnModel> prevColumn = productColumns[0].value.obs;
  Rx<DateTime?> prevPickedDueDate = RxNullable<DateTime?>().setNull();
  Rx<String?> prevDueDate = RxNullable<String?>().setNull();
  Rx<String> prevFieldValue = "".obs;

  @override
  void onInit() async {
    filterProducts();
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
      if (hasMorePages.value == true) filterMoreProducts();
    }
  }

  void onDeleteProduct({required ProductData product}) {
    Get.defaultDialog(
      title: "¡Confirmación!",
      middleText: '¿Desea eliminar este producto ${product.description}?',
      confirmTextColor: Colors.white,
      textCancel: "No",
      contentPadding: EdgeInsets.all(16),
      titlePadding: EdgeInsets.only(top: 16),
      actions: [
        spaceH(16),
        SizedBox(
          height: 48,
          child: TextButton(
            onPressed: () async {
              Get.back();
              await deleteItem(id: product.id);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ELIMINAR PRODUCTO",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                spaceW(8),
                Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ],
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              backgroundColor: Colors.red.shade50,
            ),
          ),
        ),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: TextButton(
            onPressed: () => Get.back(),
            child: Text("CANCELAR"),
            style: TextButton.styleFrom(
              foregroundColor: textColor.shade300,
            ),
          ),
        ),
      ],
      confirm: SizedBox(),
      cancel: SizedBox(),
      radius: 8,
    );
  }

  Future<void> deleteItem({required int id}) async {
    try {
      showLoader(status: "Espere...");
      final Response res = await provider.deleteProduct(id: id);
      if (res.statusCode == 200) {
        ResponseModel response = responseModelFromJson(res.bodyString!);
        if (response.success == true) {
          List<ProductData> c = products.where((e) => e.id != id).toList();
          products.value = c;
          displaySuccessMessage(message: response.message);
        } else {
          displayWarningMessage(message: response.message);
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      dismissLoader();
    }
  }

  void onChangeSelectedId({required int id, bool validate = true}) {
    if (validate == false || currentIdAction.value != id) {
      currentIdAction.value = id;
    } else {
      currentIdAction.value = 0;
    }
  }

  Future<void> filterProducts({bool? useLoader = true}) async {
    try {
      print("asasas");
      if (useLoader == true) isLoading.value = true;
      final Response res = await provider.filterProducts(
        page: 1,
        column: selectedColumn.value.id,
        value: selectedColumn.value.id == "date_of_due"
            ? dueDate.value ?? ""
            : fieldValue.value,
      );
      if (res.statusCode == 200) {
        ProductListResponseModel response = productListResponseModelFromJson(
          res.bodyString!,
        );
        hasMorePages.value = response.links.next != null;
        products.value = response.data;
        page.value = 1;
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      if (useLoader == true) isLoading.value = false;
    }
  }

  Future<void> filterMoreProducts() async {
    try {
      isLoadingMore.value = true;
      final Response res = await provider.filterProducts(
        page: page.value + 1,
        column: selectedColumn.value.id,
        value: selectedColumn.value.id == "date_of_due"
            ? dueDate.value ?? ""
            : fieldValue.value,
      );
      if (res.statusCode == 200) {
        ProductListResponseModel response = productListResponseModelFromJson(
          res.bodyString!,
        );
        hasMorePages.value = response.links.next != null;
        products.addAll(response.data);
        page.value++;
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingMore.value = false;
    }
  }

  // Filter functions
  void saveOnPreviousValue() {
    prevColumn.value = selectedColumn.value;
    prevFieldValue.value = fieldValue.value;
    prevPickedDueDate.value = pickedDueDate.value;
    prevDueDate.value = dueDate.value;
  }

  void onClearFilters() {
    selectedColumn.value = productColumns[0].value;
    fieldValueCnt.text = "";
    fieldValue.value = "";
    dueDate.value = null;
    pickedDueDate.value = null;
  }

  void resetPreviousValues() {
    selectedColumn.value = prevColumn.value;
    fieldValue.value = prevFieldValue.value;
    fieldValueCnt.text = prevFieldValue.value;
    pickedDueDate.value = prevPickedDueDate.value;
    dueDate.value = prevDueDate.value;
  }

  void onSelectColumn({required S2SingleSelected selected}) {
    selectedColumn.value = selected.value;
    if (selected.value.id != "date_of_due") {
      dueDate.value = null;
      pickedDueDate.value = null;
    } else {
      fieldValue.value = "";
      fieldValueCnt.text = "";
    }
  }
}
