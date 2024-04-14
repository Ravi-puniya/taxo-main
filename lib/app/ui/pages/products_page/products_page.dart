import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/api/models/product_list_response_model.dart';
import 'package:facturadorpro/app/ui/widgets/empty_page.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/product/products_controller.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/product_card.dart';

class ProductsPage extends GetView<ProductsController> {
  @override
  Widget build(BuildContext context) {
    ProductsController _controller = Get.put(ProductsController());

    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () => _controller.filterProducts(useLoader: false),
      child: Obx(() {
        if (controller.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }
        if (controller.isLoading.value == false &&
            controller.products.isEmpty) {
          return const EmptyPage();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.products.length,
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: controller.isLoadingMore.value == true ? 0 : 90.0,
                ),
                itemBuilder: (BuildContext _context, int index) {
                  ProductData product = controller.products[index];
                  return ProductCard(product: product);
                },
              ),
            ),
            if (controller.isLoadingMore.value == true)
              Container(
                height: 40.0,
                color: Colors.white,
                width: double.infinity,
                child: const Center(
                  child: SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 2.0,
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
