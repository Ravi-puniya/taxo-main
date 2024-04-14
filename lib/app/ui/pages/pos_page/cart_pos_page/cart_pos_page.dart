import 'package:facturadorpro/app/ui/widgets/custom_expanded_panel_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:facturadorpro/app/ui/widgets/custom_expanded_panel.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/widgets/details_bottom.dart';
import 'package:facturadorpro/app/ui/pages/pos_page/cart_pos_page/constants/pos_panel_list.dart';

class CartPosPage extends GetView<PosController> {
  const CartPosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text("Detalle de venta"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => controller.onCancelSale(context: context),
            icon: Icon(
              Icons.delete_outline_rounded,
            ),
          ),
        ],
      ),
      // extendBody: true,
      bottomNavigationBar: DetailsBottomPos(),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      child: Obx(() {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
                          child: CustomExpansionPanelList(
                            expansionCallback: (int index, bool isExpanded) {
                              controller.onExpandedPanel(
                                index: index,
                                isExpanded: isExpanded,
                              );
                            },
                            children: posPanelList.map((e) {
                              // ignore: invalid_use_of_protected_member
                              bool isExpanded =
                                  controller.expandedPanels.value[e.index];
                              return CustomExpandedPanel(
                                index: e.index,
                                title: e.title,
                                subtitle: e.subtitle,
                                isExpanded: isExpanded,
                                bodyWidget: e.child,
                                context: context,
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
