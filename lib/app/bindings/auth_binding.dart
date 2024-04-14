import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/auth_controller.dart';
import 'package:facturadorpro/app/controllers/version_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<VersionController>(() => VersionController());
  }
}
