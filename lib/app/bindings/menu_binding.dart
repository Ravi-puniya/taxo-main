import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/menu_controller.dart' as menu_controller;
import 'package:facturadorpro/app/controllers/version_controller.dart';

class MenuBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<menu_controller.MenuControllers>(() => menu_controller.MenuControllers());
    Get.lazyPut<VersionController>(() => VersionController());
  }
}
