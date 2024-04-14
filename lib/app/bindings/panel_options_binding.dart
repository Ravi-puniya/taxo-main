import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/vouchers_controller.dart';

class PanelOptionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VouchersController>(() => VouchersController());
  }
}
