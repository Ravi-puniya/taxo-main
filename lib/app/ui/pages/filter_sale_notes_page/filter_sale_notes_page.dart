import 'package:facturadorpro/app/ui/pages/filter_sale_notes_page/_widgets/actions_filter_voucher.dart';
import 'package:facturadorpro/app/ui/pages/filter_sale_notes_page/_widgets/client_field.dart';
import 'package:facturadorpro/app/ui/pages/filter_sale_notes_page/_widgets/column_select.dart';
import 'package:facturadorpro/app/ui/pages/filter_sale_notes_page/_widgets/correlative_group.dart';
import 'package:facturadorpro/app/ui/pages/filter_sale_notes_page/_widgets/emission_date_selector.dart';
import 'package:facturadorpro/app/ui/pages/filter_sale_notes_page/_widgets/state_document_select.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/controllers/sales_note_controller.dart';

class FilterSaleNotesPage extends GetView<SaleNotesController> {
  const FilterSaleNotesPage({Key? key}) : super(key: key);

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
          title: Text("Filtrar notas de venta"),
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
              ColumnSelect(),
              EmissionDateSelector(),
              ClientField(),
              CorrelativeGroup(),
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
