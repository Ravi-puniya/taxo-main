import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/ui/widgets/bottom_sheet_top_line.dart';
import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';

class DetailsItem extends GetView<PosController> {
  const DetailsItem({
    Key? key,
    required this.itemPos,
  }) : super(key: key);

  final ItemPos itemPos;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final quantityController = controller.quantityController;
    final priceController = controller.priceController;
    String price = formatMoney(
      quantity: double.parse(itemPos.saleUnitPrice),
      decimalDigits: 2,
      symbol: "S/ ",
    );

    double stock = 0.0;
    if (itemPos.isBarcode == true) {
      stock = 1;
    } else {
      if (itemPos.stock != null) {
        stock = double.parse(itemPos.stock!);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSeetTopLine(),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    '${itemPos.imageUrl}',
                    height: screenSize.height * 0.1,
                  ),
                ),
              ),
              spaceW(25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      //botton con el icono de editar
                      // GestureDetector(
                      //   onTap: () => controller.changeEditing(),
                      //   child: Container(
                      //     margin: EdgeInsets.only(right: 8),
                      //     padding: EdgeInsets.all(8),
                      //     child: Icon(Icons.edit, size: 16.0),
                      //   ),
                      // ),

                      Obx(() {
                        bool isEditing = controller.isEditing.value;
                        if (isEditing) {
                          //return a  simple textfield
                          return Container(
                            width: 100,
                            child: TextField(
                              onSubmitted: (String value) {},
                              controller: priceController,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                                signed: false,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d*')),
                              ],
                              style: TextStyle(
                                fontSize: 20,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Kdam",
                              ),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(8.0),
                              ),
                            ),
                          );
                        }
                        return Text(
                          '$price',
                          style: TextStyle(
                            fontSize: 20,
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Kdam",
                          ),
                        );
                      }),
                      spaceW(6.0),
                      Text(
                        'x ${itemPos.unitTypeId}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: textColor.shade200,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Kdam",
                        ),
                      )
                    ],
                  ),
                  Text(
                    'COD: ${itemPos.internalId ?? "-"}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: textColor.shade300,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Kdam",
                    ),
                  )
                ],
              ),
            ],
          ),
          spaceH(16),
          Text(
            "${itemPos.description.toUpperCase()}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 2,
          ),
          spaceH(25),
          Text(
            'Cantidad:',
            style: TextStyle(
              color: textColor.shade300,
              fontWeight: FontWeight.w500,
            ),
          ),
          spaceH(10),
          Row(
            children: [
              Obx(() {
                bool displayButton = controller.showLessButton.value;
                return GestureDetector(
                  onTap: displayButton == false
                      ? null
                      : () => controller.putAmountToCart(quantity: -1),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8.0),
                      color: displayButton == false
                          ? Colors.grey.shade50
                          : Colors.white,
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 16.0,
                      color:
                          displayButton == false ? Colors.grey.shade200 : null,
                    ),
                  ),
                );
              }),
              Container(
                width: 70.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                  ],
                  onTap: () => quantityController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: quantityController.value.text.length,
                  ),
                  onChanged: (String value) {
                    EasyDebounce.debounce(
                      'quantity',
                      Duration(milliseconds: 1000),
                      () => controller.onChangedQuantityItem(
                        quantity: double.parse(value),
                      ),
                    );
                  },
                  style: TextStyle(fontSize: 14.0),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.putAmountToCart(quantity: 1),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: Icon(Icons.add, size: 16.0),
                ),
              ),
              spaceW(20),
              Text(
                itemPos.isBarcode == false
                    ? "${stock > 0 ? stock.toStringAsFixed(0) : 0} disponible"
                    : "No disponible por escáner.",
                style: TextStyle(
                  color: itemPos.isBarcode == false
                      ? textColor.shade300
                      : textColor.shade100,
                ),
              ),
            ],
          ),
          spaceH(25),
          Container(
            height: 30,
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              // onPressed: (() => _controllerGeneral.addItemCart()),
              onPressed: () {
                controller.onAddItemToCart(item: itemPos);
                Get.back();
              },
              child: Container(
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_shopping_cart_outlined,
                      size: 16.0,
                      color: Colors.white,
                    ),
                    spaceW(8.0),
                    Text(
                      'AGREGAR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
