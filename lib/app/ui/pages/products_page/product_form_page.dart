import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/widgets/custom_alert.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/custom_expanded_panel.dart';
import 'package:facturadorpro/app/ui/widgets/custom_expanded_panel_list.dart';
import 'package:facturadorpro/app/ui/pages/products_page/constants/panel_list.dart';
import 'package:facturadorpro/app/controllers/product/product_form_controller.dart';

class ProductFormPage extends GetView<ProductFormController> {
  const ProductFormPage({Key? key}) : super(key: key);

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
            return Text("Producto");
          }
          String t =
              controller.productId.value != null ? "Editar" : "Registrar";
          return Text("$t Producto");
        }),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() {
        String action =
            controller.productId.value != 0 ? "actualizar" : "registrar";
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
                  customAlert(
                    context: context,
                    title: "Confirmación",
                    message:
                        "¿Desea $action el cliente con la información proporcionada?",
                    okText: "Si, $action",
                    onOk: controller.isSaving == false
                        ? () async => await controller.onSaveProduct(context)
                        : null,
                  );
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
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
    );
  }
}
