import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'package:facturadorpro/shared/getx.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/shared/string_ext.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/api/models/response_model.dart';
import 'package:facturadorpro/api/models/voucher_response_model.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:facturadorpro/app/controllers/vouchers_controller.dart';
import 'package:facturadorpro/app/controllers/directory_controller.dart';
import 'package:facturadorpro/api/models/request/filter_voucher_req.dart';
import 'package:facturadorpro/api/models/response/print_response_model.dart';
import 'package:facturadorpro/app/ui/models/panel_options_voucher_model.dart';
import 'package:facturadorpro/api/models/response/pos_payments_params_model.dart';
import 'package:facturadorpro/api/models/response/filter_voucher_params_response_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SunatVoucherController extends GetxController {
  GetStorage box = GetStorage();

  FacturadorProvider provider = Get.put(FacturadorProvider());
  DirectoryController directoryCnt = Get.put(DirectoryController());
  VouchersController voucherCnt = Get.put(VouchersController());

  TextEditingController motiveCnt = TextEditingController();
  TextEditingController docNumberCnt = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final DateRangePickerController rangeCnt = DateRangePickerController();
  final DateRangePickerController emissionCnt = DateRangePickerController();

  RxInt page = 1.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasMorePages = false.obs;
  RxBool isSavingNullify = false.obs;
  RxList<Voucher> vouchers = <Voucher>[].obs;

  // Filter vouchers states
  RxList<S2Choice<CustomerFilter>> customers = <S2Choice<CustomerFilter>>[].obs;
  RxList<S2Choice<DocumentType>> documentTypes = <S2Choice<DocumentType>>[].obs;
  RxList<Series> series = <Series>[].obs;
  RxList<S2Choice<Series>> seriesDoctype = <S2Choice<Series>>[].obs;
  RxList<S2Choice<StateType>> states = <S2Choice<StateType>>[].obs;
  Rx<PickerDateRange> pickedRanges = PickerDateRange(null, null).obs;
  Rx<DateTime?> pickedEmission = RxNullable<DateTime?>().setNull();

  Rx<CustomerFilter?> selectedCustomer =
      RxNullable<CustomerFilter?>().setNull();
  Rx<DocumentType?> selectedDocType = RxNullable<DocumentType?>().setNull();
  Rx<Series?> selectedSerie = RxNullable<Series?>().setNull();
  Rx<StateType?> selectedState = RxNullable<StateType?>().setNull();
  Rx<String?> startDate = RxNullable<String?>().setNull();
  Rx<String?> endDate = RxNullable<String?>().setNull();
  Rx<String?> emissionDate = RxNullable<String?>().setNull();
  Rx<String> correlative = "".obs;

  Rx<DocumentType?> prevDocType = RxNullable<DocumentType?>().setNull();
  Rx<CustomerFilter?> prevCustomer = RxNullable<CustomerFilter?>().setNull();
  Rx<Series?> prevSerie = RxNullable<Series?>().setNull();
  Rx<StateType?> prevState = RxNullable<StateType?>().setNull();
  Rx<String?> prevStartDate = RxNullable<String?>().setNull();
  Rx<String?> prevEndDate = RxNullable<String?>().setNull();
  Rx<String?> prevEmissionDate = RxNullable<String?>().setNull();
  Rx<PickerDateRange> prevPickedRanges = PickerDateRange(null, null).obs;
  Rx<DateTime?> prevPickedEmission = RxNullable<DateTime?>().setNull();
  Rx<String> prevCorrelative = "".obs;

  @override
  void onInit() async {
    await filterVouchers();
    await onInitFilterParamsVoucher();
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
      if (hasMorePages.value == true) filterMoreVouchers();
    }
  }

  Future<void> onInitFilterParamsVoucher() async {
    try {
      isLoading.value = true;
      Response res = await provider.fetchFilterParamsVouchers();
      if (res.statusCode == 200) {
        FilterVoucherParamsResponse result =
            filterVoucherParamsResponseFromJson(
          res.bodyString!,
        );
        customers.value = result.customers.map((e) {
          return S2Choice(value: e, title: e.name.toTitleCase());
        }).toList();
        documentTypes.value = result.documentTypes.map((e) {
          return S2Choice(value: e, title: e.description);
        }).toList();
        states.value = result.stateTypes.map((e) {
          return S2Choice(value: e, title: e.description);
        }).toList();
        series.value = result.series;
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> filterVouchers({bool? useLoader = true}) async {
    try {
      if (useLoader == true) isLoading.value = true;
      FilterVoucherReq info = FilterVoucherReq(page: 1);
      if (selectedDocType.value != null) {
        info.documentTypeId = selectedDocType.value!.id;
      }
      if (selectedSerie.value != null) {
        info.series = selectedSerie.value!.number;
      }
      if (docNumberCnt.text.isNotEmpty) {
        info.number = docNumberCnt.text;
      }
      if (startDate.value != null) {
        info.startDate = startDate.value;
      }
      if (endDate.value != null) {
        info.endingDate = endDate.value;
      }
      if (emissionDate.value != null) {
        info.dateOfIssue = emissionDate.value;
      }
      if (selectedCustomer.value != null) {
        info.customerId = selectedCustomer.value!.id.toString();
      }
      if (selectedState.value != null) {
        info.stateTypeId = selectedState.value!.id;
      }
      final Response res = await provider.fetchVouchersEndpoint(info: info);
      if (res.statusCode == 200) {
        VoucherResponseModel response = voucherResponseModelFromJson(
          res.bodyString!,
        );
        hasMorePages.value = response.links.next != null;
        vouchers.value = response.data;
        page.value = 1;
      }
    } catch (error) {
      print(error);
      displayErrorMessage();
    } finally {
      if (useLoader == true) isLoading.value = false;
    }
  }

  Future<void> filterMoreVouchers() async {
    try {
      isLoadingMore.value = true;
      final info = FilterVoucherReq(page: page.value + 1);
      if (selectedDocType.value != null) {
        info.documentTypeId = selectedDocType.value!.id;
      }
      if (selectedSerie.value != null) {
        info.series = selectedSerie.value!.number;
      }
      if (docNumberCnt.text.isNotEmpty) {
        info.number = docNumberCnt.text;
      }
      if (startDate.value != null) {
        info.startDate = startDate.value;
      }
      if (endDate.value != null) {
        info.endingDate = endDate.value;
      }
      if (emissionDate.value != null) {
        info.dateOfIssue = emissionDate.value;
      }
      if (selectedCustomer.value != null) {
        info.customerId = selectedCustomer.value!.id.toString();
      }
      if (selectedState.value != null) {
        info.stateTypeId = selectedState.value!.id;
      }
      final Response res = await provider.fetchVouchersEndpoint(info: info);
      if (res.statusCode == 200) {
        VoucherResponseModel response = voucherResponseModelFromJson(
          res.bodyString!,
        );
        hasMorePages.value = response.links.next != null;
        vouchers.addAll(response.data);
        page.value++;
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingMore.value = false;
    }
  }

  void onShowOptionsPressed({
    required int id,
    required BuildContext context,
  }) async {
    try {
      showLoader(status: "Espere...");
      Response resDoc = await provider.fetchPrintVoucherInfo(
        documentId: id,
      );
      PrintResponseModel resultDoc = printResponseModelFromJson(
        resDoc.bodyString!,
      );
      if (resDoc.statusCode == 200) {
        /*Response resClient = await provider.retrieveClient(
          id: voucher.customerId,
        );*/
        if (directoryCnt.downloadDir.value.isNotEmpty) {
          bool isDownloadedTck = await existsDir(
            dirname: directoryCnt.downloadDir.value,
            filename: "${resultDoc.data.number}-ticket.pdf",
          );
          bool isDownloadedA4 = await existsDir(
            dirname: directoryCnt.downloadDir.value,
            filename: "${resultDoc.data.number}-a4.pdf",
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
          correlative: resultDoc.data.number,
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

  Future<void> onCreateNullifySummary({required Voucher voucher}) async {
    Get.defaultDialog(
      barrierDismissible: false,
      title: "Anular comprobante",
      content: Obx(() {
        bool starting = isSavingNullify.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH(8),
            Text(
              "Se procederá a la anulación del comprobante: ${voucher.number} mediante un resumen de anulaciones.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            spaceH(12),
            Divider(),
            spaceH(12),
            Row(
              children: [
                Text("Fecha:"),
                Spacer(),
                Text(
                  DateFormat("yyyy-MM-dd").format(DateTime.now()),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            spaceH(24),
            TextField(
              controller: motiveCnt,
              autofocus: true,
              readOnly: starting,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                label: Text("Motivo"),
                isDense: true,
                hintText: "Dinos el motivo de la anulación",
              ),
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: 4,
            ),
            spaceH(8),
          ],
        );
      }),
      actions: [
        Obx(() {
          bool starting = isSavingNullify.value;
          return SizedBox(
            height: 48,
            width: double.infinity,
            child: TextButton(
              child: starting
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ANULAR COMPROBANTE",
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
              onPressed: starting
                  ? null
                  : () async {
                      await _onCreateNullifySummaryFn(voucher: voucher);
                    },
            ),
          );
        }),
        Obx(() {
          bool starting = isSavingNullify.value;
          return SizedBox(
            height: 48,
            width: double.infinity,
            child: TextButton(
              child: Text("CANCELAR"),
              style: TextButton.styleFrom(
                foregroundColor: textColor.shade300,
              ),
              onPressed: !starting
                  ? () {
                      motiveCnt.text = "";
                      Get.back();
                    }
                  : null,
            ),
          );
        }),
      ],
      radius: 8,
      titlePadding: EdgeInsets.only(top: 24),
      contentPadding: EdgeInsets.all(16),
    );
  }

  Future<void> _onCreateNullifySummaryFn({required Voucher voucher}) async {
    try {
      if (motiveCnt.text.isEmpty) {
        return displayWarningMessage(message: "Por favor ingrese el motivo");
      }
      isSavingNullify.value = true;
      Response res = await provider.saveNullifyEndpoint(
        voucher: voucher,
        motive: motiveCnt.text,
      );
      if (res.statusCode == 200) {
        ResponseModel result = responseModelFromJson(res.bodyString!);
        if (result.success) {
          Voucher? saleNote = await foundCurrentVoucher(voucher: voucher);
          Get.back();
          if (saleNote != null) {
            List<Voucher> _tmp = vouchers;
            int index = _tmp.indexWhere((e) => e.id == voucher.id);
            _tmp[index] = saleNote;
            motiveCnt.text = "";
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
      isSavingNullify.value = false;
    }
  }

  Future<Voucher?> foundCurrentVoucher({required Voucher voucher}) async {
    Voucher? document = null;
    try {
      List<String> correlative = voucher.number.split("-");
      final info = FilterVoucherReq(
        page: 1,
        series: correlative[0],
        number: correlative[1],
      );
      final Response res = await provider.fetchVouchersEndpoint(info: info);
      if (res.statusCode == 200) {
        VoucherResponseModel result = voucherResponseModelFromJson(
          res.bodyString!,
        );
        if (result.data.length == 1) {
          document = result.data[0];
        }
        if (result.data.length > 1) {
          document = result.data.firstWhereOrNull(
            (e) => e.number == voucher.number,
          );
        }
      }
    } catch (error) {
      displayErrorMessage(
        message: "Ha ocurrido un error, actualice los registros manualmente.",
      );
    }
    return document;
  }

  // Functions filter
  void onSelectDocumentType({
    required S2SingleSelected<DocumentType?> selected,
  }) {
    if (selected.value != null) {
      List<Series> filtered = series.where((e) {
        return e.documentTypeId == selected.value!.id;
      }).toList();
      seriesDoctype.value = filtered.map((e) {
        return S2Choice(value: e, title: e.number);
      }).toList();
      selectedDocType.value = selected.value;
      selectedSerie.value = null;
      docNumberCnt.text = "";
    }
  }

  void onClearFilters() {
    pickedRanges.value = PickerDateRange(null, null);
    pickedEmission.value = null;
    selectedCustomer.value = null;
    selectedDocType.value = null;
    selectedSerie.value = null;
    selectedState.value = null;
    startDate.value = null;
    endDate.value = null;
    emissionDate.value = null;
    correlative.value = "";
    docNumberCnt.text = "";
  }

  void saveOnPreviousValue() {
    prevDocType.value = selectedDocType.value;
    prevCustomer.value = selectedCustomer.value;
    prevSerie.value = selectedSerie.value;
    prevState.value = selectedState.value;
    prevStartDate.value = startDate.value;
    prevEndDate.value = endDate.value;
    prevEmissionDate.value = emissionDate.value;
    prevPickedRanges.value = pickedRanges.value;
    prevPickedEmission.value = pickedEmission.value;
    prevCorrelative.value = correlative.value;
  }

  void resetPreviousValues() {
    selectedDocType.value = prevDocType.value;
    selectedCustomer.value = prevCustomer.value;
    selectedSerie.value = prevSerie.value;
    selectedState.value = prevState.value;
    startDate.value = prevStartDate.value;
    endDate.value = prevEndDate.value;
    emissionDate.value = prevEmissionDate.value;
    pickedRanges.value = prevPickedRanges.value;
    pickedEmission.value = prevPickedEmission.value;
    docNumberCnt.text = prevCorrelative.value;
    correlative.value = prevCorrelative.value;
  }
}
