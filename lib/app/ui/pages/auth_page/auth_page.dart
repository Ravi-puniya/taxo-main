import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/version_app.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/controllers/auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH(screenSize.height * 0.05),
              SizedBox(
                width: screenSize.width * 0.50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: StadiumBorder(),
                  ),
                  onPressed: () => controller.logout(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                      ),
                      spaceW(8),
                      Text(
                        'Cambiar Dominio',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              spaceH(25),
              const Text(
                'Bienvenido',
                style: TextStyle(
                  color: Color(0xff212529),
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
              spaceH(8),
              const Text(
                'Ingresa tus credenciales para continuar',
                style: TextStyle(
                  color: Color(0xff545E64),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              const Text(
                'Correo electrónico',
                style: TextStyle(
                  color: Color(0xff545E64),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              spaceH(10),
              Container(
                color: Colors.white,
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
                    focusNode: controller.emailNode,
                    autofocus: true,
                    validator: (String? value) =>
                        EmailValidator.validate(value!)
                            ? null
                            : 'Correo electrónico no válido',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              spaceH(20),
              const Text(
                'Contraseña',
                style: TextStyle(
                    color: Color(0xff545E64),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              spaceH(10),
              Container(
                color: Colors.white,
                child: Obx(
                  () => TextField(
                    focusNode: controller.passwordNode,
                    controller: controller.passwordController,
                    obscureText: !controller.passwordVisibility.value,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.passwordVisibility.value =
                                !controller.passwordVisibility.value;
                          },
                          icon: (controller.passwordVisibility.value)
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                    ),
                  ),
                ),
              ),
              spaceH(5),
              Spacer(),
              SizedBox(
                height: 45,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: !controller.isLoading.value
                        ? controller.fetchAuth
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    child: Center(
                      child: !controller.isLoading.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'CONTINUAR',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    // letterSpacing: 1.5,
                                  ),
                                ),
                                spaceW(10),
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            )
                          : const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              spaceH(20),
              VersionApp(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget spaceH(double height) {
    return SizedBox(height: height);
  }
}
