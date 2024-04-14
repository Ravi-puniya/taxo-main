import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facturadorpro/app/controllers/product/cotizacion_controler.dart';

class ClientSelector extends StatelessWidget {
  final CotizacionController _cotizacionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seleccionar Cliente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  value: _cotizacionController.selectedClient.value,
                  onChanged: (newValue) {
                    int index = _cotizacionController.clients.indexOf(newValue);
                    String clientId = _cotizacionController.clientIds[index];
                    _cotizacionController.selectedClient.value = newValue!;
                    _cotizacionController.selectedClientId.value = clientId;
                  },
                  items: _cotizacionController.clients.map<DropdownMenuItem<String>>(
                    (client) {
                      return DropdownMenuItem<String>(
                        value: client,
                        child: Text(
                          client,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),

           Obx(
              () => Text(
                'Cliente seleccionado: ${_cotizacionController.selectedClient.value} - ID: ${_cotizacionController.selectedClientId.value}',
                style: TextStyle(
                  fontSize: 2,
                  color: Color.fromARGB(255, 255, 255, 255), // Cambia el color de la letra a azul
                ),
              ),
                          ),
          ],
        ),
      ),
    );
  }
}
