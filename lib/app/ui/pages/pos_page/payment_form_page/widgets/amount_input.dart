import 'package:easy_debounce/easy_debounce.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/controllers/pos/payment_form_controller.dart';

class AmountInput extends GetView<PaymentFormController> {
  const AmountInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PosController posCnt = Get.put(PosController());

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextFormField(
        controller: controller.amountCnt,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
            ',',
            replacementString: '.',
          ),
          FilteringTextInputFormatter.allow(
            RegExp(r'(^\d*\.?\d{0,2})'),
          ),
        ],
        decoration: InputDecoration(
          labelText: "Monto",
          prefix: Text(posCnt.selectedCoin.value.symbol),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.only(
            left: 8.0,
            top: 8.0,
            bottom: 5.0,
          ),
        ),
        onTap: () {
          controller.amountCnt.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller.amountCnt.value.text.length,
          );
        },
        onChanged: (value) {
          EasyDebounce.debounce(
            'quantity',
            Duration(milliseconds: 1000),
            () {
              String val = formatMoney(
                quantity: double.parse(value),
                decimalDigits: 2,
              );
              controller.amountCnt.text = val;
              controller.amountCnt.selection = TextSelection(
                baseOffset: 0,
                extentOffset: controller.amountCnt.value.text.length,
              );
            },
          );
        },
      ),
    );
  }
}
