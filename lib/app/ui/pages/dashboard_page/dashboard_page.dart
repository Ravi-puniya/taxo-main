import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/api/models/data_model.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/theme/colors/charts.dart';
import 'package:facturadorpro/app/controllers/dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  DashboardPage({Key? key}) : super(key: key);

  final _controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Obx(() {
      if (_controller.isLoading.value == true ||
          _controller.isLoadingGlobalData.value == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          await controller.fetchGlobalData();
          await controller.fetchGraph();
        },
        child: ListView(
          children: [
            spaceH(25),
            CarouselSlider(
              items: [
                informationCard(
                  Colors.green.shade50,
                  Colors.green.shade500,
                  Icons.assignment,
                  _controller.globalData.value.totalCpe.toString(),
                  "Comprobantes emitidos",
                ),
                informationCard(
                  Colors.blue.shade50,
                  Colors.blue.shade500,
                  Icons.receipt,
                  formatMoney(
                    quantity: _controller.globalData.value.documentTotalGlobal,
                    decimalDigits: 2,
                    symbol: "S/.",
                  ),
                  "Monto total de comprobantes",
                ),
                informationCard(
                  Colors.purple.shade50,
                  Colors.purple.shade500,
                  Icons.sell,
                  formatMoney(
                    quantity: _controller.globalData.value.saleNoteTotalGlobal,
                    decimalDigits: 2,
                    symbol: "S/.",
                  ),
                  "Monto total notas de ventas",
                ),
              ],
              options: CarouselOptions(
                height: screenSize.height * 0.21,
                viewportFraction: 0.4,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                initialPage: 1,
              ),
            ),
            spaceH(25),
            chartSalesNotes(screenSize),
            spaceH(20),
            chartVouchers(screenSize),
            spaceH(20),
            chartTotals(screenSize),
            spaceH(20),
            chartBalance(screenSize),
          ],
        ),
      );
    });
  }

  Widget itemMenuWidget(final screenSize, IconData icon, String textItem) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02125),
      child: Row(children: [Icon(icon), spaceW(10), Text(textItem)]),
    );
  }

  Widget itemSelectedMenuWidget(
    final screenSize,
    IconData icon,
    String textItem,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(7),
      ),
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02125),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          spaceW(10),
          Text(
            textItem,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget informationCard(
    Color color,
    Color colorIcon,
    IconData icon,
    String textTitle,
    String textSubtitle,
  ) {
    return Container(
      width: 225,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.125),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: colorIcon),
          spaceH(8.0),
          Text(
            textTitle,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          spaceH(8.0),
          Text(
            textSubtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Pie chart - Notas de venta
  Widget chartSalesNotes(final screenSize) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "NOTAS DE VENTA",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SfCircularChart(
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(enable: true),
              palette: paletteCharts,
              series: <CircularSeries>[
                PieSeries<MainGraphModel, String>(
                  // ignore: invalid_use_of_protected_member
                  dataSource: _controller.salesNote.value,
                  xValueMapper: (MainGraphModel data, _) => data.label,
                  yValueMapper: (MainGraphModel data, _) => data.value,
                  dataLabelMapper: (MainGraphModel data, _) => formatMoney(
                    quantity: data.value.toDouble(),
                    decimalDigits: 2,
                    symbol: "S/.",
                  ),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                  explode: true,
                  explodeIndex: 0,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  // Donut char - Comprobantes
  Widget chartVouchers(final screenSize) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "COMPROBANTES",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SfCircularChart(
              // title: ChartTitle(text: "Comprobantes"),
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(enable: true),
              palette: paletteCharts,
              series: <CircularSeries>[
                DoughnutSeries<MainGraphModel, String>(
                  // ignore: invalid_use_of_protected_member
                  dataSource: _controller.vouchers.value,
                  xValueMapper: (MainGraphModel data, _) => data.label,
                  yValueMapper: (MainGraphModel data, _) => data.value,
                  dataLabelMapper: (MainGraphModel data, _) => formatMoney(
                    quantity: data.value.toDouble(),
                    decimalDigits: 2,
                    symbol: "S/.",
                  ),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                  explode: true,
                  explodeIndex: 0,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  // Bar chart - Totales
  Widget chartTotals(final screenSize) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "TOTALES",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SfCartesianChart(
              // title: ChartTitle(text: "Totales"),
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(enable: true),
              palette: paletteCharts,
              primaryXAxis: CategoryAxis(),
              zoomPanBehavior: ZoomPanBehavior(
                zoomMode: ZoomMode.x,
                enableSelectionZooming: true,
                enableDoubleTapZooming: true,
                enablePinching: true,
              ),
              series: <CartesianSeries>[
                ColumnSeries<TotalGraphModel, String>(
                  name: "Notas de venta",
                  // ignore: invalid_use_of_protected_member
                  dataSource: _controller.totals.value,
                  xValueMapper: (TotalGraphModel data, _) => data.label,
                  yValueMapper: (TotalGraphModel data, _) =>
                      data.totalSalesNotes,
                ),
                ColumnSeries<TotalGraphModel, String>(
                  name: "Comprobantes",
                  // ignore: invalid_use_of_protected_member
                  dataSource: _controller.totals.value,
                  xValueMapper: (TotalGraphModel data, _) => data.label,
                  yValueMapper: (TotalGraphModel data, _) => data.totalVouchers,
                ),
                ColumnSeries<TotalGraphModel, String>(
                  name: "Total",
                  // ignore: invalid_use_of_protected_member
                  dataSource: _controller.totals.value,
                  xValueMapper: (TotalGraphModel data, _) => data.label,
                  yValueMapper: (TotalGraphModel data, _) => data.total,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  // Donut char - Comprobantes
  Widget chartBalance(final screenSize) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        // height: screenSize.height * 0.30,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "BALANCE",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SfCircularChart(
              // title: ChartTitle(text: "Balance"),
              legend: Legend(isVisible: true, position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(enable: true),
              palette: paletteCharts,
              series: <CircularSeries>[
                DoughnutSeries<MainGraphModel, String>(
                  // ignore: invalid_use_of_protected_member
                  dataSource: _controller.balance.value,
                  xValueMapper: (MainGraphModel data, _) => data.label,
                  yValueMapper: (MainGraphModel data, _) => data.value,
                  dataLabelMapper: (MainGraphModel data, _) => formatMoney(
                    quantity: data.value.toDouble(),
                    decimalDigits: 2,
                    symbol: "S/.",
                  ),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                  explode: true,
                  explodeIndex: 0,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
