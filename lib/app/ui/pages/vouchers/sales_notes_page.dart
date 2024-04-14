import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/constants.dart';
import 'package:facturadorpro/app/ui/widgets/empty_page.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/api/models/sale_note_response_model.dart';
import 'package:facturadorpro/app/controllers/sales_note_controller.dart';
import 'package:facturadorpro/app/ui/pages/vouchers/_widgets/sale_note_item_card.dart';

class SaleNotesPage extends StatelessWidget {
  const SaleNotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SaleNotesController controller = Get.put(SaleNotesController());

    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () => controller.filterSaleNotes(useLoader: false),
      child: Obx(() {
        bool isLoading = controller.isLoading.value;
        if (controller.isLoading.value == true) {
          return const Center(
            child: CircularProgressIndicator(color: primaryColor),
          );
        }
        if (!isLoading && controller.saleNotes.isEmpty) {
          return EmptyPage();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.saleNotes.length,
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: controller.isLoadingMore.value == true ? 0 : 90.0,
                ),
                itemBuilder: (BuildContext _context, int index) {
                  return Obx(() {
                    SaleNote saleNote = controller.saleNotes.value[index];
                    return SaleNoteItemCard(
                      voucher: saleNote,
                      onTap: () {
                        controller.onShowOptionsPressed(
                          id: saleNote.id,
                          context: context,
                        );
                      },
                      canCancel: ![ANULADO].contains(saleNote.stateTypeId),
                    );
                  });
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
