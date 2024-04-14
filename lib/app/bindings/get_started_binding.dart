import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/get_started_controller.dart';

class GetStartedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetStartedController>(() => GetStartedController());
  }
}
