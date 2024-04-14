import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/constants.dart';
import 'package:facturadorpro/app/ui/widgets/empty_page.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/api/models/voucher_response_model.dart';
import 'package:facturadorpro/app/controllers/sunat_voucher_controller.dart';
import 'package:facturadorpro/app/ui/pages/vouchers/_widgets/voucher_item_card.dart';

class VouchersPage extends StatelessWidget {
  const VouchersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SunatVoucherController controller = Get.put(SunatVoucherController());

    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () => controller.filterVouchers(useLoader: false),
      child: Obx(() {
        bool isLoading = controller.isLoading.value;
        if (controller.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }
        if (!isLoading && controller.vouchers.isEmpty) {
          return EmptyPage();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.vouchers.length,
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: controller.isLoadingMore.value == true ? 0 : 90.0,
                ),
                itemBuilder: (BuildContext _context, int index) {
                  Voucher voucher = controller.vouchers[index];
                  return VoucherItemCard(
                    voucher: voucher,
                    onTap: () {
                      controller.onShowOptionsPressed(
                        id: voucher.id,
                        context: context,
                      );
                    },
                    canCancel: [ACEPTADO].contains(voucher.stateTypeId),
                  );
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
