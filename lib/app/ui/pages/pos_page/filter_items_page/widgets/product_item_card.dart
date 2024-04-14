import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/filter_items_page/widgets/details_item.dart';

class ProductItemCard extends GetView<PosController> {
  const ProductItemCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    ItemPos itemPos = controller.items[index];
    return Container(
      height: 355,
      margin: EdgeInsets.only(bottom: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              '${itemPos.imageUrl}',
              height: 200,
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${itemPos.description}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      spaceH(12.0),
                      Row(
                        children: [
                          Text(
                            formatMoney(
                              quantity: double.parse(itemPos.auxSaleUnitPrice),
                              decimalDigits: 2,
                              symbol: "S/ ",
                            ),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Kdam",
                            ),
                          ),
                          spaceW(4),
                          Text(
                            "x ${itemPos.unitTypeId}",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: textColor.shade200,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  double stock = 0;
                  ItemPos item = controller.items.value[index];
                  if (item.stock != null) {
                    stock = double.parse(item.stock!);
                  }
                  /*if (stock <= 0) {
                    return Container(
                      height: 54.0,
                      width: double.maxFinite,
                      child: Center(
                        child: Text(
                          'STOCK AGOTADO',
                          style: TextStyle(
                            color: Colors.red.shade500.withOpacity(.3),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  }*/
                  final foundItem = controller.itemsInCart.firstWhereOrNull(
                    (e) => e.itemId == itemPos.id,
                  );
                  if (foundItem != null) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.orange.shade600,
                          width: 1,
                        ),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      onPressed: () {
                        controller.onRemoveItemToCart(id: itemPos.id);
                      },
                      child: Container(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_shopping_cart_outlined,
                              size: 16.0,
                              color: Colors.orange.shade600,
                            ),
                            spaceW(8.0),
                            Text(
                              'QUITAR',
                              style: TextStyle(
                                color: Colors.orange.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(
                        color: primaryColor,
                        width: 1,
                      ),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    onPressed: () {
                      controller.resetToOneCounter();
                      Get.bottomSheet(
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: DetailsItem(itemPos: itemPos),
                        ),
                        backgroundColor: Colors.transparent,
                      );
                    },
                    child: Container(
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_shopping_cart_outlined,
                            size: 16.0,
                            color: primaryColor,
                          ),
                          spaceW(8.0),
                          Text(
                            'AGREGAR',
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
