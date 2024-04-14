import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/app/ui/models/payment_pos_model.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/api/models/response/init_params_pos.dart';
import 'package:facturadorpro/api/models/response/pos_payments_params_model.dart';

class PaymentFormController extends GetxController {
  FacturadorProvider provider = Get.put(FacturadorProvider());
  PosController posCnt = Get.put(PosController());

  final TextEditingController suggestPaymentMethodCnt = TextEditingController();
  final TextEditingController suggesDestinationCnt = TextEditingController();
  final TextEditingController referenceCnt = TextEditingController();
  final TextEditingController amountCnt = TextEditingController();

  Rx<PaymentMethodType> selectedPaymentMethod = PaymentMethodType.empty().obs;
  Rx<PaymentDestination> selectedDestination = PaymentDestination.empty().obs;

  RxInt currentEditionIndex = (-1).obs;

  @override
  void onInit() async {
    onInitSelectFirstDestination();
    super.onInit();
  }

  void onInitSelectFirstDestination() {
    if (posCnt.destinations.length == 1) {
      selectedDestination.value = posCnt.destinations[0];
      suggesDestinationCnt.text = posCnt.destinations[0].description;
    }
  }

  void onSelectPaymentMethod({required PaymentMethodType paymentMethodType}) {
    suggestPaymentMethodCnt.text = paymentMethodType.description;
    selectedPaymentMethod.value = paymentMethodType;
  }

  void onSelectDestination({required PaymentDestination paymentDestination}) {
    suggesDestinationCnt.text = paymentDestination.description;
    selectedDestination.value = paymentDestination;
  }

  void onClickAddButton() {
    amountCnt.text = "";
    referenceCnt.text = "";
    suggestPaymentMethodCnt.text = "";
    selectedPaymentMethod.value = PaymentMethodType.empty();
    currentEditionIndex.value = (-1);
    onInitSelectFirstDestination();
    Get.toNamed(Routes.PAYMENT_FORM_PAGE);
  }

  void onClickEditionButton({required int index}) {
    final payment = posCnt.selectedPayments[index];
    currentEditionIndex.value = index;

    selectedPaymentMethod.value = payment.paymentMethod;
    suggestPaymentMethodCnt.text = payment.paymentMethod.description;

    final destination = posCnt.destinations.firstWhere(
      (e) => e.id == payment.paymentDestinationId,
    );
    selectedDestination.value = destination;
    suggesDestinationCnt.text = destination.description;

    amountCnt.text = payment.payment;

    if (payment.reference != null) {
      referenceCnt.text = payment.reference!;
    }
    Get.toNamed(Routes.PAYMENT_FORM_PAGE);
  }

  void onClickDeleteButton({required int index}) {
    List<PaymentPosModel> tmpPayments = posCnt.selectedPayments;
    tmpPayments.removeAt(index);
    posCnt.updateEffectivePayment();
  }

  void onSavePayment() {
    // ignore: invalid_use_of_protected_member
    List<PaymentPosModel> tmpPayments = posCnt.selectedPayments.value;
    if (currentEditionIndex.value != -1) {
      final currentPayment = tmpPayments[currentEditionIndex.value];
      currentPayment.dateOfPayment = DateFormat('yyyy-MM-dd').format(
        DateTime.now(),
      );
      currentPayment.payment = amountCnt.text;
      currentPayment.paymentDestinationId = selectedDestination.value.id;
      currentPayment.paymentMethodTypeId = selectedPaymentMethod.value.id;
      currentPayment.reference =
          referenceCnt.text.isNotEmpty ? referenceCnt.text : null;
      currentPayment.paymentMethod = selectedPaymentMethod.value;
      currentEditionIndex.value = (-1);
    } else {
      tmpPayments.add(
        PaymentPosModel(
          dateOfPayment: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          payment: amountCnt.text,
          paymentDestinationId: selectedDestination.value.id,
          paymentMethodTypeId: selectedPaymentMethod.value.id,
          id: null,
          documentId: null,
          saleNoteId: null,
          reference: referenceCnt.text.isNotEmpty ? referenceCnt.text : null,
          paymentMethod: selectedPaymentMethod.value,
        ),
      );
    }
    posCnt.onUpdatePayments(payments: tmpPayments.toList());
    Get.back();
  }
}
