import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/controllers/cash/cash_controller.dart';
import 'package:facturadorpro/app/ui/pages/filter_cash_box_page/widgets/cash_box_field.dart';
import 'package:facturadorpro/app/ui/pages/filter_cash_box_page/widgets/column_select_cash_box.dart';
import 'package:facturadorpro/app/ui/pages/filter_cash_box_page/widgets/actions_filter_cash_box.dart';

class FilterCashBoxPage extends GetView<CashController> {
  const FilterCashBoxPage({Key? key}) : super(key: key);

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
          title: Text("Filtrar caja chica"),
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
              ColumnSelectCashBox(),
              CashBoxField(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ActionsFilterCashBox(),
      ),
    );
  }
}
