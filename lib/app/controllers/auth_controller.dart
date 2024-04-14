import 'package:facturadorpro/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/api/providers/remote_services.dart';

class AuthController extends GetxController {
  RxString domain = ''.obs;
  GetStorage box = GetStorage();

  RxBool isLoading = false.obs;
  RxBool success = false.obs;
  RxBool incorrect = false.obs;
  RxBool passwordVisibility = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  void onInit() async {
    await GetStorage.init('domain');
    domain.value = (box.read('domain') == null) ? '' : box.read('domain');
    emailController.value = TextEditingValue(text: 'demo@facturaperu.com.pe');
    passwordController.value = TextEditingValue(text: '123456');
    super.onInit();
  }

  void fetchAuth() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      if (emailController.value.text.isNotEmpty &&
          passwordController.value.text.isNotEmpty) {
        isLoading(true);
        var auth = await RemoteServices.fetchAuth(
          emailController.text,
          passwordController.text,
          "${domain.value}/api/login",
        );
        if (auth != null) {
          success(auth.success);
          if (auth.success!) {
            box.write('token', auth.token);
            box.write('success', true);
            incorrect(false);
            Get.offAllNamed(Routes.MENU);
          } else {
            incorrect(true);
            Fluttertoast.showToast(
              msg: "Datos incorrectos",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xffF67878),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      } else {
        if (emailController.value.text.isEmpty) emailNode.requestFocus();
        if (passwordController.value.text.isEmpty) passwordNode.requestFocus();
        displayWarningMessage(message: "Por favor ingresa las credenciales");
      }
    } finally {
      isLoading(false);
    }
  }

  navigationMenuPage() {
    Get.offAllNamed(Routes.MENU);
  }

  void logout() {
    box.erase(); // Elimina todas las entradas almacenadas en GetStorage
    Get.offAllNamed(Routes.VALIDATE_DOMAIN);
  }
}
