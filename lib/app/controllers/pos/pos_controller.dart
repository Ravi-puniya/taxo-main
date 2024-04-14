import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/services.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:facturadorpro/shared/getx.dart';
import 'package:facturadorpro/shared/enums.dart';
import 'package:facturadorpro/shared/constants.dart';
import 'package:facturadorpro/shared/string_ext.dart';
import 'package:facturadorpro/shared/environment.dart';
import 'package:facturadorpro/app/controllers/directory_controller.dart';
import 'package:facturadorpro/api/models/response/email_sent_response_model.dart';
import 'package:facturadorpro/api/models/response/print_response_model.dart';
import 'package:facturadorpro/api/models/response/retrieve_client_response_model.dart';
import 'package:facturadorpro/api/models/response/print_sale_note_response_model.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/widgets/panel_sold_bottom_sheet.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/shared/mapping.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/custom_alert.dart';
import 'package:facturadorpro/api/models/customer_pos_model.dart';
import 'package:facturadorpro/app/ui/models/payment_pos_model.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:facturadorpro/app/ui/models/items_in_cart_model.dart';
import 'package:facturadorpro/api/models/response/init_params_pos.dart';
import 'package:facturadorpro/api/models/response/sale_response_model.dart';
import 'package:facturadorpro/api/models/request/voucher_request_model.dart';
import 'package:facturadorpro/api/models/response/exchange_sunat_model.dart';
import 'package:facturadorpro/api/models/response/barcode_searched_model.dart';
import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';
import 'package:facturadorpro/api/models/response/pos_payments_params_model.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/constants/pos_panel_list.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/filter_items_page/widgets/details_item.dart';

class PosController extends GetxController {
  FacturadorProvider provider = Get.put(FacturadorProvider());
  DirectoryController directoryCnt = Get.put(DirectoryController());
  final filterProductKey = new GlobalKey();

  final ScrollController scrollController = ScrollController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController suggestProductCnt = TextEditingController();
  final TextEditingController suggestCoinCnt = TextEditingController();
  final TextEditingController suggestInvoiceCnt = TextEditingController();
  final TextEditingController suggestSerieCnt = TextEditingController();
  final TextEditingController exchangeCnt = TextEditingController();
  final TextEditingController emailCnt = TextEditingController();
  final TextEditingController numberCnt = TextEditingController();

  late List<TextEditingController> dynamicQntCnt = <TextEditingController>[];
  late List<TextEditingController> dynamicPriceCnt = <TextEditingController>[];

  RxList<ItemPos> items = RxList<ItemPos>();
  RxList<bool> expandedPanels = [false, true, false].obs;
  final whatsappPdfCnt = TextEditingController();

  RxInt page = 1.obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isLoadingExchange = false.obs;
  RxBool hasMorePages = false.obs;
  RxBool isLoadingParams = true.obs;
  RxBool isActivedDetailed = false.obs;
  RxBool isSendingEmail = false.obs;
  RxBool isSendingWhatsapp = false.obs;

  Rx<EstablishmentPos> stablishment = EstablishmentPos.empty().obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<InvoiceType> invoiceTypes = <InvoiceType>[
    InvoiceType(id: FACTURA, description: "Factura"),
    InvoiceType(id: BOLETA, description: "Boleta"),
    InvoiceType(id: NOTA_VENTA, description: "Nota de venta"),
        InvoiceType(id: COTIZACION ,description: "COTIZACION"),
  ].obs;
  RxList<Series> series = <Series>[].obs;
  RxList<Series> seriesByInvoiceType = <Series>[].obs;
  RxList<CurrencyType> currencyTypes = <CurrencyType>[].obs;
  RxList<S2Choice<CustomerPosModel>> clients =
      <S2Choice<CustomerPosModel>>[].obs;
  RxList<PaymentMethodType> paymentMethods = <PaymentMethodType>[].obs;
  RxList<PaymentDestination> destinations = <PaymentDestination>[].obs;
  RxList<AffectationIgvType> affectationIgvTypes = <AffectationIgvType>[].obs;

  RxList<PaymentPosModel> selectedPayments = <PaymentPosModel>[].obs;
  Rx<Category> selectedCategory = Category(id: 0, name: "TODOS").obs;
  Rx<CurrencyType> selectedCoin = CurrencyType(
    id: "PEN",
    active: 1,
    description: "Soles",
    symbol: "S/",
  ).obs;
  Rx<InvoiceType> selectedInvoiceType = InvoiceType(
    id: "03",
    description: "Boleta",
  ).obs;
  Rx<Series> selectedSerie = Series.empty().obs;
  RxDouble todayExchange = 0.0.obs;
  Rx<CustomerPosModel?> selectedCustomer =
      RxNullable<CustomerPosModel?>().setNull();

  RxBool showLessButton = false.obs;
  RxBool isLoadingScanner = false.obs;
  RxBool isEditing = false.obs;
  RxList<ItemsInCartModel> itemsInCart = <ItemsInCartModel>[].obs;
  RxList<String> downloadPercent = ["0", "0"].obs;
  RxBool existsTck = false.obs;
  RxBool existsA4 = false.obs;
  RxString clientValidation = "".obs;

  /** FORM  */

  @override
  void onInit() async {
    await fetchInitParams();
    await getTodayExchangeRate();
    await filterItems();
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    quantityController.dispose();
    priceController.dispose();
    suggestProductCnt.dispose();
    suggestCoinCnt.dispose();
    suggestInvoiceCnt.dispose();
    suggestSerieCnt.dispose();
    exchangeCnt.dispose();
    emailCnt.dispose();
    numberCnt.dispose();
    super.dispose();
  }

  void onCancelSale({
    required BuildContext context,
    bool isPaymentPage = false,
  }) async {
    await customAlert(
      context: context,
      title: "Confirmación",
      message: "¿Desea cancelar en su totalidad la venta actual?",
      okText: "Si, cancelar",
      cancelText: "Quiero seguir",
      onOk: () {
        resetPosForm();
        Navigator.pop(context);
        Get.back();
        if (isPaymentPage) Get.back();
      },
    );
  }

