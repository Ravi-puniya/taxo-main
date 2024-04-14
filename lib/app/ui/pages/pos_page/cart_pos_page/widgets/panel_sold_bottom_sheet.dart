import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:printing/printing.dart';
import 'package:facturadorpro/shared/enums.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/small_loader.dart';
import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'dart:io';


Widget PanelSoldBottomSheet({
  required String pdfLinkTck,
  required String pdfLinkA4,
  required String message,
  required int documentId,
  required String correlative,
  required BuildContext context,
}) {
  PosController controller = Get.put(PosController());
  return WillPopScope(
    onWillPop: () async {
      controller.onClosePanelSold();
      return true;
    },
    child: SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.green.shade500,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 300,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SfPdfViewer.network(
                pdfLinkTck,
                enableDoubleTapZooming: true,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await launch(pdfLinkTck);
                    },
                    child: Text(
                      "DESCARGAR TCK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await launch(pdfLinkA4);
                    },
                    child: Text(
                      "DESCARGAR A4",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await printPDF(pdfLinkTck);
                    },
                    child: Text(
                      "IMPRIMIR",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Obx(() {
              bool sendingEmail = controller.isSendingEmail.value;
              return TextField(
                controller: controller.emailCnt,
                readOnly: sendingEmail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  labelText: "Correo electrónico",
                  prefixIcon: Icon(Icons.email_outlined),
                  suffixIcon: IconButton(
                    onPressed: sendingEmail
                        ? null
                        : () async {
                            await controller.onSendEmail(
                              documentId: documentId,
                            );
                          },
                    icon: sendingEmail
                        ? CircularProgressIndicator()
                        : Icon(Icons.send_rounded),
                  ),
                  isDense: true,
                ),
                cursorColor: Colors.blue,
                keyboardType: TextInputType.emailAddress,
              );
            }),
            SizedBox(height: 24),
            Obx(() {
              bool sendingWhatsapp = controller.isSendingWhatsapp.value;
              return TextField(
                controller: controller.numberCnt,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  labelText: "Whatsapp",
                  hintText: "Número celular",
                  prefixIcon: Icon(Icons.star_rate_rounded),
                  isDense: true,
                  suffixIcon: IconButton(
                    onPressed: sendingWhatsapp
                        ? null
                        : () async {
                            await controller.onSendWhatsapp(
                              documentId: documentId,
                            );
                          },
                    icon: sendingWhatsapp
                        ? CircularProgressIndicator()
                        : Icon(Icons.send_rounded),
                  ),
                ),
                cursorColor: Colors.blue,
                keyboardType: TextInputType.number,
              );
            }),



SizedBox(height: 24),
            Obx(() {
  bool sendingWhatsapp = controller.isSendingWhatsapp.value;
  return ElevatedButton(
    onPressed: sendingWhatsapp
      ? null
      : () async {
          // Aquí llamamos a la función para enviar el PDF a través de WhatsApp
          String phoneNumber = '+51${controller.whatsappPdfCnt.text.trim()}';
          await sendPdfViaWhatsapp(phoneNumber, pdfLinkTck);
        },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sendingWhatsapp
          ? SmallLoader(size: 20, strokeWidth: 2) // Muestra un loader si se está enviando
          : Icon(Icons.send_rounded),
        SizedBox(width: 8),
        Text(
          "Enviar pdf por WhatsApp",
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}),
            Spacer(),
            SizedBox(
              height: 48,
              child: TextButton(
                onPressed: controller.onClosePanelSold,
                child: Text("CERRAR VENTANA"),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

printPDF(String pdfLinkTck) async {
  try {
    print('URL del PDF: $pdfLinkTck'); // Imprime la URL del PDF
    final response = await http.get(Uri.parse(pdfLinkTck));
    if (response.statusCode == 200) {
      await Printing.layoutPdf(
        onLayout: (_) => response.bodyBytes,
      );
    } else {
      throw Exception('Error al cargar el PDF: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al imprimir el PDF: $e');
  }
}



Future<void> sendPdfViaWhatsapp(String phoneNumber, String pdfLinkTck) async {
  try {
    // Descargar el PDF desde el enlace proporcionado
    final response = await http.get(Uri.parse(pdfLinkTck));
    if (response.statusCode == 200) {
      // Convertir la respuesta a bytes para compartirlo por WhatsApp
      Uint8List pdfBytes = response.bodyBytes;

      // Obtener el directorio temporal
      final tempDir = await getTemporaryDirectory();
      final pdfFile = tempDir.path + '/temp_pdf.pdf';

      // Escribir el archivo PDF en el directorio temporal
      await File(pdfFile).writeAsBytes(pdfBytes);

      // Compartir el archivo PDF a través de WhatsApp utilizando share_plus
      await Share.shareFiles([pdfFile], text: '¡Hola! Adjunto el PDF que solicitaste.');

      // Si prefieres utilizar flutter_share_me:
      // await FlutterShareMe().shareToWhatsApp(msg: '¡Hola! Adjunto el PDF que solicitaste.', url: pdfFile, phoneNumber: phoneNumber);

    } else {
      throw Exception('Error al cargar el PDF: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al enviar el PDF por WhatsApp: $e');
    // Manejar el error según sea necesario
  }
}