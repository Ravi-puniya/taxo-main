import 'package:facturadorpro/app/ui/widgets/custom_expanded_panel_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/ui/widgets/custom_alert.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/custom_expanded_panel.dart';
import 'package:facturadorpro/app/controllers/client/client_form_controller.dart';
import 'package:facturadorpro/app/ui/pages/client_page/constants/panel_list.dart';

class ClientFormPage extends GetView<ClientFormController> {
  const ClientFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Obx(() {
          if (controller.isLoadingParams == true ||
              controller.isRetrieving == true) {
            return Text("Cliente");
          }
          String t = controller.clientId.value != 0 ? "Editar" : "Registrar";
          return Text("$t cliente");
        }),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() {
        String action =
            controller.clientId.value != 0 ? "actualizar" : "registrar";
        if (controller.isLoadingParams.value == false) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                elevation: 0,
                onPressed: Get.back,
                label: Text(
                  "CANCELAR",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                  ),
                ),
                backgroundColor: Colors.grey.shade200,
                heroTag: null,
              ),
              const SizedBox(width: 12.0),
              FloatingActionButton.extended(
                elevation: 0,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (controller.documentTypeId.value.isNotEmpty &&
                      controller.docNumberCnt.text.isNotEmpty &&
                      controller.nameCnt.text.isNotEmpty) {
                    customAlert(
                      context: context,
                      title: "Confirmación",
                      message:
                          "¿Desea $action el cliente con la información proporcionada?",
                      okText: "Si, $action",
                      onOk: controller.isSaving == false
                          ? () async => await controller.onSaveClient(context)
                          : null,
                    );
                  } else {
                    displayWarningMessage(
                      message: "Ingrese los campos requeridos",
                      position: ToastGravity.TOP,
                    );
                  }
                },
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  "GUARDAR",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: primaryColor,
                heroTag: null,
              ),
            ],
          );
        }
        return SizedBox();
      }),
      body: SafeArea(
        child: Obx(() {
          bool displayLoading = controller.isLoadingParams.value == true ||
              controller.isRetrieving.value == true;
          if (displayLoading == true) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
                  child: CustomExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      controller.onExpandedPanel(
                        index: index,
                        isExpanded: isExpanded,
                      );
                    },
                    children: panelList.map((e) {
                      // ignore: invalid_use_of_protected_member
                      bool isExpanded =
                          controller.expandedPanels.value[e.index];
                      return CustomExpandedPanel(
                        index: e.index,
                        title: e.title,
                        isExpanded: isExpanded,
                        bodyWidget: e.child,
                        context: context,
                      );
                    }).toList(),
                  ),
                );
              }),
              SizedBox(height: 90.0),
            ],
          );
        }),
      ),
    );
  }
}
