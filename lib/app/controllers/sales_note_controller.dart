import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:get_storage/get_storage.dart';

import 'package:facturadorpro/shared/getx.dart';
import 'package:facturadorpro/shared/mapping.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/shared/string_ext.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/api/models/response_model.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:facturadorpro/api/models/sale_note_response_model.dart';
import 'package:facturadorpro/app/controllers/vouchers_controller.dart';
import 'package:facturadorpro/app/ui/models/sale_note_column_model.dart';
import 'package:facturadorpro/app/controllers/directory_controller.dart';
import 'package:facturadorpro/api/models/request/filter_sale_note_req.dart';
import 'package:facturadorpro/app/ui/models/panel_options_voucher_model.dart';
import 'package:facturadorpro/api/models/response/pos_payments_params_model.dart';
import 'package:facturadorpro/api/models/response/print_sale_note_response_model.dart';
import 'package:facturadorpro/api/models/response/filter_sale_notes_params_response_model.dart';

class SaleNotesController extends GetxController {
  GetStorage box = GetStorage();

  FacturadorProvider provider = Get.put(FacturadorProvider());
  DirectoryController directoryCnt = Get.put(DirectoryController());
  VouchersController voucherCnt = Get.put(VouchersController());

  TextEditingController docNumberCnt = TextEditingController();
  TextEditingController clientCnt = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final DateRangePickerController emissionCnt = DateRangePickerController();

  RxInt page = 1.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasMorePages = false.obs;
  RxList<SaleNote> saleNotes = <SaleNote>[].obs;

  // Filter sale notes states
  RxList<S2Choice<SaleNoteColumnModel>> columns = columnsFilterSaleNote.obs;
  RxList<S2Choice<SaleNoteColumnModel>> totalPaid = statusPaidSaleNote.obs;
  Rx<DateTime?> pickedEmission = RxNullable<DateTime?>().setNull();
  RxList<S2Choice<Series>> series = <S2Choice<Series>>[].obs;

  Rx<SaleNoteColumnModel> selectedColumn = columnsFilterSaleNote[0].value.obs;
  Rx<SaleNoteColumnModel?> selectedTotalPaid =
      RxNullable<SaleNoteColumnModel?>().setNull();
  Rx<Series?> selectedSerie = RxNullable<Series?>().setNull();
  Rx<String?> emissionDate = RxNullable<String?>().setNull();
  Rx<String> correlative = "".obs;
  Rx<String> clientName = "".obs;

  Rx<SaleNoteColumnModel> prevColumn = columnsFilterSaleNote[0].value.obs;
  Rx<DateTime?> prevPickedEmission = RxNullable<DateTime?>().setNull();
  Rx<String?> prevEmissionDate = RxNullable<String?>().setNull();
  Rx<Series?> prevSerie = RxNullable<Series?>().setNull();
  Rx<SaleNoteColumnModel?> prevTotalPaid =
      RxNullable<SaleNoteColumnModel?>().setNull();
  Rx<String> prevCorrelative = "".obs;
  Rx<String> prevClientName = "".obs;

