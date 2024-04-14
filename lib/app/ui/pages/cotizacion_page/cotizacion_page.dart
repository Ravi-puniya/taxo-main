import 'package:facturadorpro/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facturadorpro/app/controllers/product/cotizacion_controler.dart';
import 'package:facturadorpro/app/ui/widgets/client_selector.dart';
import 'package:facturadorpro/app/ui/widgets/product_item.dart';
import 'package:url_launcher/url_launcher.dart';

class CotizacionPage extends StatefulWidget {
  @override
  _CotizacionPageState createState() => _CotizacionPageState();
}

class _CotizacionPageState extends State<CotizacionPage> {
  final CotizacionController _cotizacionController = Get.put(CotizacionController());
  final List<Map<String, dynamic>> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () {
            if (_cotizacionController.isLoading.value) {
              return CircularProgressIndicator();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  ClientSelector(),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _showProductList(context);
                    },
                    child: Text('Agregar Productos'),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildSelectedProductsTable(),
                          SizedBox(height: 10),
                          Text(
                            'Total: S/.${_calculateTotal()}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
Center(
  child: SizedBox(
    width: 200, // Ancho deseado del botón
    child: ElevatedButton(
      onPressed: _createCotizacion,
      child: Text('Crear Cotización'),
    ),
  ),
),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSelectedProductsTable() {
  if (selectedProducts.isEmpty) {
    return SizedBox.shrink(); // Si no hay productos seleccionados, no mostrar la tabla
  }

  List<DataRow> rows = [];
  for (int i = 0; i < selectedProducts.length; i++) {
    final product = selectedProducts[i];
    final productName = product['description'];
    final currentPrice = double.parse(product['price']);
    final currentQuantity = product['quantity'] ?? 1; // Si no hay cantidad definida, usar 1 por defecto

    rows.add(DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Image.network(
                product['image'], // URL de la imagen
                width: 50, // Ancho deseado de la imagen
                height: 50, // Alto deseado de la imagen
                fit: BoxFit.cover, // Ajuste de la imagen dentro del contenedor
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  // Manejar errores de carga de imagen
                  return Image.asset(
                    'assets/images/imagen-no-disponible.jpg', // Ruta de la imagen de respaldo
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  );
                },
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  productName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          TextFormField(
            initialValue: currentPrice.toStringAsFixed(2),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (newValue) {
              setState(() {
                selectedProducts[i]['price'] = newValue;
              });
            },
          ),
        ),
        DataCell(
          TextFormField(
            initialValue: currentQuantity.toString(),
            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              setState(() {
                int newQuantity = int.parse(newValue);
                selectedProducts[i]['quantity'] = newQuantity;
              });
            },
          ),
        ),
        DataCell(
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteProduct(i);
            },
          ),
        ),
      ],
    ));
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal, // Permitir desplazamiento horizontal en la tabla
    child: DataTable(
      columnSpacing: 10, // Espacio entre las columnas
      columns: [
        DataColumn(label: Text('Imagen y Nombre')),
        DataColumn(label: Text('Precio')),
        DataColumn(label: Text('Cantidad')),
        DataColumn(label: Text('Eliminar')),
      ],
      rows: rows,
    ),
  );
}

  void _showProductList(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 300,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lista de Productos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
child: ListView.builder(
  itemCount: _cotizacionController.items.length,
  itemBuilder: (context, index) {
    final product = _cotizacionController.items[index];
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Image.network(
          product['image'], // URL de la imagen
          width: 50, // Ancho deseado de la imagen
          height: 50, // Alto deseado de la imagen
          fit: BoxFit.cover, // Ajuste de la imagen dentro del contenedor
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            // Manejar errores de carga de imagen
            return Image.asset(
              'assets/images/imagen-no-disponible.jpg', // Ruta de la imagen de respaldo
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            );
          },
        ),
        title: Text(product['description']),
        subtitle: Text('Precio: ${product['price']}'),
        trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            // Aquí puedes realizar las acciones cuando se presione el botón
            // Por ejemplo, agregar el producto a una lista de productos seleccionados
            selectedProducts.add(product);

            // Llamar a una función para actualizar un campo de texto u otra interfaz de usuario
            _updateTextField();

            // Cerrar el diálogo después de seleccionar un producto
            Navigator.pop(context);
          },
        ),
      ),
    );
  },
),

                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _updateTextField() {
    setState(() {}); // Actualiza el estado del widget para que se reconstruya y muestre la tabla
  }

  void _deleteProduct(int index) {
    setState(() {
      selectedProducts.removeAt(index);
    });
  }

  String _calculateTotal() {
    double total = 0.0;
    for (var product in selectedProducts) {
      double price = double.parse(product['price']);
      int quantity = product['quantity'] ?? 1; // Si no hay cantidad definida, usar 1 por defecto
      total += price * quantity;
    }
    return total.toStringAsFixed(2);
  }

void _showCotizacionResponse(String responseMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Respuesta de la cotización'),
        content: Text(responseMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Aceptar'),
          ),
        ],
      );
    },
  );
}


void _createCotizacion() {
  if (selectedProducts.isNotEmpty && _cotizacionController.selectedClientId.isNotEmpty) {
    _cotizacionController.createCotizacion(selectedProducts, _cotizacionController.selectedClientId.value, _calculateTotal);
                      
    selectedProducts.forEach((e){
      e["quantity"] = 1;
    });
    selectedProducts.clear();
    _updateTextField();
    
    // Mostrar un mensaje de éxito después de crear la cotización
    _showCotizacionResponse('La cotización se ha creado correctamente.');
  } else {
    // Mostrar un mensaje de advertencia si no hay productos seleccionados o cliente seleccionado
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Advertencia'),
          content: Text('Debe seleccionar al menos un producto y un cliente para crear la cotización.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}


}
