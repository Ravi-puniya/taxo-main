import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facturadorpro/app/controllers/product/categoria_controler.dart';

class AddCategoryDialog extends StatelessWidget {
  final CategoriaController categoriaController = Get.find();

  @override
  Widget build(BuildContext context) {
    TextEditingController nombreController = TextEditingController();

    return AlertDialog(
      title: Text('Agregar Categoría'),
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
              categoriaController.agregarCategoria(nombre);
              Get.back();
            }
          },
          child: Text('Agregar'),
        ),
      ],
    );
  }
}
