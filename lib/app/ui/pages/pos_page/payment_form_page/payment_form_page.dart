import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/pos/payment_form_controller.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/payment_form_page/widgets/amount_input.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/payment_form_page/widgets/reference_input.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/payment_form_page/widgets/destiny_selector.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/payment_form_page/widgets/payment_method_selector.dart';

class PaymentFormPage extends GetView<PaymentFormController> {
  const PaymentFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String action = controller.currentEditionIndex.value != -1
          ? "Actualizar"
          : "Registrar";
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text("$action pago"),
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
            top: 24.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PaymentMethodSelector(),
              spaceH(16),
              DestinySelector(),
              spaceH(16),
              ReferenceInput(),
              spaceH(16),
              AmountInput(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              elevation: 0,
              onPressed: Get.back,
              label: Text(
                "CANCELAR",
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
              backgroundColor: Colors.grey.shade200,
              heroTag: null,
            ),
            const SizedBox(width: 12.0),
            FloatingActionButton.extended(
              elevation: 0,
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (controller.amountCnt.text.isNotEmpty &&
                    controller.suggesDestinationCnt.text.isNotEmpty &&
                    controller.suggestPaymentMethodCnt.text.isNotEmpty) {
                  controller.onSavePayment();
                } else {
                  displayWarningMessage(
                    message: "Ingrese los campos requeridos",
                    position: ToastGravity.CENTER,
                  );
                }
              },
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                "GUARDAR",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: primaryColor,
              heroTag: null,
            ),
          ],
        ),
      );
    });
  }
}