  void onUpdatePayments({required List<PaymentPosModel> payments}) {
    selectedPayments.value = payments;
  }

  void resetPosForm() {
    dynamicQntCnt = <TextEditingController>[];
    dynamicPriceCnt = <TextEditingController>[];
    expandedPanels.value = [false, false, true];
    page.value = 1;
    hasMorePages.value = false;
    isActivedDetailed.value = false;
    selectedCategory.value = Category(id: 0, name: "TODOS");
    selectedCoin.value = CurrencyType(
      id: "PEN",
      active: 1,
      description: "Soles",
      symbol: "S/",
    );
    selectedInvoiceType.value = InvoiceType(
      id: "03",
      description: "Boleta",
    );
    selectedSerie.value = Series.empty();
    selectedCustomer.value = null;
    showLessButton.value = false;
    isEditing.value = false;
    itemsInCart.value = <ItemsInCartModel>[];
    paymentMethods.value = <PaymentMethodType>[];
    selectedPayments.value = <PaymentPosModel>[];
    destinations.value = <PaymentDestination>[];
    existsTck.value = false;
    existsA4.value = false;
  }

  double get getTotalItems {
    final double totalItems = itemsInCart.fold(0.0, (sum, next) {
      return sum + next.quantity;
    });
    return totalItems;
  }

  double get calculateTotalPayments {
    return selectedPayments.fold(0.0, (sum, next) {
      return sum + double.parse(next.payment.replaceAll(",", ""));
    });
  }

  double get calculateLeftToPay {
    final double total = itemsInCart.fold(0.0, (sum, next) => sum + next.total);
    final double totalPayments = selectedPayments.fold(0.0, (sum, next) {
      return sum + double.parse(next.payment.replaceAll(",", ""));
    });
    final double totalLeftToPay = total - totalPayments + calculateRounded;
    return totalLeftToPay > 0 ? totalLeftToPay : 0;
  }

  String getIcbperItem({required int id}) {
    ItemsInCartModel current = itemsInCart.firstWhere((e) => e.itemId == id);
    double icbper = double.parse(
      current.item.amountPlasticBagTaxes.replaceAll(",", ""),
    );
    if (selectedCoin.value.id == "USD") {
      icbper = icbper / todayExchange.value;
    }
    return formatMoney(
      quantity: icbper,
      decimalDigits: 2,
      symbol: selectedCoin.value.symbol,
    );
  }

  String getIcbperItemQnt({required int id}) {
    ItemsInCartModel current = itemsInCart.firstWhere((e) => e.itemId == id);
    double icbper = double.parse(
      current.item.amountPlasticBagTaxes.replaceAll(",", ""),
    );
    if (selectedCoin.value.id == "USD") {
      icbper = icbper / todayExchange.value;
    }
    return formatMoney(
      quantity: icbper * current.quantity,
      decimalDigits: 2,
      symbol: selectedCoin.value.symbol,
    );
  }

  String get calculateSubtotal {
    final double subtotal = itemsInCart.fold(0.0, (sum, next) {
      //return sum + (next.unitPrice * next.quantity);
      return sum + next.totalValue;
    });
    final String money = formatMoney(
      quantity: subtotal,
      decimalDigits: 2,
      symbol: selectedCoin.value.symbol,
    );
    return money;
  }

  String get calculateIcbper {
    final double totalIcbper = itemsInCart.fold(0.0, (sum, next) {
      if (next.item.hasPlasticBagTaxes) {
        double tax = double.parse(
          next.item.amountPlasticBagTaxes.replaceAll(",", ""),
        );
        if (selectedCoin.value.id == "USD") {
          tax = tax / todayExchange.value;
        }
        return sum + (tax * next.quantity);
      }
      return sum;
    });
    final String money = formatMoney(
      quantity: totalIcbper,
      decimalDigits: 2,
      symbol: selectedCoin.value.symbol,
    );
    return money;
  }

  String get calculateTotal {
    final double total = itemsInCart.fold(0.0, (sum, next) => sum + next.total);
    final String money = formatMoney(
      quantity: total,
      decimalDigits: 2,
      symbol: selectedCoin.value.symbol,
    );
    return money;
  }

  double get calculateRounded {
    final double total = itemsInCart.fold(0.0, (sum, next) => sum + next.total);
    final int totalInt = total.toInt();
    final double decimales = (total - totalInt).toPrecision(2);
    final double decima = (decimales % 0.1).toPrecision(2);
    double d = decima >= 0.05
        ? (0.1 - decima)
        : decima == 0
            ? 0
            : decima * -1;
    return d;
  }

  double get calculateTotalToPay {
    double total = itemsInCart.fold(0.0, (sum, next) => sum + next.total);
    return total + calculateRounded;
  }

  double get calculateTotalBagTax {
    return itemsInCart.fold(0.0, (sum, next) {
      return sum + next.totalPlasticBagTaxes;
    });
  }

  double get calculateTotalIgv {
    return itemsInCart.fold(0.0, (sum, next) {
      return sum + next.totalIgv;
    });
  }

  String get calculateReturnClient {
    final double total = itemsInCart.fold(0.0, (sum, next) => sum + next.total);
    final double amount = calculateTotalPayments - (total + calculateRounded);
    final String money = formatMoney(
      quantity: amount > 0 ? amount : 0,
      decimalDigits: 2,
      symbol: selectedCoin.value.symbol,
    );
    return money;
  }

  double get calculateTotalTaxes {
    final double amount = itemsInCart.fold(0.0, (sum, next) {
      return sum + next.totalTaxes;
    });
    return amount;
  }

  double get calculateTotalValue {
    final double amount = itemsInCart.fold(0.0, (sum, next) {
      return sum + next.totalValue;
    });
    return amount;
  }

  double get calculateTaxed {
    final double amount = itemsInCart.fold(0.0, (sum, next) {
      if (useIgvCodes.contains(next.affectationIgvTypeId)) {
        return sum + next.totalValue;
      }
      return sum + 0;
    });
    return amount;
  }

