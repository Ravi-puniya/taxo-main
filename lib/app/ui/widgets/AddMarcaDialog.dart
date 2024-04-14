import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facturadorpro/app/controllers/product/marcas_controler.dart';

class AddMarcaDialog extends StatelessWidget {
  final MarcasController marcasController = Get.find();

  @override
  Widget build(BuildContext context) {
    TextEditingController nombreController = TextEditingController();

    return AlertDialog(
      title: Text('Agregar Marca'),
      content: TextField(
        controller: nombreController,
        decoration: InputDecoration(labelText: 'Nombre'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            String nombre = nombreController.text.trim();
            if (nombre.isNotEmpty) {
              marcasController.agregarMarcas(nombre);
              Get.back();
            }
          },
          child: Text('Agregar'),
        ),
      ],
    );
  }
}
