import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';

import 'package:facturadorpro/api/models/data_model.dart';
import 'package:facturadorpro/api/models/global_data_model.dart';
import 'package:facturadorpro/api/providers/remote_services.dart';
import 'package:facturadorpro/shared/helpers.dart';

class DashboardController extends GetxController {
  GetStorage box = GetStorage();
  TextEditingController modalityCnt = TextEditingController(text: "last_week");

  RxList<DataSell> chatDataSell = [DataSell(19, 12)].obs;
  RxString domain = ''.obs;
  RxString token = ''.obs;
  RxBool isLoadingGlobalData = true.obs;
  RxBool isLoading = true.obs;
  RxList<MainGraphModel> salesNote = <MainGraphModel>[].obs;
  RxList<MainGraphModel> vouchers = <MainGraphModel>[].obs;
  RxList<TotalGraphModel> totals = <TotalGraphModel>[].obs;
  RxList<MainGraphModel> balance = <MainGraphModel>[].obs;

  Rx<GlobalData> globalData = GlobalData(
    documentTotalGlobal: 0,
    saleNoteTotalGlobal: 0,
    totalCpe: 0,
  ).obs;

  DataGraph dataGraph = DataGraph();
  PurpleDataset purpleDataset = PurpleDataset();

  RxString nameFiltter = ''.obs;
  RxBool wasFiltered = false.obs;
  RxString previousSelectedFilter = "last_week".obs;
  RxString selectedFilter = "last_week".obs;
  RxInt previousIndexFilter = 0.obs;
  RxInt indexFilter = 0.obs;

  DateTime selectMonth01 = DateTime.now();
  DateTime selectMonth02 = DateTime.now();

  DateTime selectedDate01 = DateTime.now().subtract(Duration(days: 7));
  DateTime selectedDate02 = DateTime.now();

  RxString dateMonth01 = ''.obs;
  RxString dateMonth02 = ''.obs;
  RxString date01 = ''.obs;
  RxString date02 = ''.obs;

  List<Map<String, dynamic>> filters = [
    {"value": "Everyone", "label": "Todos"},
    {"value": "last_week", "label": "Última semana"},
    {"value": "month", "label": "Por mes"},
    {"value": "between_months", "label": "Entre meses"},
    {"value": "date", "label": "Por fecha"},
    {"value": "between_dates", "label": "Entre fechas"},
  ];

  @override
  void onInit() async {
    chatDataSell = getChartSell();
    await GetStorage.init('token');
    token(box.read('token'));

    await GetStorage.init('domain');
    domain.value = (box.read('domain') == null) ? '' : box.read('domain');

    await fetchGlobalData();
    await fetchGraph();
    super.onInit();
  }

  void onChangedFilter(String option) {
    wasFiltered.value = false;
    int index = filters.indexWhere((element) => element["value"] == option);
    previousIndexFilter.value = indexFilter.value;
    indexFilter.value = index;
    previousSelectedFilter.value = selectedFilter.value;
    selectedFilter.value = option;
  }

  void backOneFilter() {
    selectedFilter.value = previousSelectedFilter.value;
    indexFilter.value = previousIndexFilter.value;
    modalityCnt.text = previousSelectedFilter.value;
  }

  Future<void> resetFilter() async {
    selectMonth01 = DateTime.now();
    selectMonth02 = DateTime.now();
    selectedDate01 = DateTime.now().subtract(Duration(days: 7));
    selectedDate02 = DateTime.now();
    dateMonth01.value = '';
    dateMonth02.value = '';
    date01.value = '';
    date02.value = '';
    indexFilter.value = 0;
    selectedFilter.value = "last_week";
    modalityCnt.text = "last_week";
    await fetchGraph();
  }

  RxList<DataSell> getChartSell() {
    final List<DataSell> chartData = [
      DataSell(19, 11),
      DataSell(18, 15),
      DataSell(17, 12),
      DataSell(16, 10),
      DataSell(15, 13),
      DataSell(14, 10),
      DataSell(13, 18),
    ];
    return chartData.obs;
  }

