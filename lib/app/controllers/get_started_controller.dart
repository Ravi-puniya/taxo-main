import 'package:get/get.dart';

import 'package:facturadorpro/app/routes/app_routes.dart';

class GetStartedController extends GetxController {
  navigatorAuthPage() {
    Get.toNamed(Routes.AUTH);
  }

  navigatorValidateDomain() {
    Get.toNamed(Routes.VALIDATE_DOMAIN);
  }
}