  double get calculateUnaffected {
    final double amount = itemsInCart.fold(0.0, (sum, next) {
      if (unaffectedCodes.contains(next.affectationIgvTypeId)) {
        return sum + next.totalValue;
      }
      return sum + 0;
    });
    return amount;
  }

  double get calculateExonerated {
    final double amount = itemsInCart.fold(0.0, (sum, next) {
      if (exoneratedCodes.contains(next.affectationIgvTypeId)) {
        return sum + next.totalValue;
      }
      return sum + 0;
    });
    return amount;
  }

  void scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (hasMorePages.value == true) await filterMoreItems();
    }
  }

  void onChangeActiveDetails({required bool active}) {
    isActivedDetailed.value = active;
  }

  void onExpandedPanel({required int index, required bool isExpanded}) {
    for (int i = 0; i < posPanelList.length; i++) {
      if (index == i) {
        expandedPanels[index] = !isExpanded;
      }
    }
    update();
  }

  int findIndexFromId(int id) => itemsInCart.indexWhere((i) => i.itemId == id);

  void changeEditing() {
    isEditing.value = !isEditing.value;
    print(isEditing.value);
  }

  void putAmountToCart({required double quantity, int? id}) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (id != null) {
      int index = findIndexFromId(id);
      double newQnt = double.parse(dynamicQntCnt[index].text) + quantity;
      dynamicQntCnt[index].text = (newQnt <= 1 ? 1 : newQnt).toStringAsFixed(0);
      _executeSaleUpdaterAmounts(index: index);
    } else {
      final double qntItems = double.parse(quantityController.text) + quantity;
      if (qntItems <= 1) {
        quantityController.text = "1";
        showLessButton.value = false;
      } else {
        quantityController.text = qntItems.toStringAsFixed(0);
        showLessButton.value = true;
      }
    }
  }

  void onChangePriceItem({required double price, required int id}) {
    int index = findIndexFromId(id);
    dynamicPriceCnt[index].text = price.toStringAsFixed(2);
    _executeSaleUpdaterAmounts(index: index);
  }

  void onChangedQuantityItem({required double quantity, int? id}) {
    if (id != null) {
      int index = findIndexFromId(id);
      dynamicQntCnt[index].text = quantity.toStringAsFixed(0);
      _executeSaleUpdaterAmounts(index: index);
    } else {
      showLessButton.value = quantity > 1;
      if (quantity == 0) {
        quantityController.text = "1";
      } else {
        quantityController.text = quantity.toStringAsFixed(0);
      }
    }
  }

  void _executeSaleUpdaterAmounts({required int index}) {
    final updatedItem = updatedAmountItem(currentSaleItem: itemsInCart[index]);
    List<ItemsInCartModel> tmpItems = itemsInCart;
    tmpItems[index] = updatedItem;
    updateEffectivePayment();
  }

  ItemsInCartModel updatedAmountItem({
    required ItemsInCartModel currentSaleItem,
    bool useCoinValidator = false,
    String? unitTypeId = null,
    double? unitTypePrice = null,
    String? newDescription = null,
    Presentation? presentation = null,
  }) {
    final currentItem = currentSaleItem;
    ItemPos infoItem = currentSaleItem.item;
    int index = findIndexFromId(infoItem.id);

    final bool isUSD = selectedCoin.value.id == "USD";
    final bool isPEN = selectedCoin.value.id == "PEN";
    double quantity = double.parse(dynamicQntCnt[index].text);
    double unitPrice = double.parse(dynamicPriceCnt[index].text);
    infoItem.saleUnitPrice = unitPrice.toString();
    infoItem.editSaleUnitPrice = unitPrice.toString();

    if (newDescription != null) {
      infoItem.presentation = presentation;
      currentItem.presentation = presentation;
      if (unitTypeId != null) {
        infoItem.unitTypeId = unitTypeId;
      }
    }

    if (presentation != null) {}

    double unitTaxes = 0;
    double unitValue = unitPrice;
    double unitIgv = 0;
    double unitBagTax = 0;

    double totalBaseIgv = 0;
    double totalTaxes = 0;
    double totalIgv = 0;
    double totalBagTaxes = 0;
    double totalSale = 0;

    if (useCoinValidator) {
      if (isUSD) {
        unitPrice = unitPrice / todayExchange.value;
      }
      if (isPEN) {
        if (unitTypeId != null && unitTypePrice != null) {
          unitPrice = unitTypePrice;
        } else {
          unitPrice = double.parse(infoItem.auxSaleUnitPrice);
        }
        unitValue = unitPrice;
      }
    } else {
      unitValue = double.parse(dynamicPriceCnt[index].text);
    }

    dynamicPriceCnt[index].text = unitPrice.toStringAsFixed(2);

    if (useIgvCodes.contains(infoItem.saleAffectationIgvTypeId)) {
      unitIgv = (unitPrice * 18) / 118;
      unitValue = unitPrice - unitIgv;
      unitTaxes = unitTaxes + unitIgv;
      totalBaseIgv = unitValue * quantity;
      totalIgv = unitIgv * quantity;
    } else {
      totalBaseIgv = unitPrice * quantity;
    }

    if (infoItem.hasPlasticBagTaxes) {
      unitBagTax = double.parse(infoItem.amountPlasticBagTaxes);
      if (isUSD) {
        unitBagTax = unitBagTax / todayExchange.value;
      }
      totalBagTaxes = unitBagTax * quantity;
    }

    totalTaxes = totalIgv + totalBagTaxes;
    totalSale = totalBaseIgv + totalTaxes;

    currentItem.quantity = quantity;
    currentItem.totalBaseIgv = totalBaseIgv.toPrecision(2);
    currentItem.percentageIgv = 18;
    currentItem.totalIgv = totalIgv.toPrecision(2);
    currentItem.totalPlasticBagTaxes = totalBagTaxes.toPrecision(2);
    currentItem.totalTaxes = totalTaxes.toPrecision(2);
    currentItem.totalValue = totalBaseIgv.toPrecision(2);
    currentItem.total = totalSale.toPrecision(2);
    currentItem.totalValueWithoutRounding = totalBaseIgv;
    currentItem.totalBaseIgvWithoutRounding = totalBaseIgv;
    currentItem.totalIgvWithoutRounding = totalIgv;
    currentItem.totalTaxesWithoutRounding = totalTaxes;
    currentItem.totalWithoutRounding = totalSale;
    currentItem.unitPrice = unitPrice;
    currentItem.unitValue = unitValue;
    if (unitTypeId != null) {
      currentItem.unitTypeId = unitTypeId;
    }

    return currentItem;
  }

  void updateEffectivePayment() {
    List<PaymentPosModel> tmpPayments = selectedPayments;
    if (tmpPayments.length > 0) {
      int paymentIndex = tmpPayments.indexWhere(
        (e) => e.paymentMethod.id == "01",
      );
      if (paymentIndex != -1) {
        PaymentPosModel currentPayment = selectedPayments[paymentIndex];
        String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        double totalOtherPayments = selectedPayments.fold(0.0, (sum, next) {
          if (next.paymentMethod.id != "01") {
            return sum + double.parse(next.payment);
          }
          return sum + 0;
        });
        double total = itemsInCart.fold(0.0, (sum, next) => sum + next.total);
        double addedAmount = (total + calculateRounded) - totalOtherPayments;
        currentPayment.dateOfPayment = today;
        currentPayment.payment = addedAmount.toStringAsFixed(2);
        selectedPayments.value = tmpPayments.toList();
      }
      update();
    }
  }

  void onSelectCategory({required Category category}) {
    if (selectedCategory.value.id == category.id) {
      selectedCategory.value = Category(id: 0, name: "TODOS");
    } else {
      selectedCategory.value = category;
    }
    filterItems();
  }

  void resetToOneCounter() {
    quantityController.text = "1";
    showLessButton.value = false;
    isEditing.value = false;
  }

  void onRemoveItemToCart({required int id}) {
    final tmp = itemsInCart.where((e) => e.itemId != id);
    final index = itemsInCart.indexWhere((e) => e.itemId == id);
    itemsInCart.value = tmp.toList();
    dynamicQntCnt.removeAt(index);
    dynamicPriceCnt.removeAt(index);
    updateEffectivePayment();
    update();
  }

  void onAddItemToCart({required ItemPos item}) {
    ItemsInCartModel? foundItem = itemsInCart.firstWhereOrNull(
      (e) => e.item.id == item.id,
    );
    if (foundItem == null) {
      double qnt = double.parse(quantityController.text);
      String qntText = qnt.toStringAsFixed(0);
      double unitPrice = double.parse(item.auxSaleUnitPrice);
      bool isUSD = selectedCoin.value.id == "USD";

      double unitTaxes = 0;
      double unitValue = unitPrice;
      double unitIgv = 0;
      double unitBagTax = 0;

      if (isUSD) {
        unitPrice = unitPrice / todayExchange.value;
      }

      dynamicQntCnt.add(new TextEditingController(text: qntText));
      dynamicPriceCnt.add(
        new TextEditingController(
          text: unitPrice.toStringAsFixed(2),
        ),
      );

      double totalBaseIgv = 0;
      double totalTaxes = 0;
      double totalIgv = 0;
      double totalBagTaxes = 0;
      double totalSale = 0;

      AffectationIgvType affectationIgv = affectationIgvTypes.firstWhere(
        (e) => e.id == item.saleAffectationIgvTypeId,
      );

      if (useIgvCodes.contains(item.saleAffectationIgvTypeId)) {
        unitIgv = (unitPrice * 18) / 118;
        unitValue = unitPrice - unitIgv;
        unitTaxes = unitTaxes + unitIgv;

        totalBaseIgv = unitValue * qnt;
        totalIgv = unitIgv * qnt;
      } else {
        totalBaseIgv = unitPrice * qnt;
      }

      if (item.hasPlasticBagTaxes) {
        unitBagTax = double.parse(item.amountPlasticBagTaxes);
        if (isUSD) {
          unitBagTax = unitBagTax / todayExchange.value;
        }
        totalBagTaxes = unitBagTax * qnt;
      }

      totalTaxes = totalIgv + totalBagTaxes;
      totalSale = totalBaseIgv + totalTaxes;

      ItemsInCartModel itemInCart = ItemsInCartModel(
        item: new ItemPos(
          id: item.id,
          itemId: item.itemId,
          fullDescription: item.fullDescription,
          description: item.description,
          previousDescription: item.description,
          currencyTypeId: item.currencyTypeId,
          currencyTypeSymbol: item.currencyTypeSymbol,
          saleUnitPrice: item.saleUnitPrice,
          purchaseUnitPrice: item.purchaseUnitPrice,
          unitTypeId: item.unitTypeId,
          saleAffectationIgvTypeId: item.saleAffectationIgvTypeId,
          purchaseAffectationIgvTypeId: item.purchaseAffectationIgvTypeId,
          calculateQuantity: item.calculateQuantity,
          hasIgv: item.hasIgv,
          isSet: item.isSet,
          editUnitPrice: item.editUnitPrice,
          auxQuantity: item.auxQuantity,
          editSaleUnitPrice: item.editSaleUnitPrice,
          auxSaleUnitPrice: item.auxSaleUnitPrice,
          imageUrl: item.imageUrl,
          warehouses: item.warehouses,
          unitType: item.unitType,
          category: item.category,
          brand: item.brand,
          hasPlasticBagTaxes: item.hasPlasticBagTaxes,
          amountPlasticBagTaxes: item.amountPlasticBagTaxes,
          hasIsc: item.hasIsc,
          percentageIsc: item.percentageIsc,
          isBarcode: item.isBarcode,
        ),
        itemId: item.id,
        currencyTypeId: item.currencyTypeId,
        quantity: qnt,
        unitValue: unitValue,
        affectationIgvTypeId: affectationIgv.id,
        affectationIgvType: affectationIgv,
        totalBaseIgv: totalBaseIgv.toPrecision(2),
        percentageIgv: 18,
        totalIgv: totalIgv.toPrecision(2),
        totalBaseIsc: 0,
        percentageIsc: 0,
        totalIsc: 0,
        totalBaseOtherTaxes: 0,
        percentageOtherTaxes: 0,
        totalOtherTaxes: 0,
        totalPlasticBagTaxes: totalBagTaxes.toPrecision(2),
        totalTaxes: totalTaxes.toPrecision(2),
        priceTypeId: "01",
        unitPrice: unitPrice.toPrecision(2),
        totalValue: totalBaseIgv.toPrecision(2),
        totalDiscount: 0,
        totalCharge: 0,
        total: totalSale.toPrecision(2),
        attributes: [],
        charges: [],
        discounts: [],
        totalValueWithoutRounding: totalBaseIgv,
        totalBaseIgvWithoutRounding: totalBaseIgv,
        totalIgvWithoutRounding: totalIgv,
        totalTaxesWithoutRounding: totalTaxes,
        totalWithoutRounding: totalSale,
        unitTypeId: item.unitTypeId,
      );
      itemsInCart.add(itemInCart);
    }
    updateEffectivePayment();
    update();
  }

  Future<void> fetchInitParams({int? id}) async {
    try {
      isLoadingParams.value = true;
      final Response res = await provider.initParamsPos();
      if (res.statusCode == 200) {
        InitParamsPos result = initParamsPosFromJson(res.bodyString!);
        List<Category> tmpCategories = <Category>[];
        tmpCategories.add(Category(id: 0, name: "TODOS"));
        tmpCategories.addAll(result.categories);
        categories.value = tmpCategories;
        currencyTypes.value = result.currencyTypes;
        stablishment.value = result.establishment;
        affectationIgvTypes.value = result.affectationIgvTypes;
        clients.value = result.customers.map((e) {
          String name = (e.description ?? e.name).toTitleCase();
          return S2Choice(value: e, title: name);
        }).toList();
        update();
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingParams.value = false;
    }
  }

  Future<void> fetchPaymentsPos({int? id}) async {
    try {
      isLoadingParams.value = true;
      final Response res = await provider.initPaymentsPos();
      if (res.statusCode == 200) {
        PosPaymentsParamsModel result = posPaymentsParamsModelFromJson(
          res.bodyString!,
        );
        series.value = result.series;
        print("seriesssss");
    series.map((e) {
      print(e.toJson()) ;});
        destinations.value = result.paymentDestinations;
        paymentMethods.value = result.paymentMethodTypes;
        if (selectedPayments.length == 0) {
          PaymentMethodType? effective =
              result.paymentMethodTypes.firstWhereOrNull(
            (e) => e.id == "01",
          );
          if (effective != null && result.paymentDestinations.length > 0) {
            double total = calculateTotalToPay;
            PaymentDestination? destination =
                result.paymentDestinations.firstWhereOrNull(
              (e) => e.id == "cash",
            );
            if (destination == null) {
              destination = result.paymentDestinations[0];
            }
            List<PaymentPosModel> _tmp = <PaymentPosModel>[];
            _tmp.add(
              PaymentPosModel(
                dateOfPayment: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                payment: total.toStringAsFixed(2),
                paymentDestinationId: destination.id,
                paymentMethodTypeId: effective.id,
                id: null,
                documentId: null,
                saleNoteId: null,
                reference: null,
                paymentMethod: effective,
              ),
            );
            selectedPayments.value = _tmp;
          }
        }
        onSelectInvoiceType(invoiceType: selectedInvoiceType.value);
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingParams.value = false;
    }
  }

  Future<void> filterItemsFromInput({required String value}) async {
    try {
      isLoading.value = true;
      final Response res = await provider.filterPosItems(
        page: 1,
        categoryId: 0,
        column: "name",
        searchValue: value,
      );
      if (res.statusCode == 200) {
        FilteredItemPosModel response = filteredItemPosModelFromJson(
          res.bodyString!,
        );
        selectedCategory.value = Category(id: 0, name: "TODOS");
        hasMorePages.value = response.links.next != null;
        items.value = response.data;
        page.value = 1;
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoading.value = false;
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  Future<void> filterItems({bool? useLoader = true, String? value}) async {
    try {
      if (useLoader == true) isLoading.value = true;
      final Response res = await provider.filterPosItems(
        page: 1,
        categoryId: selectedCategory.value.id,
      );
      if (res.statusCode == 200) {
        FilteredItemPosModel response = filteredItemPosModelFromJson(
          res.bodyString!,
        );
        hasMorePages.value = response.links.next != null;
        items.value = response.data;
        page.value = 1;
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      if (useLoader == true) isLoading.value = false;
    }
  }

  Future<void> filterMoreItems() async {
    try {
      isLoadingMore.value = true;
      final Response res = await provider.filterPosItems(
        page: page.value + 1,
        categoryId: selectedCategory.value.id,
      );
      if (res.statusCode == 200) {
        FilteredItemPosModel response = filteredItemPosModelFromJson(
          res.bodyString!,
        );
        hasMorePages.value = response.links.next != null;
        items.addAll(response.data);
        page.value++;
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingMore.value = false;
    }
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
        customAlert(
          context: context,
          type: CoolAlertType.loading,
          message: "Buscando producto...",
        );
        final Response res = await provider.filterPosItemsByBarcode(
          barcode: barcodeScanRes,
        );
        if (res.statusCode == 200) {
          BarcodeSearchedModel result = barcodeSearchedModelFromJson(
            res.bodyString!,
          );
          Navigator.pop(context);
          if (result.items.length > 1) {
            displayInfoMessage(message: "Se encontraron varios registros");
            items.value = result.items;
          } else if (result.items.length == 1) {
            ItemPos item = result.items[0];
            item.isBarcode = true;
            Get.bottomSheet(
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: DetailsItem(itemPos: item),
              ),
              backgroundColor: Colors.transparent,
            );
            quantityController.text = "1";
          } else {
            displayWarningMessage(message: "Producto no registrado");
          }
        }
      }
    } on PlatformException {
      displayErrorMessage(
        message: "La plataforma no es válida para el scanner.",
      );
    } catch (error) {
      displayErrorMessage(
        message: "El código de barras no es válido.",
      );
    } finally {
      isLoadingScanner.value = false;
    }
  }

  /** INIT FORM CAR */
  Future<void> onInitSaleDetails() async {
    expandedPanels.value = [false, true, false];
    await fetchPaymentsPos();
    if (selectedCustomer.value == null) {
      S2Choice<CustomerPosModel>? foundDefault = clients.firstWhereOrNull((e) {
        return e.value.number == "99999999";
      });
      selectedCustomer.value = foundDefault!.value;
      update();
    }
    suggestCoinCnt.text = selectedCoin.value.description;
    suggestInvoiceCnt.text = selectedInvoiceType.value.description;
    dynamicQntCnt.clear();
    dynamicPriceCnt.clear();
    itemsInCart.map((e) {
      dynamicQntCnt.add(
        new TextEditingController(text: e.quantity.toStringAsFixed(0)),
      );
      dynamicPriceCnt.add(
        new TextEditingController(text: e.unitPrice.toStringAsFixed(2)),
      );
    }).toList();
  }

  /** EXCHANGE RATE */
  Future<void> getTodayExchangeRate() async {
    try {
      isLoadingExchange.value = true;
      Response res = await provider.fetchSunatExchange(
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      );
      if (res.statusCode == 200) {
        ExchangeSunatModel result = exchangeSunatModelFromJson(res.bodyString!);
        exchangeCnt.text = result.sale.toString();
        todayExchange.value = result.sale;
      }
    } catch (error) {
      displayErrorMessage(message: "Error al consultar el tipo de cambio");
    } finally {
      isLoadingExchange.value = false;
    }
  }

  /** MONEDAS */
  void onSelectCoin({required CurrencyType coin}) {
    selectedCoin.value = coin;
    suggestCoinCnt.text = coin.description;
    itemsInCart.map((i) {
      double defaulPrice = 0;
      final unitType =
          i.item.unitType.firstWhereOrNull((e) => e.unitTypeId == i.unitTypeId);
      if (unitType != null) {
        if (unitType.priceDefault == 1) {
          defaulPrice = double.parse(unitType.price1);
        }
        if (unitType.priceDefault == 2) {
          defaulPrice = double.parse(unitType.price2);
        }
        if (unitType.priceDefault == 3) {
          defaulPrice = double.parse(unitType.price3);
        }
        return updatedAmountItem(
          currentSaleItem: i,
          useCoinValidator: true,
          unitTypeId: unitType.unitTypeId,
          unitTypePrice: defaulPrice,
        );
      } else {
        return updatedAmountItem(
          currentSaleItem: i,
          useCoinValidator: true,
          unitTypeId: i.unitTypeId,
          unitTypePrice: double.parse(i.item.auxSaleUnitPrice),
        );
      }
    }).toList();
    updateEffectivePayment();
  }

  /** TIPO DE COMPROBANTE */
  void onSelectInvoiceType({required InvoiceType invoiceType}) {
        print("gholaar") ;

    selectedInvoiceType.value = invoiceType;
    suggestInvoiceCnt.text = invoiceType.description;
    List<Series> tmpSeries = <Series>[];
    series.map((e) {
      print(e.toJson()) ;
      if (e.documentTypeId == invoiceType.id) {
        tmpSeries.add(e);
      }
    }).toList();
    if (tmpSeries.length > 0) {
      selectedSerie.value = tmpSeries[0];
      suggestSerieCnt.text = tmpSeries[0].number;
    }
    if (invoiceType.id == "01") {
      if (selectedCustomer.value!.number.length < 11) {
        String msg = "El cliente no tiene un RUC válido.";
        displayWarningMessage(message: msg);
        clientValidation.value = msg;
        expandedPanels[0] = true;
      } else {
        clientValidation.value = "";
      }
    } else {
      clientValidation.value = "";
    }
    seriesByInvoiceType.value = tmpSeries;
  }

  /** SERIE */
  void onSelectSerie({required Series serie}) {
    selectedSerie.value = serie;
    suggestSerieCnt.text = serie.number;
  }

  /** CUSTOMERS */
  void onSelectCustomer({
    required S2SingleSelected<CustomerPosModel?> customer,
  }) async {
    if (customer.value != null) {
      int numberLength = customer.value!.number.length;
      if (selectedInvoiceType.value.id == "01" && numberLength < 11) {
        String msg = "El cliente no tiene un RUC válido.";
        displayWarningMessage(message: msg);
        clientValidation.value = msg;
      } else {
        clientValidation.value = "";
      }
      selectedCustomer.value = customer.value;
    }
  }

  Future<void> onSaveSale(BuildContext context) async {
    try {
      if (itemsInCart.length == 0) {
        return displayWarningMessage(message: "Debe agregar al menos un item");
      }
      if (calculateTotalPayments < calculateLeftToPay) {
        return displayWarningMessage(
          message: "Aún queda pendiente completar el monto de la venta",
        );
      }
      customAlert(
        context: context,
        title: "Confirmación",
        message: "¿Desea guardar esta venta con la información proporcionada?",
        onOk: () async {
          await _saveSale(context);
        },
        okText: "Si, guardar",
      );
    } catch (error) {
      Navigator.pop(context);
      displayErrorMessage();
    }
  }

  Future<void> _saveSale(BuildContext context) async {
    Navigator.pop(context);
    customAlert(
      context: context,
      message: "Cargando...",
      type: CoolAlertType.loading,
    );
    DateTime today = DateTime.now();
    String todayFormat = DateFormat("yyyy-MM-dd").format(today);
    VoucherRequestModel voucher = VoucherRequestModel(
      establishmentId: stablishment.value.id,
      documentTypeId: selectedInvoiceType.value.id,
      seriesId: selectedSerie.value.id,
      number: "#",
      dateOfIssue: todayFormat,
      timeOfIssue: DateFormat("hh:mm:ss").format(today),
      customerId: selectedCustomer.value!.id,
      currencyTypeId: selectedCoin.value.id,
      exchangeRateSale: todayExchange.value,
      totalPrepayment: 0,
      totalCharge: 0,
      totalDiscount: 0,
      totalExportation: 0,
      totalFree: 0,
      totalTaxed: calculateTaxed,
      totalUnaffected: calculateUnaffected,
      totalExonerated: calculateExonerated,
      totalIgv: calculateTotalIgv,
      totalBaseIsc: 0,
      totalIsc: 0,
      totalBaseOtherTaxes: 0,
      totalOtherTaxes: 0,
      totalPlasticBagTaxes: calculateTotalBagTax,
      totalTaxes: calculateTotalTaxes,
      totalValue: calculateTotalValue,
      total: calculateTotalToPay,
      subtotal: calculateTotalToPay,
      totalIgvFree: 0,
      operationTypeId: "0101",
      dateOfDue: todayFormat,
      items: itemsInCart,
      charges: [],
      discounts: [],
      attributes: [],
      guides: [],
      payments: selectedPayments,
      actions: ActionsModel(formatPdf: "a4"),
      isPrint: true,
      totalTips: 0,
    );
    Response res = await provider.registerSale(voucher: voucher);
    if (res.statusCode == 200) {
      SaleResponseModel result = saleResponseModelFromJson(res.bodyString!);
      if (result.success == false && result.message != null) {
        return displayWarningMessage(message: result.message!);
      }
      if (result.success == true) {
        await provider.registerSaleInCashBox(
          documentId: [BOLETA, FACTURA].contains(voucher.documentTypeId)
              ? result.data!.id
              : null,
          saleNoteId:
              voucher.documentTypeId == NOTA_VENTA ? result.data!.id : null,
        );
        Response resClient = await provider.retrieveClient(
          id: voucher.customerId,
        );
        if (resClient.statusCode == 200) {
          RetrieveClientResponseModel resultClient =
              retrieveClientResponseModelFromJson(
            resClient.bodyString!,
          );
          if (resultClient.data != null) {
            emailCnt.text = resultClient.data!.email ?? "";
            String cellPhone = resultClient.data!.telephone ?? "";
            if (cellPhone.isNotEmpty) {
              if (isValidCellPhoneNumber(cellPhone)) {
                numberCnt.text = cellPhone;
              } else {
                displayWarningMessage(
                  message: "El número de celular no es válido.",
                );
              }
            }
          }
        }
        if (result.data != null) {
          if (voucher.documentTypeId == NOTA_VENTA) {
            // nota de venta
            Response resDoc = await provider.fetchPrintSaleNoteInfo(
              documentId: result.data!.id,
            );
            final resultDoc = printSaleNoteResponseModelFromJson(
              resDoc.bodyString!,
            );
            if (directoryCnt.downloadDir.value.isNotEmpty) {
              bool isDownloadedTck = await existsDir(
                dirname: directoryCnt.downloadDir.value,
                filename: "${resultDoc.data.fullNumber}-ticket.pdf",
              );
              bool isDownloadedA4 = await existsDir(
                dirname: directoryCnt.downloadDir.value,
                filename: "${resultDoc.data.fullNumber}-a4.pdf",
              );
              existsTck.value = isDownloadedTck;
              existsA4.value = isDownloadedA4;
            }
            Navigator.pop(context);
            Get.bottomSheet(
              PanelSoldBottomSheet(
                documentId: result.data!.id,
                message: resultDoc.data.messageText,
                pdfLinkTck: resultDoc.data.printTicket,
                pdfLinkA4: resultDoc.data.printA4,
                correlative: resultDoc.data.fullNumber,
                context: context,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              ignoreSafeArea: false,
              isScrollControlled: true,
              isDismissible: false,
              enableDrag: false,
              backgroundColor: Colors.white,
            );
          }
          if (["01", "03"].contains(voucher.documentTypeId)) {
            Response resDoc = await provider.fetchPrintVoucherInfo(
              documentId: result.data!.id,
            );
            PrintResponseModel resultDoc = printResponseModelFromJson(
              resDoc.bodyString!,
            );
            if (directoryCnt.downloadDir.value.isNotEmpty) {
              bool isDownloadedTck = await existsDir(
                dirname: directoryCnt.downloadDir.value,
                filename: "${resultDoc.data.number}-ticket.pdf",
              );
              bool isDownloadedA4 = await existsDir(
                dirname: directoryCnt.downloadDir.value,
                filename: "${resultDoc.data.number}-a4.pdf",
              );
              existsTck.value = isDownloadedTck;
              existsA4.value = isDownloadedA4;
            }
            Navigator.pop(context);
            if (result.data!.response != null) {
              if (result.data!.response!.sent == true) {
                Get.bottomSheet(
                  PanelSoldBottomSheet(
                    documentId: result.data!.id,
                    message: result.data!.response!.description!,
                    pdfLinkTck: resultDoc.data.printTicket,
                    pdfLinkA4: resultDoc.data.printA4,
                    correlative: resultDoc.data.number,
                    context: context,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  ignoreSafeArea: false,
                  isScrollControlled: true,
                  isDismissible: false,
                  enableDrag: false,
                  backgroundColor: Colors.white,
                );
              } else {
                Get.bottomSheet(
                  PanelSoldBottomSheet(
                    documentId: result.data!.id,
                    message: "La venta se registró exitosamente.",
                    pdfLinkTck: resultDoc.data.printTicket,
                    pdfLinkA4: resultDoc.data.printA4,
                    correlative: resultDoc.data.number,
                    context: context,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  ignoreSafeArea: false,
                  isScrollControlled: true,
                  isDismissible: false,
                  enableDrag: false,
                  backgroundColor: Colors.white,
                );
              }
            }
          }
        }
      } else {
        displayWarningMessage(message: result.message!);
      }
    }
  }

  Future<void> onSendEmail({required int documentId}) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      String email = emailCnt.text;
      if (email.isEmpty) {
        return displayWarningMessage(message: "Ingrese un correo electrónico");
      }
      if (email.isNotEmpty && !EmailValidator.validate(email)) {
        return displayWarningMessage(
          message: "El correo electrónico no es válido",
        );
      }
      isSendingEmail.value = true;
      Response res = await provider.sendEmailToClient(
        email: emailCnt.text,
        documentId: documentId,
      );
      if (res.statusCode == 200) {
        EmailSentResponseModel result = emailSentResponseModelFromJson(
          res.bodyString!,
        );
        if (result.success) {
          displaySuccessMessage(
            message: "El comprobante fue enviado al correo electrónico",
          );
          emailCnt.text = "";
        } else {
          displayErrorMessage(
            message: "Ha ocurrido un problema al enviar el comprobante",
          );
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isSendingEmail.value = false;
    }
  }

  Future<void> onSendWhatsapp({required int documentId}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    String phone = numberCnt.text;
    if (phone.isEmpty) {
      return displayWarningMessage(
        message: "Por favor ingrese un número de celular",
      );
    }
    try {
      isSendingWhatsapp.value = true;
      Response res = await provider.fetchPrintVoucherInfo(
        documentId: documentId,
      );
      if (res.statusCode == 200) {
        PrintResponseModel result = printResponseModelFromJson(
          res.bodyString!,
        );
        var whatsappURlAndroid =
            "whatsapp://send?phone=+51$phone&text=${result.data.messageText}";
        var whatsappURLIos =
            "https://wa.me/$phone?text=${Uri.tryParse(result.data.messageText)}";
        if (Platform.isIOS) {
          if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
            numberCnt.text = "";
            await launchUrl(Uri.parse(whatsappURLIos));
          } else {
            displayWarningMessage(message: "Whatsapp no instalado");
          }
        } else {
          if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
            numberCnt.text = "";
            await launchUrl(Uri.parse(whatsappURlAndroid));
          } else {
            displayWarningMessage(message: "Whatsapp no instalado");
          }
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isSendingWhatsapp.value = false;
    }
  }

  void onChangePresentation({
    required double price,
    required int index,
    required Presentation presentation,
  }) {
    double finalPrice = price;
    if (selectedCoin.value.id == "USD") {
      finalPrice = price / todayExchange.value;
    }
    dynamicPriceCnt[index].text = finalPrice.toStringAsFixed(2);
    final updatedItem = updatedAmountItem(
      currentSaleItem: itemsInCart[index],
      unitTypeId: presentation.unitTypeId,
      unitTypePrice: finalPrice,
      useCoinValidator: true,
      newDescription:
          "${itemsInCart[index].item.previousDescription} - ${presentation.description}",
      presentation: presentation,
    );
    List<ItemsInCartModel> tmpItems = itemsInCart;
    tmpItems[index] = updatedItem;
    update();
    updateEffectivePayment();
    Get.back();
    displaySuccessMessage(message: "Precios actualizados");
  }

  Future<void> reloadPosClients() async {
    try {
      isLoadingParams.value = true;
      final Response res = await provider.initParamsPos();
      if (res.statusCode == 200) {
        InitParamsPos result = initParamsPosFromJson(res.bodyString!);
        List<int> previousIds = clients.map((e) => e.value.id).toList();
        List<int> nextIds = result.customers.map((e) => e.id).toList();
        int newId = nextIds.firstWhere((e) => !previousIds.contains(e));
        final customer = result.customers.firstWhere((e) => e.id == newId);
        clients.value = result.customers.map((e) {
          String name = (e.description ?? e.name).toTitleCase();
          return S2Choice(value: e, title: name);
        }).toList();
        selectedCustomer.value = customer;
        if (selectedInvoiceType.value.id == "01") {
          if (selectedCustomer.value!.number.length < 11) {
            String msg = "El cliente no tiene un RUC válido.";
            displayWarningMessage(message: msg);
            clientValidation.value = msg;
            expandedPanels[0] = true;
          } else {
            clientValidation.value = "";
          }
        } else {
          clientValidation.value = "";
        }
        update();
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingParams.value = false;
    }
  }

  Future<void> downloadVoucher({
    required String pdfLink,
    required String correlative,
    required DownloadType type,
  }) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (statuses[Permission.storage]!.isGranted) {
      var dir = await DownloadsPath.downloadsDirectory();
      if (dir != null) {
        String pathname = "${dir.path}/${Environment.businessDomain}/";
        if (type == DownloadType.TCK) pathname += "$correlative-ticket.pdf";
        if (type == DownloadType.A4) pathname += "$correlative-a4.pdf";
        if (!File(pathname).existsSync()) {
          try {
            await dio.Dio().download(
              pdfLink,
              pathname,
              onReceiveProgress: (received, total) {
                String downloaded = (received / total * 100).toStringAsFixed(0);
                if (type == DownloadType.TCK) {
                  downloadPercent.value = [downloaded, "0"];
                }
                if (type == DownloadType.A4) {
                  downloadPercent.value = ["0", downloaded];
                }
              },
            );
            displaySuccessMessage(message: "Descarga completa");
            if (type == DownloadType.TCK) existsTck.value = true;
            if (type == DownloadType.A4) existsA4.value = true;
            downloadPercent.value = ["0", "0"];
          } on dio.DioError catch (_) {
            displayErrorMessage(message: "Error al descargar comprobante");
          }
        } else {
          if (type == DownloadType.TCK) existsTck.value = true;
          if (type == DownloadType.A4) existsA4.value = true;
          displayInfoMessage(message: "El comprobante ya fue descargado");
        }
      } else {
        displayWarningMessage(
          message: "No es posible guardar en este dispositivo",
        );
      }
    } else {
      displayWarningMessage(
        message: "No es posible continuar sin los permisos necesarios.",
      );
    }
  }

  Future<void> onOpenPdf({required String filename}) async {
    try {
      String domain = Environment.businessDomain;
      String pathname = "${directoryCnt.downloadDir.value}/$domain/$filename";
      OpenFile.open(pathname);
    } catch (error) {
      displayErrorMessage(message: "No es posible abrir el archivo PDF");
    }
  }

  void onClosePanelSold() {
    numberCnt.text = "";
    emailCnt.text = "";
    resetPosForm();
    Get.back();
    Get.back();
  }
}
