import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/product/products_controller.dart';
import 'package:facturadorpro/app/controllers/product/product_form_controller.dart';

class ProductsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(() => ProductsController());
    Get.lazyPut<ProductFormController>(() => ProductFormController());
  }
}
