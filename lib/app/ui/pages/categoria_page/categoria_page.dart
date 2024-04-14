import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/theme/colors/text.dart';

import 'package:facturadorpro/app/controllers/product/categoria_controler.dart';
import 'package:facturadorpro/app/ui/widgets/AddCategoryDialog.dart';
import 'package:facturadorpro/api/models/categoria.dart';

class CategoriaPage extends StatelessWidget {
  CategoriaPage({Key? key}) : super(key: key);

  final CategoriaController categoriaController = Get.put(CategoriaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(
        () => ListView.builder(
          itemCount: categoriaController.categorias.length,
          itemBuilder: (context, index) {
            Categoria categoria = categoriaController.categorias[index];
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
                      image: categoria.image != null
                          ? DecorationImage(
                              image: NetworkImage(categoria.image!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: categoria.image == null
                        ? Icon(Icons.image, size: 30, color: Colors.grey[600])
                        : null,
                  ),
                  title: Text(
                    categoria.name,
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
          Get.dialog(AddCategoryDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
