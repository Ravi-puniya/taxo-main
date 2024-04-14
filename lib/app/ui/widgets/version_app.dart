import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/version_controller.dart';

class VersionApp extends GetView<VersionController> {
  const VersionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: Text(
          'Versión ${controller.version.value}',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 11.0,
          ),
        ),
      );
    });
  }
}
