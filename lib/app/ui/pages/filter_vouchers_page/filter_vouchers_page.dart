import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/sunat_voucher_controller.dart';
import 'package:facturadorpro/app/ui/pages/filter_vouchers_page/_widgets/customer_select.dart';
import 'package:facturadorpro/app/ui/pages/filter_vouchers_page/_widgets/correlative_group.dart';
import 'package:facturadorpro/app/ui/pages/filter_vouchers_page/_widgets/document_type_select.dart';
import 'package:facturadorpro/app/ui/pages/filter_vouchers_page/_widgets/state_document_select.dart';
import 'package:facturadorpro/app/ui/pages/filter_vouchers_page/_widgets/emission_date_selector.dart';
import 'package:facturadorpro/app/ui/pages/filter_vouchers_page/_widgets/actions_filter_voucher.dart';
import 'package:facturadorpro/app/ui/pages/filter_vouchers_page/_widgets/range_calendar_selector.dart';

class FilterVouchersPage extends GetView<SunatVoucherController> {
  const FilterVouchersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.saveOnPreviousValue();
    return WillPopScope(
      onWillPop: () async {
        controller.resetPreviousValues();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Filtrar comprobantes"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: textColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DocumentTypeSelect(),
              CorrelativeGroup(),
              RangeCalendarSelector(),
              EmissionDateSelector(),
              CustomerSelect(),
              StateDocSelect(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ActionsFilterVoucher(),
      ),
    );
  }
}
