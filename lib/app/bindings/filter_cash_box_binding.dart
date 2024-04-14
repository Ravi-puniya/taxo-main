import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/cash/cash_controller.dart';

class FilterCashBoxBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashController>(() => CashController());
  }
}
