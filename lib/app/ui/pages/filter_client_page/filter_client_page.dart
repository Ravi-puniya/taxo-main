import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/controllers/client/client_controller.dart';
import 'package:facturadorpro/app/ui/pages/filter_client_page/widgets/client_field.dart';
import 'package:facturadorpro/app/ui/pages/filter_client_page/widgets/column_select_client.dart';
import 'package:facturadorpro/app/ui/pages/filter_client_page/widgets/actions_filter_client.dart';

class FilterClientPage extends GetView<ClientController> {
  const FilterClientPage({Key? key}) : super(key: key);

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
          title: Text("Filtrar clientes"),
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
              ColumnSelectClient(),
              ClientField(),
            ],
          ),
        ),
        //no mover
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ActionsFilterClient(),
      ),
    );
  }
}
