import 'package:facturadorpro/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

import 'package:facturadorpro/shared/mapping.dart';
import 'package:facturadorpro/shared/string_ext.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/models/voucher_types_model.dart';
import 'package:facturadorpro/app/ui/models/voucher_states_model.dart';
import 'package:facturadorpro/api/models/sale_note_response_model.dart';
import 'package:facturadorpro/app/controllers/sales_note_controller.dart';

class SaleNoteItemCard extends GetView<SaleNotesController> {
  const SaleNoteItemCard({
    Key? key,
    required this.voucher,
    required this.onTap,
    this.canCancel = false,
  }) : super(key: key);

  final SaleNote voucher;
  final VoidCallback onTap;
  final bool canCancel;

  @override
  Widget build(BuildContext context) {
    VoucherTypesModel letter = vouchersLetter.firstWhere(
      (e) => e.voucherId == "80",
    );
    VoucherStatesModel state = voucherStates.firstWhere((e) {
      if (voucher.stateTypeId != ANULADO) {
        return e.stateId == "P";
      } else {
        return e.stateId == voucher.stateTypeId;
      }
    });
    return SwipeableTile.swipeToTriggerCard(
      color: Colors.white,
      shadow: BoxShadow(
        blurRadius: 8,
        spreadRadius: 2,
        color: Colors.grey.shade200,
      ),
      borderRadius: 8,
      horizontalPadding: 0,
      verticalPadding: 6,
      direction: canCancel ? SwipeDirection.startToEnd : SwipeDirection.none,
      onSwiped: (direction) async {
        if (direction == SwipeDirection.startToEnd) {
          await controller.onNullifySaleNote(id: voucher.id);
        }
      },
      backgroundBuilder: (context, direction, progress) {
        if (direction == SwipeDirection.startToEnd) {
          return AnimatedBuilder(
            animation: progress,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                color: progress.value > 0.4
                    ? Colors.red.shade600
                    : Colors.red.shade100,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 45.0),
                    child: Transform.scale(
                      scale: Tween<double>(
                        begin: 0.0,
                        end: 1.2,
                      )
                          .animate(
                            CurvedAnimation(
                              parent: progress,
                              curve: const Interval(
                                0.5,
                                1.0,
                                curve: Curves.linear,
                              ),
                            ),
                          )
                          .value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          ),
                          spaceW(8),
                          Text(
                            "ANULAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return SizedBox();
      },
      key: UniqueKey(),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          highlightColor: Colors.white,
          splashColor: primaryColor.shade100,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: letter.backgroundColor,
                    border: Border.all(color: letter.borderColor),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      voucher.fullNumber.characters.elementAt(0),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: letter.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                spaceW(12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            voucher.fullNumber,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 12,
                                  color: Colors.grey.shade700,
                                ),
                                spaceW(4),
                                Text(
                                  voucher.dateOfIssue,
                                  style: TextStyle(
                                    color: textColor,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          spaceW(8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 4,
                            ),
                            decoration: BoxDecoration(
                              color: state.backgroundColor,
                              border: Border.all(
                                color: state.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              voucher.stateTypeId != ANULADO
                                  ? "Pagado"
                                  : voucher.stateTypeDescription,
                              style: TextStyle(
                                color: state.textColor,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      spaceH(4),
                      Text(
                        voucher.customerName.toTitleCase(),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
