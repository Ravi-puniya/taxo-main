import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/api/models/product_list_response_model.dart';
import 'package:facturadorpro/app/controllers/product/products_controller.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/product_bottom_sheet.dart';

class ProductCard extends GetView<ProductsController> {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return SwipeableTile.swipeToTriggerCard(
      color: Colors.white,
      shadow: BoxShadow(
        blurRadius: 8,
        spreadRadius: 2,
        color: Colors.grey.shade200,
      ),
      borderRadius: 8,
      horizontalPadding: 0,
      verticalPadding: 6,
      direction: SwipeDirection.horizontal,
      onSwiped: (direction) async {
        if (direction == SwipeDirection.startToEnd) {
          controller.onDeleteProduct(product: product);
        }
        if (direction == SwipeDirection.endToStart) {
          Get.toNamed(Routes.ADD_PRODUCT, arguments: product.id);
        }
      },
      backgroundBuilder: (context, direction, progress) {
        if (direction == SwipeDirection.startToEnd) {
          return AnimatedBuilder(
            animation: progress,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                color: progress.value > 0.4
                    ? Colors.red.shade600
                    : Colors.red.shade100,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 45.0),
                    child: Transform.scale(
                      scale: Tween<double>(
                        begin: 0.0,
                        end: 1.2,
                      )
                          .animate(
                            CurvedAnimation(
                              parent: progress,
                              curve: const Interval(
                                0.5,
                                1.0,
                                curve: Curves.linear,
                              ),
                            ),
                          )
                          .value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          ),
                          spaceW(8),
                          Text(
                            "ELIMINAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return AnimatedBuilder(
            animation: progress,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                color: progress.value > 0.4
                    ? Colors.blue.shade600
                    : Colors.blue.shade100,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 55.0),
                    child: Transform.scale(
                      scale: Tween<double>(
                        begin: 0.0,
                        end: 1.2,
                      )
                          .animate(
                            CurvedAnimation(
                              parent: progress,
                              curve: const Interval(
                                0.5,
                                1.0,
                                curve: Curves.linear,
                              ),
                            ),
                          )
                          .value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Colors.white,
                          ),
                          spaceW(8),
                          Text(
                            "EDITAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      key: UniqueKey(),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            Get.bottomSheet(
              ProductBottomSheet(product: product),
              isScrollControlled: true,
              ignoreSafeArea: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              backgroundColor: Colors.white,
            );
          },
          highlightColor: Colors.white,
          splashColor: primaryColor.shade100,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrlSmall),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                spaceW(12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.description,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                      ),
                      spaceH(4),
                      Row(
                        children: [
                          Text("Código: "),
                          Text(
                            product.barcode ?? "-",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              border: Border.all(
                                color: Colors.green.shade100,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              formatMoney(
                                quantity: double.parse(
                                  product.saleUnitPriceWithIgv.split("S/ ")[1],
                                ),
                                decimalDigits: 2,
                                symbol: "S/",
                              ),
                              style: TextStyle(
                                color: Colors.green.shade700,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
