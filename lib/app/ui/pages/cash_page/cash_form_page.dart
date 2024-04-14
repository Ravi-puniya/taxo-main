import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/theme/spacing.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/custom_alert.dart';
import 'package:facturadorpro/app/controllers/cash/cash_form_controller.dart';

class CashFormPage extends GetView<CashFormController> {
  const CashFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Obx(() {
          if (controller.isLoadingParams == true ||
              controller.isRetrieving == true) {
            return Text("Caja chica");
          }
          String t = controller.cashBoxId.value != 0 ? "Editar" : "Registrar";
          return Text("$t caja chica");
        }),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() {
        String action =
            controller.cashBoxId.value != 0 ? "actualizar" : "registrar";
        if (controller.isLoadingParams.value == false) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                elevation: 0,
                onPressed: controller.resetValues,
                label: Text(
                  "CANCELAR",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                  ),
                ),
                backgroundColor: Colors.grey.shade200,
                heroTag: null,
              ),
              const SizedBox(width: 12.0),
              FloatingActionButton.extended(
                elevation: 0,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  customAlert(
                    context: context,
                    title: "Confirmación",
                    message:
                        "¿Desea $action la caja chica con la información proporcionada?",
                    okText: "Si, $action",
                    onOk: controller.isSaving == false
                        ? () async => await controller.onSaveCashBox(context)
                        : null,
                  );
                },
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  "GUARDAR",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: primaryColor,
                heroTag: null,
              ),
            ],
          );
        }
        return SizedBox();
      }),
      body: Obx(() {
        bool displayLoading = controller.isLoadingParams.value == true ||
            controller.isRetrieving.value == true;
        if (displayLoading == true) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(Icons.attach_money_outlined, size: 20.0),
                    SizedBox(width: kDefaultPadding),
                    Text(
                      "SALDO INICIAL",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                TextField(
                  controller: controller.balanceCnt,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        kDefaultPadding / 2,
                      ),
                    ),
                    labelText: "Monto inicial",
                    prefix: Text("S/ "),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyTextInputFormatter(
                      locale: 'en_us',
                      decimalDigits: 2,
                      symbol: "",
                    ),
                  ],
                  onChanged: controller.onChangedInitialValue,
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: kDefaultPadding * 2),
                Row(
                  children: const <Widget>[
                    Icon(
                      Icons.text_snippet_outlined,
                      size: 20.0,
                    ),
                    SizedBox(width: kDefaultPadding),
                    Text(
                      "VENDEDOR",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                Obx(() {
                  return SelectFormField(
                    type: SelectFormFieldType.dropdown,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          kDefaultPadding / 2,
                        ),
                      ),
                      labelText: "Seleccione vendedor",
                    ),
                    dialogTitle: 'LISTA DE VENDEDORES',
                    dialogCancelBtn: 'CANCELAR',
                    initialValue: controller.sellerId.value,
                    // ignore: invalid_use_of_protected_member
                    items: controller.sellers.value,
                    onChanged: (String option) {
                      controller.onChangeSeller(id: int.parse(option));
                    },
                  );
                }),
                const SizedBox(height: kDefaultPadding * 2),
                Row(
                  children: const <Widget>[
                    Icon(Icons.numbers, size: 20.0),
                    SizedBox(width: kDefaultPadding),
                    Text(
                      "CÓDIGO DE REFERENCIA",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                TextField(
                  controller: controller.referenceCnt,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        kDefaultPadding / 2,
                      ),
                    ),
                    labelText: "Ingrese código",
                  ),
                  cursorColor: primaryColor,
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
