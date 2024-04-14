import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/cash/cash_controller.dart';
import 'package:facturadorpro/app/controllers/cash/cash_form_controller.dart';

class CashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashController>(() => CashController());
    Get.lazyPut<CashFormController>(() => CashFormController());
  }
}
