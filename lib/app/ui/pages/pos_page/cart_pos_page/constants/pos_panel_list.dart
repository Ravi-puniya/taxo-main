import 'package:flutter/material.dart';

import 'package:facturadorpro/app/ui/models/custom_panel_model.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/payment_panel.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/general_panel.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/products_panel.dart';

List<CustomPanelModel> posPanelList = [
  CustomPanelModel(
    index: 0,
    title: "Información General",
    subtitle: Text("Comprobante, serie, cliente, moneda."),
    child: GeneralPanel(),
  ),
  CustomPanelModel(
    index: 1,
    title: "Productos",
    subtitle: Text("Listado de items agregados."),
    child: ProductPanel(),
  ),
  CustomPanelModel(
    index: 2,
    title: "Pagos",
    subtitle: Text("Modalidades de pago"),
    child: PaymentPanel(),
  ),
  /*CustomPanelModel(
    index: 3,
    title: "Descuentos",
    child: DiscountPanel(),
  ),*/
];
