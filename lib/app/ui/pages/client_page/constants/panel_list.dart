import 'package:facturadorpro/app/ui/models/custom_panel_model.dart';
import 'package:facturadorpro/app/ui/pages/client_page/widgets/address_data_panel.dart';
import 'package:facturadorpro/app/ui/pages/client_page/widgets/general_data_panel.dart';
import 'package:facturadorpro/app/ui/pages/client_page/widgets/other_data_panel.dart';

List<CustomPanelModel> panelList = [
  CustomPanelModel(
    index: 0,
    title: "Datos del cliente",
    child: GeneralDataPanel(),
  ),
  CustomPanelModel(
    index: 1,
    title: "Dirección y contacto",
    child: AddressDataPanel(),
  ),
  CustomPanelModel(
    index: 2,
    title: "Otros datos",
    child: OtherDataPanel(),
  ),
];
