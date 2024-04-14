import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:facturadorpro/shared/environment.dart';

String formatMoney({
  String? symbol,
  required double quantity,
  int? decimalDigits,
}) {
  NumberFormat nf = NumberFormat.currency(
    locale: 'en_US',
    decimalDigits: decimalDigits ?? 0,
    symbol: symbol != null ? "$symbol " : '',
  );
  return nf.format(quantity);
}

bool isValidCellPhoneNumber(String value) {
  String pattern = r'(^(?:[+]51)?[0-9]{9}$)';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

Future<bool> existsDir({
  required String dirname,
  required String filename,
}) async {
  bool exists = false;
  if (dirname.isNotEmpty) {
    String domain = Environment.businessDomain;
    String pathname = "${dirname}/$domain/$filename";
    exists = File(pathname).existsSync();
  }
  return exists;
}

void displayErrorMessage({String? message}) {
  Fluttertoast.showToast(
    msg: message ?? "Ha ocurrido un error en el servicio",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void displayWarningMessage({required String message, ToastGravity? position}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: position ?? ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.orange,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void displayInfoMessage({required String message, ToastGravity? position}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: position ?? ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void displaySuccessMessage({required String message, ToastGravity? position}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: position ?? ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

void showLoader({required String status}) {
  EasyLoading.show(
    dismissOnTap: false,
    maskType: EasyLoadingMaskType.clear,
    status: status,
    indicator: SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      ),
    ),
  );
}

void dismissLoader() => EasyLoading.dismiss();
