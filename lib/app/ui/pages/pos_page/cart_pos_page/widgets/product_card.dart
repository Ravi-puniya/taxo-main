import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:easy_debounce/easy_debounce.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/models/items_in_cart_model.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/ui/widgets/bottom_sheet_top_line.dart';
import 'package:facturadorpro/api/models/response/filtered_item_pos_model.dart';

class ProductCard extends GetView<PosController> {
  const ProductCard({
    Key? key,
    required this.product,
    required this.priceCnt,
    required this.qntCnt,
    required this.index,
  }) : super(key: key);

  final ItemsInCartModel product;
  final TextEditingController priceCnt;
  final TextEditingController qntCnt;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  '${product.item.imageUrl}',
                  height: 60.0,
                  width: 60.0,
                  fit: BoxFit.cover,
                ),
              ),
              spaceW(8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      product.item.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                    ),
                  ),
                  spaceH(8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product.unitTypeId,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (product.item.unitType.length > 0)
                        Row(
                          children: [
                            spaceW(8),
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    height: double.infinity,
                                    child: Column(
                                      children: [
                                        spaceH(16),
                                        BottomSeetTopLine(),
                                        Expanded(
                                          child: ListView.separated(
                                            separatorBuilder: (_, __) =>
                                                SizedBox(height: 12),
                                            itemCount:
                                                product.item.unitType.length,
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (_, idx) {
                                              Presentation p =
                                                  product.item.unitType[idx];
                                              double price1 =
                                                  double.parse(p.price1);
                                              double price2 =
                                                  double.parse(p.price2);
                                              double price3 =
                                                  double.parse(p.price3);
                                              return Container(
                                                padding: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4,
                                                      spreadRadius: 1,
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      p.description,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    spaceH(16),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text("Precio 1"),
                                                            spaceH(8),
                                                            TextButton(
                                                              onPressed:
                                                                  price1 > 0
                                                                      ? () {
                                                                          controller
                                                                              .onChangePresentation(
                                                                            index:
                                                                                index,
                                                                            price:
                                                                                price1,
                                                                            presentation:
                                                                                p,
                                                                          );
                                                                        }
                                                                      : null,
                                                              child: Text(
                                                                formatMoney(
                                                                  quantity:
                                                                      double
                                                                          .parse(
                                                                    p.price1,
                                                                  ),
                                                                  decimalDigits:
                                                                      2,
                                                                  symbol: "S/",
                                                                ),
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              style: TextButton
                                                                  .styleFrom(
                                                                foregroundColor: price1 >
                                                                        0
                                                                    ? primaryColor
                                                                    : Colors
                                                                        .grey,
                                                                backgroundColor: price1 >
                                                                        0
                                                                    ? primaryColor
                                                                        .shade50
                                                                    : Colors
                                                                        .grey
                                                                        .shade50,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Column(
                                                          children: [
                                                            Text("Precio 2"),
                                                            spaceH(8),
                                                            TextButton(
                                                              onPressed:
                                                                  price2 > 0
                                                                      ? () {
                                                                          controller
                                                                              .onChangePresentation(
                                                                            index:
                                                                                index,
                                                                            price:
                                                                                price2,
                                                                            presentation:
                                                                                p,
                                                                          );
                                                                        }
                                                                      : null,
                                                              child: Text(
                                                                formatMoney(
                                                                  quantity:
                                                                      double
                                                                          .parse(
                                                                    p.price2,
                                                                  ),
                                                                  decimalDigits:
                                                                      2,
                                                                  symbol: "S/",
                                                                ),
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              style: TextButton
                                                                  .styleFrom(
                                                                foregroundColor: price2 >
                                                                        0
                                                                    ? primaryColor
                                                                    : Colors
                                                                        .grey,
                                                                backgroundColor: price2 >
                                                                        0
                                                                    ? primaryColor
                                                                        .shade50
                                                                    : Colors
                                                                        .grey
                                                                        .shade50,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Spacer(),
                                                        Column(
                                                          children: [
                                                            Text("Precio 3"),
                                                            spaceH(8),
                                                            TextButton(
                                                              onPressed:
                                                                  price3 > 0
                                                                      ? () {
                                                                          controller
                                                                              .onChangePresentation(
                                                                            index:
                                                                                index,
                                                                            price:
                                                                                price3,
                                                                            presentation:
                                                                                p,
                                                                          );
                                                                        }
                                                                      : null,
                                                              child: Text(
                                                                formatMoney(
                                                                  quantity:
                                                                      double
                                                                          .parse(
                                                                    p.price3,
                                                                  ),
                                                                  decimalDigits:
                                                                      2,
                                                                  symbol: "S/",
                                                                ),
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              style: TextButton
                                                                  .styleFrom(
                                                                foregroundColor: price3 >
                                                                        0
                                                                    ? primaryColor
                                                                    : Colors
                                                                        .grey,
                                                                backgroundColor: price3 >
                                                                        0
                                                                    ? primaryColor
                                                                        .shade50
                                                                    : Colors
                                                                        .grey
                                                                        .shade50,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.grey.shade200,
                                );
                              },
                              child: Text(
                                "Cambiar",
                                style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (product.item.hasPlasticBagTaxes)
                        Row(
                          children: [
                            spaceW(12),
                            Text(
                              "|",
                              style: TextStyle(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            spaceW(12),
                          ],
                        ),
                      if (product.item.hasPlasticBagTaxes)
                        Tooltip(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          message:
                              "x Item: ${controller.getIcbperItem(id: product.item.id)} \nSubtotal: ${controller.getIcbperItemQnt(id: product.item.id)}",
                          triggerMode: TooltipTriggerMode.tap,
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green.shade500,
                                size: 16,
                              ),
                              spaceW(4),
                              Text(
                                "ICBPER",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          spaceH(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: TextFormField(
                  controller: priceCnt,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                      ',',
                      replacementString: '.',
                    ),
                    FilteringTextInputFormatter.allow(
                      RegExp(r'(^\d*\.?\d{0,2})'),
                    ),
                  ],
                  onTap: () {
                    priceCnt.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: priceCnt.value.text.length,
                    );
                  },
                  // readOnly: !product.item.calculateQuantity,
                  onChanged: (String value) {
                    EasyDebounce.debounce(
                      'quantity',
                      Duration(milliseconds: 1000),
                      () {
                        String val = formatMoney(
                          quantity: double.parse(value),
                          decimalDigits: 2,
                        );
                        controller.onChangePriceItem(
                          price: double.parse(val.replaceAll(",", "")),
                          id: product.itemId,
                        );
                        priceCnt.text = val;
                        priceCnt.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: priceCnt.value.text.length,
                        );
                      },
                    );
                  },
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Kdam",
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                    prefix: Text(
                      "${controller.selectedCoin.value.symbol}",
                      style: TextStyle(fontFamily: "kdam"),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.putAmountToCart(
                      quantity: -1,
                      id: product.itemId,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        color: product.quantity - 1 < 1
                            ? Colors.grey.shade50
                            : Colors.white,
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 16.0,
                        color: product.quantity - 1 < 1
                            ? Colors.grey.shade200
                            : null,
                      ),
                    ),
                  ),
                  Container(
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: qntCnt,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d*'),
                        ),
                      ],
                      onTap: () {
                        qntCnt.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: qntCnt.value.text.length,
                        );
                      },
                      onChanged: (String value) {
                        EasyDebounce.debounce(
                          'quantity',
                          Duration(milliseconds: 1000),
                          () {
                            controller.onChangedQuantityItem(
                              quantity: double.parse(value),
                              id: product.itemId,
                            );
                          },
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
                    onTap: () => controller.putAmountToCart(
                      quantity: 1,
                      id: product.itemId,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.add, size: 16.0),
                    ),
                  ),
                  spaceW(16),
                  Obx(() {
                    bool disabled = controller.itemsInCart.value.length == 1;
                    return GestureDetector(
                      onTap: !disabled
                          ? () {
                              controller.onRemoveItemToCart(
                                id: product.itemId,
                              );
                            }
                          : null,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: disabled
                                ? Colors.grey.shade200
                                : Colors.red.shade200,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.delete,
                          size: 16.0,
                          color: disabled
                              ? Colors.grey.shade400
                              : Colors.red.shade500,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
