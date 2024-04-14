import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/widgets/product_card.dart';

class ProductPanel extends GetView<PosController> {
  const ProductPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.itemsInCart.length == 0)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16.0),
                  Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey.shade100,
                    ),
                    child: Icon(
                      Icons.inbox,
                      color: Colors.grey.shade500,
                      size: 32.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Sin productos',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          if (controller.itemsInCart.length > 0)
            Container(
              child: ListView.separated(
                separatorBuilder: (_, __) => Divider(height: 10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: controller.itemsInCart.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    final qntCnt = controller.dynamicQntCnt[index];
                    final priceCnt = controller.dynamicPriceCnt[index];
                    // ignore: invalid_use_of_protected_member
                    final product = controller.itemsInCart.value[index];
                    return ProductCard(
                      product: product,
                      priceCnt: priceCnt,
                      qntCnt: qntCnt,
                      index: index,
                    );
                  });
                },
              ),
            ),
        ],
      );
    });
  }
}
