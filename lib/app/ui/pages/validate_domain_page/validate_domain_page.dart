import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/environment.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/widgets/version_app.dart';
import 'package:facturadorpro/app/controllers/validate_domain_controller.dart';

class ValidateDomainPage extends GetView<ValidateDomainController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'TA',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            fontSize: 36,
                            fontFamily: "Kdam",
                          ),
                        ),
                        TextSpan(
                          text: 'XO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontSize: 36,
                            fontFamily: "Kdam",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                spaceH(8),
                Center(
                  child: const Text(
                    'Ingrese la dirección de enlace de su negocio',
                    style: TextStyle(
                      color: Color(0xff545E64),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                spaceH(60),
                const Text(
                  'Enlace de conexión',
                  style: TextStyle(
                    color: Color(0xff545E64),
                    fontSize: 14,
                  ),
                ),
                spaceH(10),
                Container(
                  color: Colors.white,
                  child: Obx(() {
                    return TextField(
                      onChanged: (String? value) {
                        controller.validateDomainText.value = value ?? "";
                        controller.isUrl.value = true;
                      },
                      autofocus: true,
                      controller: controller.domainCnt,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        prefixIcon: TextButton(
                          child: Text("https://"),
                          onPressed: () {},
                        ),
                        prefixStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade500,
                        ),
                        border: OutlineInputBorder(),
                        errorText: !controller.isUrl.value &&
                                controller.domainCnt.text.isNotEmpty
                            ? "El enlace proporcionado no es válido"
                            : "",
                        suffixIcon: TextButton(
                          onPressed: () {},
                          child: Text(".${Environment.businessDomain}"),
                        ),
                      ),
                    );
                  }),
                ),
                spaceH(25),
                SizedBox(
                  height: 45,
                  child: Obx(() {
                    return ElevatedButton(
                      onPressed: controller.validateDomainText.value.isNotEmpty
                          ? controller.validateUrl
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      child: !controller.isLoading.value
                          ? const Center(
                              child: Text(
                              'VALIDAR',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ))
                          : const Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              ),
                            ),
                    );
                  }),
                ),
                spaceH(40),
                VersionApp(),
              ]),
        ),
      ),
    );
  }

  Widget spaceH(double height) {
    return SizedBox(height: height);
  }
}
