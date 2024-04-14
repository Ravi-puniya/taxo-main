import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:facturadorpro/api/models/cotizacion_response.dart';

class CotizacionResponseWidget extends StatelessWidget {
  final CotizacionData cotizacionData;

  const CotizacionResponseWidget({
    Key? key,
    required this.cotizacionData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Número de cotización: ${cotizacionData.numberFull}'),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _launchURL(context, cotizacionData.printA4);
              },
              child: Text('Imprimir A4'),
            ),
            ElevatedButton(
              onPressed: () {
                _launchURL(context, cotizacionData.printTicket);
              },
              child: Text('Imprimir Ticket'),
            ),
          ],
        ),
      ],
    );
  }

  void _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No se pudo abrir la URL: $url'),
      ));
    }
  }
}
