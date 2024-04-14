import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/product/presentation_form_controller.dart';

class PresentationFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresentationFormController>(() => PresentationFormController());
  }
}
