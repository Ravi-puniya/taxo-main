import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/api/models/response/init_params_pos.dart';

import 'package:facturadorpro/app/controllers/product/product_form_controller.dart';

class PresentationsPanel extends GetView<ProductFormController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(() {
            if (controller.presentations.length == 0) {
              return DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(8),
                color: Colors.grey.shade300,
                dashPattern: [4, 4],
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.sentiment_neutral_outlined,
                        size: 60,
                        color: Colors.grey.shade300,
                      ),
                      spaceH(8),
                      Text(
                        "No se encontraron registros",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, __) => SizedBox(height: 16),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.presentations.length,
              itemBuilder: (BuildContext _context, int index) {
                final present = controller.presentations.value[index];
                CurrencyType? coin = controller.currencyTypeSelected.value;
                String price = "0";
                if (present.priceDefault == 1) price = present.price1;
                if (present.priceDefault == 2) price = present.price2;
                if (present.priceDefault == 3) price = present.price3;
                String defaultPrice = formatMoney(
                  quantity: double.parse(price),
                  decimalDigits: 2,
                  symbol: coin == null ? "S/" : coin.symbol,
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
                      Container(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Text(
                          present.description,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Spacer(),
                      Text(
                        defaultPrice,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Kdam",
                        ),
                      ),
                      spaceW(12),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          Get.toNamed(
                            Routes.PRESENTATION_FORM_PAGE,
                            arguments: index,
                          );
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: () async {
                          await controller.removePresentations(
                            index: index,
                            itemUnitType: present,
                          );
                        },
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red.shade500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
          spaceH(16),
          TextButton.icon(
            onPressed: () {
              Get.toNamed(Routes.PRESENTATION_FORM_PAGE);
            },
            icon: Icon(Icons.add, size: 18.0),
            label: Text("Añadir presentación"),
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              backgroundColor: primaryColor.withOpacity(.1),
            ),
          ),
          spaceH(8),
        ],
      ),
    );
  }
}
