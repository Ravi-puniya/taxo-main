import 'package:facturadorpro/shared/environment.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:facturadorpro/api/providers/remote_services.dart';
import 'package:facturadorpro/app/routes/app_routes.dart';

class ValidateDomainController extends GetxController {
  TextEditingController domainCnt = TextEditingController();
  RxBool isUrl = false.obs;
  RxBool isLoading = false.obs;
  RxBool isComplete = false.obs;

  RxString validateDomainText = ''.obs;
  RxBool success = false.obs;

  GetStorage box = GetStorage();

  @override
  void onInit() async {
    await GetStorage.init();
    super.onInit();
    domainCnt.text = (box.read('domain') == null) ? 'demo' : box.read('domain');
    isUrl.value = (domainCnt.text.isNotEmpty) ? true : false;
    validateDomainText.value = domainCnt.text;
  }

  validateUrl() async {
    try {
      isLoading(true);
      String link =
          "https://${domainCnt.text.trim()}.${Environment.businessDomain}";
      var auth = await RemoteServices.fetchAuth(
        '',
        '',
        "${link}/api/login",
      );
      if (auth != null) {
        success(true);
      } else {
        success(false);
      }
      isLoading.value = true;

      if ((Uri.parse(link).host.isNotEmpty && success.value)) {
        isUrl.value = true;
        isLoading(false);

        box.write('domain', link);
        domainCnt.text = '';
        Get.toNamed(Routes.AUTH);
      } else {
        displayWarningMessage(message: "Error al establecer conexión");
        isUrl.value = false;
        isLoading(false);
      }
    } catch (e) {
      print('Error: $e');
    } finally {}
  }
}
