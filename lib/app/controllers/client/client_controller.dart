import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/shared/mapping.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/api/models/client_model.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/api/models/response_model.dart';
import 'package:facturadorpro/app/ui/models/filter_column_model.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';

class ClientController extends GetxController {
  GetStorage box = GetStorage();
  FacturadorProvider provider = Get.put(FacturadorProvider());

  TextEditingController fieldValueCnt = TextEditingController();
  final ScrollController scrollController = ScrollController();

  RxInt page = 1.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isDeleting = false.obs;
  RxBool hasMorePages = false.obs;

  RxInt currentIdAction = 0.obs;
  RxList<ClientData> clients = <ClientData>[].obs;

  // Filter states
  RxList<S2Choice<FilterColumnModel>> columns = clientColumns.obs;

  Rx<FilterColumnModel> selectedColumn = clientColumns[0].value.obs;
  Rx<String> fieldValue = "".obs;

  Rx<FilterColumnModel> prevColumn = clientColumns[0].value.obs;
  Rx<String> prevFieldValue = "".obs;

  @override
  void onInit() async {
    filterClients();
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
      if (hasMorePages.value == true) filterMoreClients();
    }
  }

  void onChangeSelectedId({required int id, bool validate = true}) {
    if (validate == false || currentIdAction.value != id) {
      currentIdAction.value = id;
    } else {
      currentIdAction.value = 0;
    }
  }

  Future<void> filterClients({bool? useLoader = true}) async {
    try {
      if (useLoader == true) isLoading.value = true;
      final Response res = await provider.filterClients(
        page: 1,
        column: selectedColumn.value.id,
        value: fieldValue.value,
      );
      print(res.bodyString!);
      if (res.statusCode == 200) {
        ClientModel response = clientModelFromJson(res.bodyString!);
        hasMorePages.value = response.links.next != null;
        clients.value = response.data;
        page.value = 1;
      }
    } catch (error, s) {
      print(error);
      print(s);
      displayErrorMessage();
    } finally {
      if (useLoader == true) isLoading.value = false;
    }
  }

  Future<void> filterMoreClients() async {
    try {
      isLoadingMore.value = true;
      final Response res = await provider.filterClients(
        page: page.value + 1,
        column: selectedColumn.value.id,
        value: fieldValue.value,
      );
      if (res.statusCode == 200) {
        ClientModel response = clientModelFromJson(res.bodyString!);
        hasMorePages.value = response.links.next != null;
        clients.addAll(response.data);
        page.value++;
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingMore.value = false;
    }
  }

  void onDeleteClient({required ClientData client}) {
    Get.defaultDialog(
      title: "¡Confirmación!",
      middleText: '¿Desea eliminar este cliente ${client.description}?',
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
              await _onDeleteClient(client: client);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ELIMINAR CLIENTE",
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

  Future<void> _onDeleteClient({required ClientData client}) async {
    try {
      showLoader(status: "Espere...");
      final Response res = await provider.deleteClient(id: client.id);
      if (res.statusCode == 200) {
        ResponseModel response = responseModelFromJson(res.bodyString!);
        if (response.success == true) {
          List<ClientData> c = clients.where((e) => e.id != client.id).toList();
          clients.value = c;
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

  // Filter functions
  void saveOnPreviousValue() {
    prevColumn.value = selectedColumn.value;
    prevFieldValue.value = fieldValue.value;
  }

  void onClearFilters() {
    selectedColumn.value = FilterColumnModel(
      id: "name",
      description: "Nombre",
    );
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