  @override
  void onInit() async {
    await filterSaleNotes();
    await onInitFilterParams();
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
      if (hasMorePages.value == true) filterMoreSaleNotes();
    }
  }

  Future<void> onInitFilterParams() async {
    try {
      isLoading.value = true;
      Response res = await provider.fetchFilterParamsSaleNotes();
      if (res.statusCode == 200) {
        FilterSaleNotesParamsResponse result =
            filterSaleNotesParamsResponseFromJson(
          res.bodyString!,
        );
        series.value = result.series.map((e) {
          return S2Choice(value: e, title: e.number.toTitleCase());
        }).toList();
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> filterSaleNotes({bool? useLoader = true}) async {
    try {
      if (useLoader == true) isLoading.value = true;
      FilterSaleNoteReq info = FilterSaleNoteReq(
        page: 1,
        column: selectedColumn.value.id,
      );
      if (selectedTotalPaid.value != null) {
        info.totalCanceled = selectedTotalPaid.value!.id;
      }
      if (selectedSerie.value != null) {
        info.series = selectedSerie.value!.number;
      }
      if (correlative.value.isNotEmpty) {
        info.number = docNumberCnt.text;
      }
      if (selectedColumn.value.id == "customer") {
        info.value = clientName.value;
      }
      if (selectedColumn.value.id == "date_of_issue") {
        info.value = emissionDate.value;
      }
      final Response res = await provider.fetchSaleNotesEndpoint(info: info);
      if (res.statusCode == 200) {
        SaleNoteResponseModel response = saleNoteResponseModelFromJson(
          res.bodyString!,
        );
        hasMorePages.value = response.links.next != null;
        saleNotes.value = response.data;
        page.value = 1;
      }
    } catch (error) {
      displayErrorMessage(message: error.toString());
    } finally {
      if (useLoader == true) isLoading.value = false;
    }
  }

  Future<void> filterMoreSaleNotes() async {
    try {
      isLoadingMore.value = true;
      FilterSaleNoteReq info = FilterSaleNoteReq(
        page: page.value + 1,
        column: selectedColumn.value.id,
      );
      if (selectedTotalPaid.value != null) {
        info.totalCanceled = selectedTotalPaid.value!.id;
      }
      if (selectedSerie.value != null) {
        info.series = selectedSerie.value!.number;
      }
      if (correlative.value.isNotEmpty) {
        info.number = docNumberCnt.text;
      }
      if (selectedColumn.value.id == "customer") {
        info.value = clientName.value;
      }
      if (selectedColumn.value.id == "date_of_issue") {
        info.value = emissionDate.value;
      }
      final Response res = await provider.fetchSaleNotesEndpoint(info: info);
      if (res.statusCode == 200) {
        SaleNoteResponseModel response = saleNoteResponseModelFromJson(
          res.bodyString!,
        );
        hasMorePages.value = response.links.next != null;
        saleNotes.addAll(response.data);
        page.value++;
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> onNullifySaleNote({required int id}) async {
    Get.defaultDialog(
      title: "¡Confirmación!",
      middleText:
          "¿Desea realizar esta anulación?\nAl continuar esta acción no será reversible.",
      confirmTextColor: Colors.white,
      textCancel: "No",
      contentPadding: EdgeInsets.all(16),
      titlePadding: EdgeInsets.only(top: 16),
      onConfirm: () {},
      actions: [
        SizedBox(
          height: 48,
          child: TextButton(
            onPressed: () async {
              Get.back();
              await _nullifySaleNote(id: id);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ANULAR NOTA DE VENTA",
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

  Future<void> _nullifySaleNote({required int id}) async {
    try {
      showLoader(status: "Anulando...");
      Response res = await provider.nullifySaleNoteEndpoint(id: id);
      if (res.statusCode == 200) {
        ResponseModel result = responseModelFromJson(res.bodyString!);
        if (result.success) {
          SaleNote? saleNote = await foundCurrentSaleNote(id: id);
          if (saleNote != null) {
            List<SaleNote> _tmp = saleNotes;
            int index = _tmp.indexWhere((e) => e.id == id);
            _tmp[index] = saleNote;
            displaySuccessMessage(message: result.message);
          } else {
            displayInfoMessage(message: "Documento no encontrado");
          }
        } else {
          displayWarningMessage(message: result.message);
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      dismissLoader();
    }
  }

  Future<SaleNote?> foundCurrentSaleNote({required int id}) async {
    SaleNote? saleNote = null;
    try {
      final info = FilterSaleNoteReq(
        page: 1,
        column: "id",
        value: id.toString(),
      );
      final Response res = await provider.fetchSaleNotesEndpoint(info: info);
      if (res.statusCode == 200) {
        SaleNoteResponseModel result = saleNoteResponseModelFromJson(
          res.bodyString!,
        );
        if (result.data.length == 1) {
          saleNote = result.data[0];
        }
        if (result.data.length > 1) {
          saleNote = result.data.firstWhereOrNull((e) => e.id == id);
        }
      }
    } catch (error) {
      displayErrorMessage(
        message: "Ha ocurrido un error, actualice los registros manualmente.",
      );
    }
    return saleNote;
  }

  void onShowOptionsPressed({
    required int id,
    required BuildContext context,
  }) async {
    try {
      showLoader(status: "Espere...");
      Response resDoc = await provider.fetchPrintSaleNoteInfo(
        documentId: id,
      );
      PrintSaleNoteResponseModel resultDoc = printSaleNoteResponseModelFromJson(
        resDoc.bodyString!,
      );
      if (resDoc.statusCode == 200) {
        if (directoryCnt.downloadDir.value.isNotEmpty) {
          bool isDownloadedTck = await existsDir(
            dirname: directoryCnt.downloadDir.value,
            filename: "${resultDoc.data.fullNumber}-ticket.pdf",
          );
          bool isDownloadedA4 = await existsDir(
            dirname: directoryCnt.downloadDir.value,
            filename: "${resultDoc.data.fullNumber}-a4.pdf",
          );
          voucherCnt.existsA4.value = isDownloadedA4;
          voucherCnt.existsTck.value = isDownloadedTck;
        }
        voucherCnt.emailCnt.text = resultDoc.data.customerEmail ?? "";
        voucherCnt.numberCnt.text = resultDoc.data.customerTelephone ?? "";
        PanelOptionsVoucherModel info = PanelOptionsVoucherModel(
          documentId: id,
          message: resultDoc.data.messageText,
          pdfLinkTck: resultDoc.data.printTicket,
          pdfLinkA4: resultDoc.data.printA4,
          correlative: resultDoc.data.fullNumber,
        );
        voucherCnt.onSelectedVoucher(info);
        Get.toNamed(Routes.PANEL_OPTIONS_PAGE);
      }
    } catch (error) {
      displayErrorMessage(message: error.toString());
    } finally {
      dismissLoader();
    }
  }

  void onSelectColumn({required S2SingleSelected selected}) {
    selectedColumn.value = selected.value;
    if (selected.value.id == "customer") {
      emissionDate.value = null;
      pickedEmission.value = null;
    }
  }

  void onClearFilters() {
    selectedColumn.value = SaleNoteColumnModel(
      id: "date_of_issue",
      description: "Fecha de emisión",
    );
    selectedTotalPaid.value = null;
    selectedSerie.value = null;
    emissionDate.value = null;
    pickedEmission.value = null;
    correlative.value = "";
    clientName.value = "";
    docNumberCnt.text = "";
    clientCnt.text = "";
  }

  void saveOnPreviousValue() {
    prevColumn.value = selectedColumn.value;
    prevPickedEmission.value = pickedEmission.value;
    prevEmissionDate.value = emissionDate.value;
    prevSerie.value = selectedSerie.value;
    prevTotalPaid.value = selectedTotalPaid.value;
    prevCorrelative.value = correlative.value;
    prevClientName.value = clientName.value;
  }

  void resetPreviousValues() {
    selectedColumn.value = prevColumn.value;
    pickedEmission.value = prevPickedEmission.value;
    emissionDate.value = prevEmissionDate.value;
    selectedSerie.value = prevSerie.value;
    selectedTotalPaid.value = prevTotalPaid.value;
    correlative.value = prevCorrelative.value;
    docNumberCnt.text = prevCorrelative.value;
    clientName.value = prevClientName.value;
    clientCnt.text = prevClientName.value;
  }
}
