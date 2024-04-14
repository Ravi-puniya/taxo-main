import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/widgets/version_app.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/theme/colors/secondary.dart';
import 'package:facturadorpro/app/controllers/menu_controller.dart'
    as MenuController;
import 'package:facturadorpro/app/ui/pages/cash_page/cash_page.dart';
import 'package:facturadorpro/app/ui/widgets/custom_select_form.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/ui/pages/vouchers/vouchers_page.dart';
import 'package:facturadorpro/app/ui/pages/client_page/client_page.dart';
import 'package:facturadorpro/app/controllers/dashboard_controller.dart';
import 'package:facturadorpro/app/ui/pages/vouchers/sales_notes_page.dart';
import 'package:facturadorpro/app/ui/pages/products_page/products_page.dart';
import 'package:facturadorpro/app/controllers/configuration_controller.dart';
import 'package:facturadorpro/app/ui/pages/dashboard_page/dashboard_page.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/filter_items_page/filter_items_page.dart';
import 'package:facturadorpro/app/ui/pages/categoria_page/categoria_page.dart';
import 'package:facturadorpro/app/ui/pages/marcas_page/marcas_page.dart';
import 'package:facturadorpro/app/ui/pages/cotizacion_page/cotizacion_page.dart';

class MenuPage extends GetView<MenuController.MenuControllers> {
  MenuPage({Key? key}) : super(key: key);

