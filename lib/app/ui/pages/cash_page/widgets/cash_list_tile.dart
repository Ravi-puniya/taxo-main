import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/api/models/response/cash_model.dart';
import 'package:facturadorpro/app/ui/widgets/custom_alert.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/cash/cash_controller.dart';

class CashListTile extends StatelessWidget {
  const CashListTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CashItemModel item;

  @override
  Widget build(BuildContext context) {
    CashController _controller = Get.put(CashController());
    final bool isOpened = item.stateDescription == "Aperturada";
    return Obx(() {
      final bool isSelected = item.id == _controller.currentIdAction.value;
      return Slidable(
        key: Key(item.id.toString()),
        closeOnScroll: true,
        direction: Axis.horizontal,
        startActionPane: ActionPane(
          extentRatio: 1,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              flex: 1,
              autoClose: true,
              icon: Icons.delete_outline,
              label: "Eliminar",
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              onPressed: (_) async {
                _controller.onChangeSelectedId(id: item.id, validate: false);
                customAlert(
                  context: context,
                  title: "Confirmación",
                  message:
                      "¿Desea eliminar esta caja chica de nuestros registros definitivamente?",
                  okText: "Si, eliminar",
                  onOk: _controller.isDeleting == false
                      ? () async {
                          await _controller.deleteItem(
                            id: item.id,
                            context: context,
                          );
                        }
                      : null,
                );
              },
            ),
          ],
        ),
        endActionPane: isOpened == true
            ? ActionPane(
                extentRatio: 1,
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    flex: 1,
                    autoClose: true,
                    icon: Icons.edit_outlined,
                    label: "Editar",
                    backgroundColor: Colors.blue.shade50,
                    foregroundColor: Colors.blue.shade600,
                    onPressed: (_) {
                      _controller.onChangeSelectedId(
                        id: item.id,
                        validate: false,
                      );
                      Get.toNamed(
                        Routes.CASH_FORM_PAGE,
                        arguments: item.id,
                      );
                    },
                  ),
                  SlidableAction(
                    flex: 1,
                    autoClose: true,
                    icon: Icons.output_outlined,
                    label: "Cerrar",
                    backgroundColor: Colors.pink.shade50,
                    foregroundColor: Colors.pink.shade600,
                    onPressed: (_) {
                      _controller.onChangeSelectedId(
                        id: item.id,
                        validate: false,
                      );
                      customAlert(
                        context: context,
                        title: "Confirmación",
                        message:
                            "¿Desea cerrar esta caja chica aperturada por \"${item.user}\"?",
                        okText: "Si, cerrar",
                        onOk: _controller.isClosing == false
                            ? () async => await _controller.closeCashBox(
                                  id: item.id,
                                  context: context,
                                )
                            : () {},
                      );
                    },
                  ),
                ],
              )
            : null,
        child: Container(
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected == true ? primaryColor : Colors.white,
              width: 2.0,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: ListTile(
            dense: true,
            onTap: () => _controller.onChangeSelectedId(id: item.id),
            title: Row(
              children: [
                Text(
                  item.user.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Icon(
                  isOpened == true ? Icons.check_circle : Icons.output_outlined,
                  size: 14.0,
                  color: isOpened ? Colors.green.shade600 : Colors.red.shade500,
                ),
                const SizedBox(width: 4.0),
                Text(
                  item.stateDescription.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color:
                        isOpened ? Colors.green.shade600 : Colors.red.shade500,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 12.0),
                    const SizedBox(width: 4.0),
                    const Text("Fecha de apertura:"),
                    const Spacer(),
                    Text(item.opening),
                  ],
                ),
                if (item.closed != " ") const SizedBox(height: 4.0),
                if (item.closed != " ")
                  Row(
                    children: [
                      const Icon(Icons.today, size: 12.0),
                      const SizedBox(width: 4.0),
                      const Text("Fecha de cierre:"),
                      const Spacer(),
                      Text(item.closed!),
                    ],
                  ),
                const SizedBox(height: 4.0),
                //const Divider(),
                Row(
                  children: [
                    const Icon(Icons.attach_money, size: 12.0),
                    const SizedBox(width: 4.0),
                    const Text("Saldo inicial:"),
                    const Spacer(),
                    Text(
                      formatMoney(
                        quantity: double.parse(item.beginningBalance),
                        symbol: "S/.",
                        decimalDigits: 2,
                      ),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Icon(Icons.attach_money, size: 12.0),
                    const SizedBox(width: 4.0),
                    const Text("Saldo final:"),
                    const Spacer(),
                    Text(
                      formatMoney(
                        quantity: double.parse(item.finalBalance),
                        symbol: "S/.",
                        decimalDigits: 2,
                      ),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
