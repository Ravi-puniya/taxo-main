import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';

class ExchangeInput extends GetView<PosController> {
  const ExchangeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade200),
          color:
              controller.itemsInCart.length != 0 ? Colors.grey.shade50 : null,
        ),
        child: TextFormField(
          controller: controller.exchangeCnt,
          keyboardType: TextInputType.number,
          readOnly: true,
          decoration: InputDecoration(
            labelText: "Tipo de Cambio",
            border: InputBorder.none,
            isDense: true,
            suffixIcon: controller.isLoadingExchange.value
                ? Transform.scale(
                    scale: 0.3, child: CircularProgressIndicator())
                : IconButton(
                    onPressed: controller.getTodayExchangeRate,
                    icon: Icon(Icons.replay_outlined, size: 16.0),
                  ),
            contentPadding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 5.0),
          ),
        ),
      );
    });
  }
}