  Future<void> fetchGlobalData() async {
    try {
      isLoadingGlobalData.value = false;
      var _globalData = await RemoteServices.fetchGlobalData(
          "${domain.value}/api/dashboard/global-data", token.value);
      if (_globalData != null) {
        globalData.value = GlobalData(
          totalCpe: _globalData.totalCpe,
          documentTotalGlobal: _globalData.documentTotalGlobal,
          saleNoteTotalGlobal: _globalData.saleNoteTotalGlobal,
        );
      }
    } finally {
      isLoadingGlobalData.value = false;
    }
  }

  Future<void> fetchGraph() async {
    try {
      wasFiltered.value = true;
      isLoading.value = true;
      var _data = await RemoteServices.fetchGraph(
        "${domain.value}/api/dashboard/data",
        token.value,
        selectedFilter.value,
        DateFormat('yyyy-MM').format(selectMonth01),
        DateFormat('yyyy-MM').format(selectMonth02),
        DateFormat('yyyy-MM-dd').format(selectedDate01),
        DateFormat('yyyy-MM-dd').format(selectedDate02),
      );
      if (_data != null) {
        List<PurpleDataset>? listSalesNotes =
            _data.data!.saleNote!.graph!.datasets;
        if (listSalesNotes!.isNotEmpty) {
          List<String>? lbSaleNotes = _data.data!.saleNote!.graph!.labels;
          PurpleDataset dsSaleNotes = listSalesNotes[0];
          final valSaleNotes = dsSaleNotes.data;
          salesNote.value = <MainGraphModel>[
            MainGraphModel(label: lbSaleNotes![0], value: valSaleNotes![0]),
            MainGraphModel(label: lbSaleNotes[1], value: valSaleNotes[1])
          ];
        }

        List<PurpleDataset>? listVouchers =
            _data.data!.document!.graph!.datasets;
        if (listVouchers!.isNotEmpty) {
          List<String>? lbVouchers = _data.data!.document!.graph!.labels;
          PurpleDataset dsVouchers = listVouchers[0];
          final valVouchers = dsVouchers.data;
          vouchers.value = <MainGraphModel>[
            MainGraphModel(label: lbVouchers![0], value: valVouchers![0]),
            MainGraphModel(label: lbVouchers[1], value: valVouchers[1])
          ];
        }

        List<FluffyDataset>? listTotals = _data.data!.general!.graph!.datasets;
        if (listTotals!.isNotEmpty) {
          List<String>? lbVouchers = _data.data!.general!.graph!.labels;
          FluffyDataset groupTotalSales = listTotals[0];
          FluffyDataset groupTotalVoucher = listTotals[1];
          FluffyDataset groupTotals = listTotals[2];
          List<TotalGraphModel> _totals = [];
          for (int i = 0; i < lbVouchers!.length; i++) {
            _totals.add(
              TotalGraphModel(
                label: lbVouchers[i],
                totalSalesNotes: groupTotalSales.data![i],
                totalVouchers: groupTotalVoucher.data![i],
                total: groupTotals.data![i],
              ),
            );
          }
          totals.value = _totals;
        }

        List<PurpleDataset>? listBalance = _data.data!.balance!.graph!.datasets;
        if (listBalance!.isNotEmpty) {
          List<String>? lbBalance = _data.data!.balance!.graph!.labels;
          PurpleDataset dsbBalance = listBalance[0];
          final valBalance = dsbBalance.data;
          balance.value = <MainGraphModel>[
            MainGraphModel(label: lbBalance![0], value: valBalance![0]),
            MainGraphModel(label: lbBalance[1], value: valBalance[1])
          ];
        }

        update();
        dataGraph = _data;
      }
    } catch (error) {
      displayErrorMessage(message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class DataSell {
  DataSell(this.day, this.sell);
  final double day;
  final double sell;
}
