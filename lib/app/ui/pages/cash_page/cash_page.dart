import 'package:facturadorpro/app/ui/widgets/loading_more_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/api/models/response/cash_model.dart';
import 'package:facturadorpro/app/ui/widgets/empty_page.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/cash/cash_controller.dart';
import 'package:facturadorpro/app/ui/pages/cash_page/widgets/cash_list_tile.dart';

class CashPage extends GetView<CashController> {
  const CashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CashController _controller = Get.put(CashController());

    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () => _controller.filterCashBoxes(useLoader: false),
      child: Obx(() {
        if (controller.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }
        if (_controller.isLoading.value == false &&
            _controller.cashBoxes.isEmpty) {
          return const EmptyPage();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.cashBoxes.length,
                padding: EdgeInsets.only(
                  bottom: controller.isLoadingMore.value == true ? 0 : 90.0,
                ),
                itemBuilder: (BuildContext _context, int index) {
                  CashItemModel item = controller.cashBoxes[index];
                  return CashListTile(item: item);
                },
              ),
            ),
            if (controller.isLoadingMore.value == true) LoadingMoreProgress(),
          ],
        );
      }),
    );
  }
}
