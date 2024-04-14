import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/version_controller.dart';
import 'package:facturadorpro/app/controllers/validate_domain_controller.dart';

class ValidateDomainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValidateDomainController>(() => ValidateDomainController());
    Get.lazyPut<VersionController>(() => VersionController());
  }
}
