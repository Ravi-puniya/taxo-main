import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/widgets/line_amount.dart';

class DetailsBottomPos extends GetView<PosController> {
  const DetailsBottomPos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final double height = MediaQuery.of(context).size.height;
      double fixedHeight = height * 0.42;
      bool isDetailed = controller.isActivedDetailed.value;
      if (!isDetailed) {
        fixedHeight = height * 0.25;
      }
      bool enabledButton = controller.itemsInCart.length > 0 &&
          controller.clientValidation.isEmpty;
      return Container(
        height: fixedHeight,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text("Mostrar todos los detalles"),
                Spacer(),
                Switch(
                  value: controller.isActivedDetailed.value,
                  onChanged: (bool active) {
                    controller.onChangeActiveDetails(active: active);
                  },
                ),
              ],
            ),
            if (isDetailed)
              LineAmount(
                label: "SUBTOTAL",
                amount: controller.calculateSubtotal,
                symbolCoin: controller.selectedCoin.value.symbol,
                spaceBottom: 4.0,
              ),
            if (isDetailed)
              LineAmount(
                label: "IGV",
                amount: formatMoney(
                  quantity: controller.calculateTotalTaxes,
                  decimalDigits: 2,
                  symbol: controller.selectedCoin.value.symbol,
                ),
                symbolCoin: controller.selectedCoin.value.symbol,
                spaceBottom: 4.0,
              ),
            if (isDetailed) Divider(height: 8),
            if (isDetailed)
              LineAmount(
                label: "TOTAL",
                amount: controller.calculateTotal,
                symbolCoin: controller.selectedCoin.value.symbol,
                spaceBottom: 8.0,
                spaceTop: 8,
              ),
            if (isDetailed)
              LineAmount(
                label: "REDONDEO",
                amount: formatMoney(
                  quantity: controller.calculateRounded,
                  decimalDigits: 2,
                  symbol: controller.selectedCoin.value.symbol,
                ),
                symbolCoin: controller.selectedCoin.value.symbol,
                spaceBottom: 8.0,
              ),
            if (isDetailed) Divider(height: 8),
            LineAmount(
              label: "TOTAL A PAGAR",
              amount: formatMoney(
                quantity: controller.calculateTotalToPay,
                symbol: controller.selectedCoin.value.symbol,
                decimalDigits: 2,
              ),
              symbolCoin: controller.selectedCoin.value.symbol,
              spaceBottom: 0.0,
              spaceTop: 8,
              isBold: true,
            ),
            LineAmount(
              label: "VUELTO",
              amount: controller.calculateReturnClient,
              symbolCoin: controller.selectedCoin.value.symbol,
              spaceBottom: 16.0,
              spaceTop: 8,
              isBold: true,
              textColor: primaryColor,
            ),
            Spacer(),
            SizedBox(
              width: double.maxFinite,
              height: 44.0,
              child: OutlinedButton(
                onPressed: enabledButton
                    ? () async => await controller.onSaveSale(context)
                    : null,
                child: Text(
                  "FINALIZAR VENTA",
                  style: TextStyle(
                    color: enabledButton ? Colors.white : Colors.grey.shade500,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: enabledButton ? primaryColor : Colors.grey,
                  shape: const StadiumBorder(),
                  backgroundColor:
                      enabledButton ? primaryColor : Colors.grey.shade300,
                  side: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
