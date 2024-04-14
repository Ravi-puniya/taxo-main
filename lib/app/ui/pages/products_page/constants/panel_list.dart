import 'package:facturadorpro/app/ui/models/custom_panel_model.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/general_panel/general_panel.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/purchase_panel/purchase_panel.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/presentations_panel.dart';
import 'package:facturadorpro/app/ui/pages/products_page/widgets/atributes_panel/attributes_panel.dart';

List<CustomPanelModel> panelList = [
  CustomPanelModel(
    index: 0,
    title: "General",
    child: GeneralPanel(),
  ),
  CustomPanelModel(
    index: 1,
    title: "Presentaciones",
    child: PresentationsPanel(),
  ),
  CustomPanelModel(
    index: 2,
    title: "Atributos",
    child: AttributesPanel(),
  ),
  CustomPanelModel(
    index: 3,
    title: "Compra",
    child: PurchasePanel(),
  ),
];
