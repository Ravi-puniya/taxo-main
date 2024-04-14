import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/sunat_voucher_controller.dart';

class ActionsFilterVoucher extends GetView<SunatVoucherController> {
  const ActionsFilterVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton.extended(
          elevation: 0,
          onPressed: controller.onClearFilters,
          label: Text(
            "LIMPIAR",
            style: TextStyle(
              color: Colors.grey.shade800,
            ),
          ),
          backgroundColor: Colors.grey.shade200,
          heroTag: null,
        ),
        const SizedBox(width: 12.0),
        FloatingActionButton.extended(
          elevation: 0,
          onPressed: () {
            FocusScope.of(context).unfocus();
            controller.saveOnPreviousValue();
            controller.filterVouchers();
            Get.back();
          },
          icon: const Icon(Icons.search, color: Colors.white),
          label: const Text(
            "BUSCAR",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: primaryColor,
          heroTag: null,
        ),
      ],
    );
  }
}
