import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/client/client_controller.dart';
import 'package:facturadorpro/app/controllers/client/client_form_controller.dart';

class ClientBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(() => ClientController());
    Get.lazyPut<ClientFormController>(() => ClientFormController());
  }
}
