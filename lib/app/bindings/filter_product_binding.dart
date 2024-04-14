import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/product/products_controller.dart';

class FilterProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(() => ProductsController());
  }
}
