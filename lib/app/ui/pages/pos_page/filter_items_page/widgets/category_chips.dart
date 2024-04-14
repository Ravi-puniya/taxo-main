import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/widgets/small_loader.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';

class CategoryChips extends GetView<PosController> {
  const CategoryChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: double.maxFinite,
      child: Obx(() {
        if (controller.isLoadingParams.value == true) {
          return SmallLoader(size: 20);
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            physics: const ClampingScrollPhysics(),
            itemCount: controller.categories.length,
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisExtent: 116.0,
              mainAxisSpacing: 12.0,
            ),
            itemBuilder: (_, index) {
              final category = controller.categories[index];
              return Obx(() {
                final selectedCategory = controller.selectedCategory.value;
                bool isSelected = selectedCategory.id == category.id;
                return GestureDetector(
                  onTap: () => controller.onSelectCategory(category: category),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category.name.toUpperCase(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        );
      }),
    );
  }
}