  final _controllerDashboard = Get.put(DashboardController());
  final _controllerConfig = Get.put(ConfigurationController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawerEnableOpenDragGesture: true,
        extendBody: true,
        drawer: Drawer(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            //margin: EdgeInsets.all(20.0),
            height: screenSize.height,
            child: logoWidget(screenSize),
          ),
        ),
        appBar: AppBar(
          actions: [
            IconPage(
              context: context,
              screenSize: screenSize,
            ),
          ],
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          title: Obx(() {
            return Text(
              controller.menuTitle.value,
              style: const TextStyle(
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            );
          }),
        ),
        body: Obx(changedBody),
        bottomNavigationBar: BottomNavigationBar(context),
        floatingActionButton: FloatingButton(context),
      ),
    );
  }

  Widget FloatingButton(BuildContext context) {
    //agregar flotante
    return Obx(() {
      if ([3, 4, 5].contains(controller.menuIndex.value)) {
        return FloatingActionButton(
          onPressed: () {
            if (controller.menuIndex.value == 3) {
              controller.navigatorProductFormPage();
            }
            if (controller.menuIndex.value == 4) {
              controller.navigatorClientFormPage();
            }
            if (controller.menuIndex.value == 5) {
              controller.navigatorCashFormPage();
            }
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        );
      }
      return SizedBox();
    });
  }

  Widget BottomNavigationBar(BuildContext context) {
    return Obx(() {
      bool isSelectedZero = controller.voucherMenuIndex.value == 0;
      bool isSelectedOne = controller.voucherMenuIndex.value == 1;
      if (controller.menuIndex.value == 2) {
        return Container(
          height: 50,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 0,
                color: Colors.grey.shade300,
              ),
            ],
            border: Border.all(color: primaryColor),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      controller.changeVoucherMenu(
                        index: 0,
                        title: "Comprobantes",
                      );
                    },
                    child: Text(
                      "COMPROBANTES",
                      style: TextStyle(
                        color: isSelectedZero ? Colors.white : null,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: isSelectedZero ? primaryColor : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          bottomLeft: Radius.circular(32),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              VerticalDivider(width: 0),
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      controller.changeVoucherMenu(
                        index: 1,
                        title: "Notas de venta",
                      );
                    },
                    child: Text(
                      "NOTAS DE VENTA",
                      style: TextStyle(
                        color: isSelectedOne ? Colors.white : null,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: isSelectedOne ? primaryColor : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return SizedBox();
    });
  }

  Widget IconPage({required BuildContext context, required Size screenSize}) {
    //agregar lupa
    return Obx(() {
      switch (controller.menuIndex.value) {
        case 0:
          return IconButton(
            onPressed: () {
              if (_controllerDashboard.wasFiltered.value == false) {
                _controllerDashboard.backOneFilter();
              }
              Get.bottomSheet(
                filterDashboardWidget(context),
                ignoreSafeArea: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                backgroundColor: Colors.white,
              );
            },
            icon: const Icon(
              Icons.filter_alt_outlined,
              color: textColor,
            ),
          );
        case 1:
          return GetX<PosController>(builder: (posCnt) {
            // ignore: invalid_use_of_protected_member
            int totalItems = posCnt.itemsInCart.value.length;
            String itemBadge = totalItems > 9 ? "+9" : totalItems.toString();
            return GestureDetector(
              onTap: totalItems > 0
                  ? () async {
                      Get.toNamed(Routes.CART_POS);
                      await posCnt.onInitSaleDetails();
                    }
                  : () {
                      displayWarningMessage(
                        message: "Añade productos para continuar",
                      );
                    },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                margin: EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  right: 8.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_cart_checkout_outlined,
                      color: Colors.grey.shade700,
                    ),
                    spaceW(4.0),
                    // Badge(
                    //   toAnimate: false,
                    //   shape: BadgeShape.square,
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 8,
                    //     vertical: 4,
                    //   ),
                    //   badgeColor: secondaryColor,
                    //   borderRadius: BorderRadius.circular(8),
                    //   badgeContent: Text(
                    //     itemBadge,
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          });
        case 2:
          return IconButton(
            onPressed: () {
              Get.toNamed(
                controller.voucherMenuIndex.value == 0
                    ? Routes.FILTER_VOUCHER_PAGE
                    : Routes.FILTER_SALE_NOTE_PAGE,
              );
            },
            icon: const Icon(
              Icons.search_outlined,
              color: textColor,
            ),
          );
        case 3:
          return Row(
            children: [
              IconButton(
                onPressed: controller.navigatorProductFilterPage,
                icon: const Icon(
                  Icons.search,
                  color: textColor,
                ),
              ),
            ],
          );
        case 4:
          return Row(
            children: [
              IconButton(
                onPressed: controller.navigatorClientFilterPage,
                icon: const Icon(
                  Icons.search,
                  color: textColor,
                ),
              ),
            ],
          );
        case 5:
          return Row(
            children: [
              IconButton(
                onPressed: controller.navigatorCashBoxFilterPage,
                icon: Icon(
                  Icons.search,
                  color: textColor,
                ),
              ),
            ],
          );
        //         case 6:
        // return Row(
        //   children: [
        //     IconButton(
        //       onPressed: controller.navigatorcategoriaPage,
        //       icon: const Icon(
        //         Icons.search,
        //         color: textColor,
        //       ),
        //     ),
        //   ],
        // );
      }

      return Container();
    });
  }

  Widget filterDashboardWidget(context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height *
            ([0, 1].contains(_controllerDashboard.indexFilter.value)
                ? 0.33
                : [2, 4].contains(_controllerDashboard.indexFilter.value)
                    ? 0.40
                    : 0.46),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 5.0,
                width: MediaQuery.of(context).size.width * 0.2,
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: Colors.black.withOpacity(0.20),
                ),
              ),
            ),
            Text(
              "FILTRO DE BÚSQUEDA",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            CustomSelectForm(
              title: "Modalidad",
              items: _controllerDashboard.filters,
              // initialValue: _controllerDashboard.selectedFilter.value,
              onChanged: _controllerDashboard.onChangedFilter,
              controller: _controllerDashboard.modalityCnt,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  double widthButton = MediaQuery.of(context).size.width - 40;
                  int selectedIndex = _controllerDashboard.indexFilter.value;
                  // Por mes y entre meses
                  if ([2, 3].contains(selectedIndex)) {
                    return Column(
                      children: [
                        SizedBox(height: 20.0),
                        SizedBox(
                          height: 40.0,
                          width: widthButton,
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: primaryColor.withOpacity(.1),
                            ),
                            onPressed: () {
                              showMonthPicker(
                                context: context,
                                firstDate: DateTime(DateTime.now().year - 1, 5),
                                lastDate: DateTime(DateTime.now().year + 1, 9),
                                initialDate: _controllerDashboard.selectMonth01,
                                locale: const Locale("es"),
                              ).then((date) {
                                if (date != null) {
                                  _controllerDashboard.selectMonth01 = date;
                                  _controllerDashboard.dateMonth01(
                                      DateFormat('MM-yyyy').format(date));

                                  if (_controllerDashboard.selectMonth01
                                          .compareTo(_controllerDashboard
                                              .selectMonth02) >=
                                      0) {
                                    _controllerDashboard.selectMonth02 = date;
                                    _controllerDashboard.dateMonth02(
                                        DateFormat('MM-yyyy').format(date));
                                  }
                                }
                              });
                            },
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              size: 16.0,
                            ),
                            label: Row(
                              children: [
                                Text(
                                  selectedIndex == 3 ? "DESDE: " : "PERIODO:",
                                ),
                                Spacer(),
                                Text(
                                  _controllerDashboard
                                          .dateMonth01.value.isNotEmpty
                                      ? _controllerDashboard.dateMonth01.value
                                      : 'Seleccionar',
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        if (_controllerDashboard.indexFilter == 3)
                          SizedBox(
                            height: 40.0,
                            width: widthButton,
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: primaryColor.withOpacity(.1),
                              ),
                              onPressed: () {
                                showMonthPicker(
                                  context: context,
                                  firstDate: _controllerDashboard.selectMonth01,
                                  lastDate:
                                      DateTime(DateTime.now().year + 1, 9),
                                  initialDate:
                                      _controllerDashboard.selectMonth02,
                                  locale: const Locale("es"),
                                ).then((date) {
                                  if (date != null) {
                                    _controllerDashboard.selectMonth02 = date;
                                    _controllerDashboard.dateMonth02(
                                      DateFormat('MM-yyyy').format(date),
                                    );
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.calendar_month_outlined,
                                size: 16.0,
                              ),
                              label: Row(
                                children: [
                                  Text("HASTA:"),
                                  Spacer(),
                                  Text(
                                    _controllerDashboard
                                            .dateMonth02.value.isNotEmpty
                                        ? _controllerDashboard.dateMonth02.value
                                        : 'Seleccione',
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  }

                  // Por Por fecha y entre fechas
                  if ([4, 5].contains(selectedIndex)) {
                    return Column(
                      children: [
                        SizedBox(height: 20.0),
                        SizedBox(
                          height: 40.0,
                          width: widthButton,
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: primaryColor.withOpacity(.1),
                            ),
                            onPressed: () async {
                              final DateTime? datePicked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      _controllerDashboard.selectedDate01,
                                  firstDate: DateTime(DateTime.now().year - 10),
                                  lastDate: DateTime(DateTime.now().year + 10));

                              if (datePicked != null) {
                                _controllerDashboard.selectedDate01 =
                                    datePicked;
                                _controllerDashboard.date01(
                                  DateFormat('dd-MM-yyyy').format(datePicked),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              size: 16.0,
                            ),
                            label: Row(
                              children: [
                                Text(
                                  selectedIndex == 5 ? "DESDE: " : "FECHA:",
                                ),
                                Spacer(),
                                Text(
                                  _controllerDashboard.date01.value.isNotEmpty
                                      ? _controllerDashboard.date01.value
                                      : 'Seleccione',
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        if (selectedIndex == 5)
                          SizedBox(
                            height: 40.0,
                            width: widthButton,
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: primaryColor.withOpacity(.1),
                              ),
                              onPressed: () async {
                                final DateTime? datePicked =
                                    await showDatePicker(
                                        context: context,
                                        initialDate:
                                            _controllerDashboard.selectedDate02,
                                        firstDate:
                                            _controllerDashboard.selectedDate01,
                                        lastDate:
                                            DateTime(DateTime.now().year + 10));

                                if (datePicked != null) {
                                  _controllerDashboard.selectedDate02 =
                                      datePicked;
                                  _controllerDashboard.date02(
                                      DateFormat('dd-MM-yyyy')
                                          .format(datePicked));
                                }
                              },
                              icon: Icon(
                                Icons.calendar_month_outlined,
                                size: 16.0,
                              ),
                              label: Row(
                                children: [
                                  Text("HASTA:"),
                                  Spacer(),
                                  Text(
                                    _controllerDashboard.date02.value.isNotEmpty
                                        ? _controllerDashboard.date02.value
                                        : 'Seleccione',
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  }
                  return SizedBox();
                }),
              ],
            ),
            Spacer(),
            Obx(() {
              return SizedBox(
                height: 40.0,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  onPressed: !_controllerDashboard.isLoading.value
                      ? () {
                          _controllerDashboard.fetchGraph();
                          Get.back();
                        }
                      : null,
                  child: Text(
                    _controllerDashboard.isLoading.value == true
                        ? "..."
                        : 'APLICAR FILTRO',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 10.0),
            Obx(() {
              return SizedBox(
                height: 40.0,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    foregroundColor: Colors.grey.shade200,
                    elevation: 0,
                  ),
                  onPressed: !_controllerDashboard.isLoading.value
                      ? _controllerDashboard.resetFilter
                      : null,
                  child: Text(
                    'LIMPIAR',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      );
    });
  }

  Widget logoWidget(final screenSize) {
    return Obx(
      () => Column(
        children: [
          SizedBox(height: 25),
          if (_controllerConfig.logo.value.isNotEmpty)
            Image.network(
              _controllerConfig.logo.value,
              height: screenSize.height * 0.1,
              loadingBuilder: (
                BuildContext _,
                Widget child,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) {
                  return child;
                }
                return Container(
                  height: screenSize.height * 0.1,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          SizedBox(height: 10),
          Text(
            _controllerConfig.brandName.value.isEmpty
                ? "Facturador taxo v1"
                : _controllerConfig.brandName.value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              fontFamily: "Kdam",
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            child: Text(
              "Menú",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.useNavigator(
                    index: 0,
                    title: "Dashboard",
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: controller.menuIndex.value == 0
                      ? Colors.blue
                      : Color.fromARGB(255, 255, 255, 255),
                  elevation: 0.0, // Elimina la sombra del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(screenSize.width * 0.8, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(
                        Icons.dashboard_outlined,
                        size: 30,
                        color: controller.menuIndex.value == 0
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 14.5,
                        color: controller.menuIndex.value == 0
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              ElevatedButton(
                onPressed: () {
                  controller.useNavigator(
                    index: 1,
                    title: "Punto de venta",
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: controller.menuIndex.value == 1
                      ? Colors.blue
                      : Color.fromARGB(255, 255, 255, 255),
                  elevation: 0.0, // Elimina la sombra del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(screenSize.width * 0.8, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 30,
                        color: controller.menuIndex.value == 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      "Punto de venta",
                      style: TextStyle(
                        fontSize: 14.5,
                        color: controller.menuIndex.value == 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Divider(),
              SizedBox(height: 6),
              ElevatedButton(
                onPressed: () {
                  controller.useNavigator(
                    index: 2,
                    title: controller.voucherMenuIndex.value == 0
                        ? "Comprobantes"
                        : "Notas de venta",
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: controller.menuIndex.value == 2
                      ? Colors.blue
                      : Color.fromARGB(255, 255, 255, 255),
                  elevation: 0.0, // Elimina la sombra del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(screenSize.width * 0.8, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(
                        Icons.file_copy_outlined,
                        size: 30,
                        color: controller.menuIndex.value == 2
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      controller.voucherMenuIndex.value == 0
                          ? "Comprobantes"
                          : "Notas de venta",
                      style: TextStyle(
                        fontSize: 14.5,
                        color: controller.menuIndex.value == 2
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Divider(),
              SizedBox(height: 6),
              ElevatedButton(
                onPressed: () {
                  controller.useNavigator(
                    index: 3,
                    title: "Productos",
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: controller.menuIndex.value == 3
                      ? Colors.blue
                      : Color.fromARGB(255, 255, 255, 255),
                  elevation: 0.0, // Elimina la sombra del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(screenSize.width * 0.8, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(
                        Icons.inventory_outlined,
                        size: 30,
                        color: controller.menuIndex.value == 3
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      "Productos",
                      style: TextStyle(
                        fontSize: 14.5,
                        color: controller.menuIndex.value == 3
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              ElevatedButton(
                onPressed: () {
                  controller.useNavigator(
                    index: 4,
                    title: "Clientes",
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: controller.menuIndex.value == 4
                      ? Colors.blue
                      : Color.fromARGB(255, 255, 255, 255),
                  elevation: 0.0, // Elimina la sombra del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(screenSize.width * 0.8, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(
                        Icons.group_outlined,
                        size: 30,
                        color: controller.menuIndex.value == 4
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      "Clientes",
                      style: TextStyle(
                        fontSize: 14.5,
                        color: controller.menuIndex.value == 4
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              ElevatedButton(
                onPressed: () {
                  controller.useNavigator(
                    index: 6,
                    title: "Categorías",
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: controller.menuIndex.value == 6
                      ? Colors.blue
                      : Color.fromARGB(255, 255, 255, 255),
                  elevation: 0.0, // Elimina la sombra del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(screenSize.width * 0.8, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(
                        Icons.category_outlined,
                        size: 30,
                        color: controller.menuIndex.value == 6
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      "Categorías",
                      style: TextStyle(
                        fontSize: 14.5,
                        color: controller.menuIndex.value == 6
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              ElevatedButton(
                onPressed: () {
                  controller.useNavigator(
                    index: 7,
                    title: "Marcas",
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: controller.menuIndex.value == 7
                      ? Colors.blue
                      : Color.fromARGB(255, 255, 255, 255),
                  elevation: 0.0, // Elimina la sombra del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(screenSize.width * 0.8, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(
                        Icons.archive_outlined,
                        size: 30,
                        color: controller.menuIndex.value == 7
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      "Marcas",
                      style: TextStyle(
                        fontSize: 14.5,
                        color: controller.menuIndex.value == 7
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              ElevatedButton(
                onPressed: () {
                  controller.useNavigator(
                    index: 8,
                    title: "Cotizacion",
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: controller.menuIndex.value == 8
                      ? Colors.blue
                      : Color.fromARGB(255, 255, 255, 255),
                  elevation: 0.0, // Elimina la sombra del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(screenSize.width * 0.8, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(
                        Icons.notes_outlined,
                        size: 30,
                        color: controller.menuIndex.value == 8
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      "Cotizacion",
                      style: TextStyle(
                        fontSize: 14.5,
                        color: controller.menuIndex.value == 8
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              ElevatedButton(
                onPressed: () {
                  controller.useNavigator(
                    index: 5,
                    title: "Caja chica",
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: controller.menuIndex.value == 5
                      ? Colors.blue
                      : Color.fromARGB(255, 255, 255, 255),
                  elevation: 0.0, // Elimina la sombra del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(screenSize.width * 0.8, 50),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(
                        Icons.all_inbox_outlined,
                        size: 30,
                        color: controller.menuIndex.value == 5
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      "Caja chica",
                      style: TextStyle(
                        fontSize: 14.5,
                        color: controller.menuIndex.value == 5
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.red.shade500,
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                minimumSize: Size(screenSize.width * 0.8, 50),
              ),
              label: Text(
                "CERRAR SESIÓN",
                style: TextStyle(
                  color: Colors.red.shade500,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: controller.logout,
            ),
          ),
          SizedBox(height: 10),
          VersionApp(),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget changedBody() {
    //directorio
    switch (controller.menuIndex.value) {
      case 0:
        return DashboardPage();
      case 1:
        return FilterItemsPage();
      case 2:
        if (controller.voucherMenuIndex.value == 0) {
          return VouchersPage();
        } else {
          return SaleNotesPage();
        }
      case 3:
        return ProductsPage();
      case 4:
        return const ClientPage();
      case 5:
        return const CashPage();
      case 6:
        return CategoriaPage();
      case 7:
        return MarcaPage();
      case 8:
        return CotizacionPage();
    }
    return Container();
  }

  Widget ItemMenuWidget({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return Container(
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: selected == true ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: selected == true ? Colors.white : Colors.black,
            ),
            spaceW(10),
            Text(
              label,
              style: TextStyle(
                color: selected == true
                    ? Colors.white
                    : textColor != null
                        ? textColor
                        : Colors.black,
                fontWeight:
                    selected == true ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
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
          spaceH(10),
          Text(
            textTitle,
            style: const TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            textSubtitle,
            style: TextStyle(color: textColor.shade100),
          ),
        ],
      ),
    );
  }
}
