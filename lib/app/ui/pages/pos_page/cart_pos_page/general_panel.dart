import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/widgets/money_filter.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/widgets/series_filter.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/widgets/client_filter.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/widgets/exchange_input.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/widgets/invoice_type_filter.dart';

class GeneralPanel extends GetView<PosController> {
  const GeneralPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: InvoiceTypeFilter(),
              ),
              spaceW(12),
              Flexible(
                flex: 1,
                child: SeriesFilter(),
              ),
            ],
          ),
          spaceH(12),
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: ClientFilter(),
              ),
              spaceW(12),
              SizedBox(
                height: 45,
                child: TextButton(
                  child: new Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Get.toNamed(
                      Routes.ADD_CLIENT,
                      arguments: "POS:",
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor.shade50,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(() {
            if (controller.clientValidation.value.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH(8),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      controller.clientValidation.value,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          }),
          spaceH(12),
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: MoneyFilter(),
              ),
              spaceW(12),
              Flexible(
                flex: 1,
                child: ExchangeInput(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
