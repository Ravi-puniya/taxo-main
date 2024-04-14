import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/pos/payment_form_controller.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';

class PaymentFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosController>(() => PosController());
    Get.lazyPut<PaymentFormController>(() => PaymentFormController());
  }
}
