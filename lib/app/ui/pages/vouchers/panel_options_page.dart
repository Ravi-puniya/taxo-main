import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:printing/printing.dart';
import 'dart:io';

import 'package:facturadorpro/shared/enums.dart';
import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/ui/theme/colors/text.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/ui/widgets/small_loader.dart';
import 'package:facturadorpro/app/ui/theme/colors/secondary.dart';
import 'package:facturadorpro/app/controllers/vouchers_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share_me/flutter_share_me.dart';


class PanelOptionsPage extends StatelessWidget {
  const PanelOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VouchersController());
    return SafeArea(
      child: Obx(() {
        final voucher = controller.voucher.value;
        if (voucher != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Opciones ${voucher.correlative}"),
              backgroundColor: Colors.white,
              foregroundColor: textColor,
              elevation: 0,
            ),
            body: SingleChildScrollView(
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
                      voucher.message,
                      style: TextStyle(
                        color: Colors.green.shade500,
                      ),
                    ),
                  ),
                  spaceH(16),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 120,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (controller.existsTck.value) {
                                await controller.onOpenPdf(
                                  filename: "${voucher.correlative}-ticket.pdf",
                                );
                              } else {
                                print(
                                    "Enlace TCK (No local): ${voucher.pdfLinkTck}");

                                await controller.openPdfLink(
                                  voucher.pdfLinkTck,
                                );
                              }
                            },
                            child: Obx(() {
                              String percent =
                                  controller.downloadPercent.value[0];
                              if (percent != "0") {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SmallLoader(
                                      size: 8,
                                    ),
                                    spaceW(8),
                                    Text(
                                      "$percent%",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_download_outlined,
                                    color: Colors.white,
                                  ),
                                  spaceH(8),
                                  Text(
                                    "DESCARGAR\nFORMATO TCK",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              );
                            }),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      spaceW(16),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 120,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (controller.existsA4.value) {
                                await controller.onOpenPdf(
                                  filename: "${voucher.correlative}-a4.pdf",
                                );
                              } else {
                                await controller.openPdfLink(
                                  voucher.pdfLinkA4,
                                );
                              }
                            },
                            child: Obx(() {
                              String percent =
                                  controller.downloadPercent.value[1];
                              if (percent != "0") {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SmallLoader(
                                      size: 8,
                                    ),
                                    spaceW(8),
                                    Text(
                                      "$percent%",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_download_outlined,
                                    color: Colors.white,
                                  ),
                                  spaceH(6),
                                  Text(
                                    "DESCARGAR\nFORMATO A4",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2,
                                  ),
                                ],
                              );
                            }),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      spaceW(16),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 120,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (controller.existsTck.value) {
                                await controller.onOpenPdf(
                                  filename: "${voucher.correlative}-ticket.pdf",
                                );
                              } else {
                                print(
                                    "Enlace TCK (No local): ${voucher.pdfLinkTck}");
                                await printPDF(voucher.pdfLinkTck);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: primaryColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.print_sharp,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  " IMPRIMIR",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceH(24),
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
                                    documentId: voucher.documentId,
                                  );
                                },
                          icon: sendingEmail
                              ? SmallLoader(size: 12, strokeWidth: 1)
                              : Icon(Icons.send_rounded),
                        ),
                        isDense: true,
                      ),
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.emailAddress,
                    );
                  }),
                  spaceH(24),
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
                        prefixIcon: Icon(Icons.star_border_outlined),
                        isDense: true,
                        suffixIcon: IconButton(
                          onPressed: sendingWhatsapp
                              ? null
                              : () async {
                                  await controller.onSendWhatsapp(
                                    documentId: voucher.documentId,
                                  );
                                },
                          icon: sendingWhatsapp
                              ? SmallLoader(size: 12, strokeWidth: 1)
                              : Icon(Icons.send_rounded),
                        ),
                      ),
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.numberWithOptions(
                        signed: false,
                        decimal: false,
                      ),
                    );
                  }),

                  spaceH(24),

Obx(() {
  bool sendingWhatsapp = controller.isSendingWhatsapp.value;
  return ElevatedButton(
    onPressed: sendingWhatsapp
      ? null
      : () async {
          // Aquí llamamos a la función para enviar el PDF a través de WhatsApp
          String phoneNumber = '+51${controller.whatsappPdfCnt.text.trim()}';
          await sendPdfViaWhatsapp(phoneNumber, voucher.pdfLinkTck);
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

                ],
              ),
            ),
          );
        }
        return SizedBox();
      }),
    );
  }
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