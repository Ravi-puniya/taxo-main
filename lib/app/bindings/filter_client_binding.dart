import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/client/client_controller.dart';

class FilterClientBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(() => ClientController());
  }
}
