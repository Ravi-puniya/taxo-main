import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';

class PosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PosController>(() => PosController());
  }
}
