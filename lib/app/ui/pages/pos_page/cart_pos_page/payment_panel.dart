import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/models/payment_pos_model.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/controllers/pos/payment_form_controller.dart';

class PaymentPanel extends GetView<PosController> {
  const PaymentPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PaymentFormController paymentCnt = Get.put(PaymentFormController());

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Obx(() {
            String payments = formatMoney(
              quantity: controller.calculateTotalPayments,
              decimalDigits: 2,
              symbol: controller.selectedCoin.value.symbol,
            );
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total recibido:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  payments,
                  style: TextStyle(
                    fontFamily: "Kdam",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          }),
          spaceH(4.0),
          Obx(() {
            String payments = formatMoney(
              quantity: controller.calculateLeftToPay,
              decimalDigits: 2,
              symbol: controller.selectedCoin.value.symbol,
            );
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Restante por pagar:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  payments,
                  style: TextStyle(
                    fontFamily: "Kdam",
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade600,
                  ),
                ),
              ],
            );
          }),
          spaceH(16.0),
          Obx(() {
            return ListView.separated(
              separatorBuilder: (_, __) => SizedBox(height: 16),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.selectedPayments.length,
              itemBuilder: (BuildContext _context, int index) {
                PaymentPosModel payment =
                    controller.selectedPayments.value[index];
                String payed = formatMoney(
                  quantity: double.parse(payment.payment.replaceAll(",", "")),
                  decimalDigits: 2,
                  symbol: controller.selectedCoin.value.symbol,
                );
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        payment.paymentMethod.description,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        payed,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Kdam",
                        ),
                      ),
                      spaceW(12),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () => paymentCnt.onClickEditionButton(
                          index: index,
                        ),
                        icon: Icon(
                          Icons.edit_outlined,
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: controller.selectedPayments.length > 1
                            ? () => paymentCnt.onClickDeleteButton(
                                  index: index,
                                )
                            : null,
                        icon: Icon(
                          Icons.delete,
                          color: controller.selectedPayments.length > 1
                              ? Colors.red.shade500
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
          spaceH(12),
          TextButton.icon(
            onPressed: paymentCnt.onClickAddButton,
            icon: Icon(Icons.add, size: 18.0),
            label: Text("Añadir pago "),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              backgroundColor: primaryColor.withOpacity(.1),
            ),
          ),
        ],
      ),
    );
  }
}
