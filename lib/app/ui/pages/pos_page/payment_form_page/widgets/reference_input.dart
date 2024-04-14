import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/pos/payment_form_controller.dart';

class ReferenceInput extends GetView<PaymentFormController> {
  const ReferenceInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextFormField(
        controller: controller.referenceCnt,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Código de referencia",
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.only(
            left: 8.0,
            top: 8.0,
            bottom: 5.0,
          ),
        ),
      ),
    );
  }
}
