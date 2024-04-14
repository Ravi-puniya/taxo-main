import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/api/models/client_model.dart';
import 'package:facturadorpro/app/ui/widgets/empty_page.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/client/client_controller.dart';
import 'package:facturadorpro/app/ui/pages/client_page/widgets/client_item_card.dart';

class ClientPage extends GetView<ClientController> {
  const ClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClientController _controller = Get.put(ClientController());

    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () => _controller.filterClients(useLoader: false),
      child: Obx(() {
        if (controller.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }
        if (controller.isLoading.value == false && controller.clients.isEmpty) {
          return const EmptyPage();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.clients.length,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                itemBuilder: (BuildContext _context, int index) {
                  ClientData client = controller.clients[index];
                  return ClientItemCard(client: client);
                },
              ),
            ),
            if (controller.isLoadingMore.value == true)
              Container(
                height: 40.0,
                color: Colors.white,
                width: double.infinity,
                child: const Center(
                  child: SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 2.0,
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
