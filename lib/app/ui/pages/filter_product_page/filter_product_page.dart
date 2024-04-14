import 'package:facturadorpro/app/ui/pages/filter_product_page/widgets/due_date_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/controllers/product/products_controller.dart';
import 'package:facturadorpro/app/ui/pages/filter_product_page/widgets/product_field.dart';
import 'package:facturadorpro/app/ui/pages/filter_product_page/widgets/column_select_product.dart';
import 'package:facturadorpro/app/ui/pages/filter_product_page/widgets/actions_filter_product.dart';

class FilterProductPage extends GetView<ProductsController> {
  const FilterProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.saveOnPreviousValue();
    return WillPopScope(
      onWillPop: () async {
        // controller.resetPreviousValues();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Filtrar productos"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: textColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnSelectProduct(),
              ProductField(),
              DueDateSelector(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ActionsFilterProduct(),
      ),
    );
  }
}
