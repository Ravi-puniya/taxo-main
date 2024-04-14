import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/theme/colors/text.dart';

import 'package:facturadorpro/app/controllers/product/marcas_controler.dart'; // Corregido el nombre del controlador
import 'package:facturadorpro/app/ui/widgets/AddMarcaDialog.dart';
import 'package:facturadorpro/api/models/marcas.dart'; // Supongamos que el modelo para las marcas se llama Marca

class MarcaPage extends StatelessWidget {
  MarcaPage ({Key? key}) : super(key: key);

  final MarcasController marcasController = Get.put(MarcasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(
        () => ListView.builder(
          itemCount: marcasController.marcas.length, // Usar la lista de marcas del controlador
          itemBuilder: (context, index) {
            Marcas marca = marcasController.marcas[index]; // Usar el tipo de modelo correspondiente
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.grey[300],
                      image: marca.image != null // Usar la propiedad correspondiente de la marca
                          ? DecorationImage(
                              image: NetworkImage(marca.image!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: marca.image == null // Usar la propiedad correspondiente de la marca
                        ? Icon(Icons.image, size: 30, color: Colors.grey[600])
                        : null,
                  ),
                  title: Text(
                    marca.name, // Usar la propiedad correspondiente de la marca
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  onTap: () {
                    // Agregar acciones adicionales al tocar el elemento si es necesario
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(AddMarcaDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
