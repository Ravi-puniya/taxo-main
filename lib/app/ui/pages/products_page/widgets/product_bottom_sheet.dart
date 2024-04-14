import 'package:flutter/material.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/empty_records.dart';
import 'package:facturadorpro/api/models/product_list_response_model.dart';

class ProductBottomSheet extends StatelessWidget {
  const ProductBottomSheet({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Detalles del producto"),
          backgroundColor: Colors.white,
          foregroundColor: textColor,
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
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
                    spaceH(12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .9,
                      child: Text(
                        product.description.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    spaceH(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0,
                          ),
                          margin: const EdgeInsets.only(top: 5.0),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.20),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "Precio: ${product.saleUnitPriceWithIgv}",
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (product.barcode != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5.0,
                            ),
                            margin: const EdgeInsets.only(
                              top: 5.0,
                              left: 5.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(product.barcode!),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH(16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "STOCK POR ALMACÉN",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (product.warehouses.length == 0) EmptyRecords(),
                  if (product.warehouses.length > 0)
                    ...product.warehouses.map((e) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo.withOpacity(0.15),
                          foregroundColor: Colors.indigo.shade600,
                          child:
                              const Icon(Icons.warehouse_rounded, size: 18.0),
                        ),
                        title: Text(
                          e.warehouseDescription,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          e.stock,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        dense: true,
                      );
                    }).toList(),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "PRECIOS POR ALMACÉN",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (product.itemWarehousePrices.length == 0) EmptyRecords(),
                  if (product.itemWarehousePrices.length > 0)
                    ...product.itemWarehousePrices.map((e) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo.withOpacity(0.15),
                          foregroundColor: Colors.indigo.shade600,
                          child: const Icon(Icons.attach_money, size: 18.0),
                        ),
                        title: Text(
                          e.description,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          formatMoney(
                            quantity: e.price,
                            decimalDigits: 2,
                            symbol: product.currencyTypeSymbol,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        dense: true,
                      );
                    }).toList(),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "PRESENTACIONES",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (product.itemUnitTypes.length == 0) EmptyRecords(),
                  if (product.itemUnitTypes.length > 0)
                    ...product.itemUnitTypes.map((e) {
                      String defaultPrice = "";
                      if (e.priceDefault == 1) defaultPrice = e.price1;
                      if (e.priceDefault == 2) defaultPrice = e.price2;
                      if (e.priceDefault == 3) defaultPrice = e.price3;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal.withOpacity(0.15),
                          foregroundColor: Colors.teal.shade600,
                          child: const Icon(
                            Icons.layers,
                            size: 16.0,
                          ),
                        ),
                        title: Text(
                          e.description,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          formatMoney(
                            quantity: double.parse(defaultPrice),
                            decimalDigits: 2,
                            symbol: product.currencyTypeSymbol,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        dense: true,
                      );
                    }).toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
