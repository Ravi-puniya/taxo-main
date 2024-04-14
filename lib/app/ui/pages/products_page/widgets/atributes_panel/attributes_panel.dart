import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/controllers/product/product_form_controller.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/atributes_panel/widgets/brand_selector.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/atributes_panel/widgets/category_selector.dart';

class AttributesPanel extends GetView<ProductFormController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CategorySelector(),
          spaceH(16),
          BrandSelector(),
          spaceH(16),
        ],
      ),
    );
  }
}
