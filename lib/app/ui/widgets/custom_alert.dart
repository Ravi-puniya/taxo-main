import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:facturadorpro/app/ui/theme/colors/primary.dart';

Future<dynamic> customAlert({
  required BuildContext context,
  VoidCallback? onOk,
  String? title,
  required String message,
  CoolAlertType? type,
  String? okText,
  String? cancelText,
  Widget? widget,
}) {
  return CoolAlert.show(
    context: context,
    type: type ?? CoolAlertType.confirm,
    title: title,
    text: message,
    backgroundColor: Colors.white,
    confirmBtnTextStyle: TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    cancelBtnTextStyle: TextStyle(
      fontSize: 14.0,
      color: Colors.grey.shade500,
      fontWeight: FontWeight.w500,
    ),
    confirmBtnColor: primaryColor,
    cancelBtnText: cancelText ?? "Cancelar",
    confirmBtnText: okText ?? "Cerrar",
    onConfirmBtnTap: onOk,
    loopAnimation: true,
    widget: widget,
  );
}
