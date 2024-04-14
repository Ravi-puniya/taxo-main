import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:email_validator/email_validator.dart';

import 'package:facturadorpro/shared/getx.dart';
import 'package:facturadorpro/shared/enums.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/shared/environment.dart';
import 'package:facturadorpro/api/models/voucher_response_model.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:facturadorpro/app/controllers/directory_controller.dart';
import 'package:facturadorpro/api/models/response/print_response_model.dart';
import 'package:facturadorpro/app/ui/models/panel_options_voucher_model.dart';
import 'package:facturadorpro/api/models/response/email_sent_response_model.dart';

class VouchersController extends GetxController {
  GetStorage box = GetStorage();
  FacturadorProvider provider = Get.put(FacturadorProvider());
  DirectoryController directoryCnt = Get.put(DirectoryController());

  TextEditingController emailCnt = TextEditingController();
  TextEditingController numberCnt = TextEditingController();

  final ScrollController scrollController = ScrollController();
  final PdfViewerController pdfController = PdfViewerController();
  final whatsappPdfCnt = TextEditingController();

  RxBool isSendingEmail = false.obs;
  RxBool isSendingWhatsapp = false.obs;
  RxBool existsTck = false.obs;
  RxBool existsA4 = false.obs;
  RxList<String> downloadPercent = ["0", "0"].obs;
  RxList<Voucher> vouchers = <Voucher>[].obs;
  Rx<PanelOptionsVoucherModel?> voucher =
      RxNullable<PanelOptionsVoucherModel?>().setNull();

  @override
  void onInit() async {
    super.onInit();
  }

  void onSelectedVoucher(PanelOptionsVoucherModel selected) {
    voucher.value = selected;
  }

  Future<void> onSendEmail({required int documentId}) async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      String email = emailCnt.text;
      if (email.isEmpty) {
        return displayWarningMessage(message: "Ingrese un correo electrónico");
      }
      if (email.isNotEmpty && !EmailValidator.validate(email)) {
        return displayWarningMessage(
          message: "El correo electrónico no es válido",
        );
      }
      isSendingEmail.value = true;
      Response res = await provider.sendEmailToClient(
        email: emailCnt.text,
        documentId: documentId,
      );
      if (res.statusCode == 200) {
        EmailSentResponseModel result = emailSentResponseModelFromJson(
          res.bodyString!,
        );
        if (result.success) {
          displaySuccessMessage(
            message: "El comprobante fue enviado al correo electrónico",
          );
        } else {
          displayErrorMessage(
            message: "Ha ocurrido un problema al enviar el comprobante",
          );
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isSendingEmail.value = false;
    }
  }

  Future<void> onSendWhatsapp({required int documentId}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    String phone = numberCnt.text;
    if (phone.isEmpty) {
      return displayWarningMessage(
        message: "Por favor ingrese un número de celular",
      );
    }
    try {
      isSendingWhatsapp.value = true;
      Response res = await provider.fetchPrintVoucherInfo(
        documentId: documentId,
      );
      if (res.statusCode == 200) {
        PrintResponseModel result = printResponseModelFromJson(
          res.bodyString!,
        );
        var whatsappURlAndroid =
            "whatsapp://send?phone=+51$phone&text=${result.data.messageText}";
        var whatsappURLIos =
            "https://wa.me/$phone?text=${Uri.tryParse(result.data.messageText)}";
        if (Platform.isIOS) {
          if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
            await launchUrl(Uri.parse(whatsappURLIos));
          } else {
            displayWarningMessage(message: "Whatsapp no instalado");
          }
        } else {
          if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
            await launchUrl(Uri.parse(whatsappURlAndroid));
          } else {
            displayWarningMessage(message: "Whatsapp no instalado");
          }
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isSendingWhatsapp.value = false;
    }
  }

  Future<void> onOpenPdf({required String filename}) async {
    try {
      String domain = Environment.businessDomain;
      String pathname = "${directoryCnt.downloadDir.value}/$domain/$filename";
      OpenFile.open(pathname);
    } catch (error) {
      displayErrorMessage(message: "No es posible abrir el archivo PDF");
    }
  }

  Future<void> openPdfLink(String pdfLink) async {
    if (await canLaunch(pdfLink)) {
      await launch(pdfLink);
    } else {
      displayErrorMessage(message: 'No se pudo abrir el enlace');
    }
  }
}
