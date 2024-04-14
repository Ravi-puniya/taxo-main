import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/widgets/empty_page.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/ui/widgets/loading_more_progress.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/filter_items_page/widgets/category_chips.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/filter_items_page/widgets/product_item_card.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/filter_items_page/widgets/input_filter_item.dart';

class FilterItemsPage extends GetView<PosController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PosController());
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () => controller.filterItems(useLoader: false),
        child: Column(
          children: [
            InputFilterItem(),
            CategoryChips(),
            Expanded(
              child: ListView(
                controller: controller.scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 80.0),
                physics: const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.01,
                    ),
                    child: Obx(() {
                      if (controller.isLoading.value == true) {
                        return Container(
                          height: screenSize.height,
                          width: screenSize.width,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (controller.items.isEmpty) {
                        return EmptyPage();
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        physics: const ClampingScrollPhysics(),
                        itemCount: controller.items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 355,
                          mainAxisSpacing: screenSize.height * 0.01,
                          crossAxisSpacing: screenSize.height * 0.01,
                        ),
                        itemBuilder: (_, index) {
                          return ProductItemCard(index: index);
                        },
                      );
                    }),
                  ),
                  Obx(() {
                    if (controller.hasMorePages.value == false) {
                      return Container(
                        height: 80.0,
                        width: double.maxFinite,
                        child: Center(
                          child: Text(
                            "No hay más registros",
                            style: TextStyle(
                              color: textColor.shade200,
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox();
                  }),
                ],
              ),
            ),
            Obx(() {
              if (controller.isLoadingMore.value == true) {
                return LoadingMoreProgress(label: "Cargando...");
              }
              return SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
