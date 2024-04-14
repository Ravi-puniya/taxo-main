import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/sunat_voucher_controller.dart';

class FilterDocumentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SunatVoucherController>(() => SunatVoucherController());
  }
}
