import 'package:facturadorpro/api/models/cotizacion_item.dart';
import 'package:get/get.dart';
import 'package:facturadorpro/api/services/cotizacion_service.dart';
import 'package:intl/intl.dart';
import 'package:facturadorpro/api/models/cotizacion.dart'; // Importa el modelo de cotización

class CotizacionController extends GetxController {
  var isLoading = false.obs;
  var selectedClient = ''.obs;
  var clients = [].obs;
  var clientIds = [].obs;
  var selectedClientId = ''.obs;

  var items = [].obs; // Lista de productos

  final CotizacionService _cotizacionService = Get.find();

  @override
  void onInit() {
    super.onInit();
    loadClients();
    fetchItems();
  }

  Future<void> loadClients() async {
    try {
      isLoading.value = true;
      final response = await _cotizacionService.filterClients();
      if (response.status.hasError) {
        print('Error al obtener clientes: ${response.statusText}');
        return;
      }
      final responseData = response.body['data'];

      // Limpiar las listas antes de agregar nuevos clientes
      clients.clear();
      clientIds.clear();

      // Iterar sobre los datos de los clientes y guardar el nombre y el ID
      for (var client in responseData) {
        String name = client['name'].toString();
        String id = client['id'].toString();
        clients.add(name);
        clientIds.add(id);
      }

      // Establecer el primer cliente como seleccionado si hay clientes disponibles
      selectedClient.value = clients.isNotEmpty ? clients[0] : '';
      selectedClientId.value = clientIds.isNotEmpty ? clientIds[0] : '';
    } catch (e) {
      print('Error al cargar clientes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchItems() async {
    try {
      isLoading(true);
      final List<Map<String, dynamic>> itemList =
          await _cotizacionService.filterItems();
      items.assignAll(itemList);
    } finally {
      isLoading(false);
    }
  }

  // Método para crear una cotización
  Future<void> createCotizacion(List<Map<String, dynamic>> selectedProducts,
      String clientId, String _calculateTotal()) async {
    try {
      isLoading.value = true;
      // Calcular el total de la cotización utilizando la función _calculateTotal
      String total = _calculateTotal();
      // Construir el objeto de cotización
      Cotizacion cotizacion = Cotizacion(
        prefix: 'COT',
        establishmentId: null,
        dateOfIssue: DateTime.now()
            .toString()
            .split(" ")[0], // Tomar la fecha actual del dispositivo
        timeOfIssue: DateTime.now()
            .toString()
            .split(" ")[1], // Tomar la hora actual del dispositivo
        customerId: int.parse(clientId), // Convertir el ID del cliente a entero
        currencyTypeId: 'PEN', // Ejemplo de tipo de moneda (PEN)
        exchangeRateSale: 1.0, // Ejemplo de tasa de cambio
        totalPrepayment: 0.0, // Ejemplo de anticipo total
        totalCharge: 0.0, // Ejemplo de cargo total
        totalDiscount: 0.0, // Ejemplo de descuento total
        totalExportation: 0.0, // Ejemplo de total de exportación
        totalFree: 0.0, // Ejemplo de total gratuito
        totalTaxed: double.parse(
            total), // Utilizar el total calculado como total gravado
        totalUnaffected: 0.0, // Ejemplo de total no afectado
        totalExonerated: 0.0, // Ejemplo de total exonerado
        totalIgv: 0.0, // Ejemplo de total IGV
        totalIgvFree: 0.0, // Ejemplo de total IGV gratuito
        totalBaseIsc: 0.0, // Ejemplo de base total ISC
        totalIsc: 0.0, // Ejemplo de total ISC
        totalBaseOtherTaxes: 0.0, // Ejemplo de base total de otros impuestos
        totalOtherTaxes: 0.0, // Ejemplo de total de otros impuestos
        totalTaxes: 0.0, // Ejemplo de total de impuestos
        totalValue:
            double.parse(total), // Utilizar el total calculado como valor total
        total: double.parse(total), // Utilizar el total calculado como total
        subtotal: 0.0, // Ejemplo de subtotal
        items: selectedProducts.map((e) {
          double price = double.parse(e["price"]);

          double quantity = double.parse(e["quantity"] ?? "1");

          return Cotizacioniten(
            item_id: e["item_id"],
            price_type_id: "01",
            item: {
              "id": e["item_id"],
              "item_code": null,
              "full_description": e["full_description"],
              "model": null,
              "brand": e["brand"],
              "warehouse_description": e["warehouses"][0]
                  ["warehouse_description"],
              "category": e["category"],
              "stock": e["stock"],
              "internal_id": e["internal_id"],
              "description": e["description"],
              "currency_type_id": e["currency_type_id"],
              "currency_type_symbol": e["currency_type_symbol"],
              "has_igv": false,
              "sale_unit_price": e["sale_unit_price"],
              "purchase_has_igv": false,
              "purchase_unit_value": 0,
              "purchase_unit_price": 0,
              "unit_type_id": "NIU",
              "original_unit_type_id": "NIU",
              "sale_affectation_igv_type": {
                "id": e[
                    "sale_affectation_igv_type_id"], //reyenar  de la api  iteen sacar  "listado sale_affectation_igv_type"
                "active": 1,
                "exportation": 0,
                "free": 0,
                "description": "Gravado - Operación Onerosa"
              },
              "sale_affectation_igv_type_id": e["sale_affectation_igv_type_id"],
              "purchase_affectation_igv_type_id":
                  e["purchase_affectation_igv_type_id"],
              "calculate_quantity": false,
              "has_plastic_bag_taxes": false,
              "amount_plastic_bag_taxes": "0.10",
              "colors": [],
              "CatItemUnitsPerPackage": [],
              "CatItemMoldProperty": [],
              "CatItemProductFamily": [],
              "CatItemMoldCavity": [],
              "CatItemPackageMeasurement": [],
              "CatItemStatus": [],
              "CatItemSize": [],
              "CatItemUnitBusiness": [],
              "item_unit_types": [],
              "warehouses": [
                {
                  "warehouse_description": e["warehouses"][0]
                      ["warehouse_description"],
                  "stock": e["warehouses"][0]["stock"],
                  "warehouse_id": e["warehouses"][0]["warehouse_id"],
                  "checked": true
                }
              ],
              "attributes": [],
              "lots_group": [],
              "lots": [],
              "lots_enabled": false,
              "series_enabled": false,
              "is_set": false,
              "lot_code": null,
              "date_of_due": null,
              "barcode": "00083",
              "change_free_affectation_igv": false,
              "original_affectation_igv_type_id":
                  e["purchase_affectation_igv_type_id"],
              "has_isc": false,
              "system_isc_type_id": null,
              "percentage_isc": "0.00",
              "is_for_production": false,
              "subject_to_detraction": false,
              "name_product_pdf": "",
              "unit_price": e["price"],
              "extra_attr_name": "Tiempo de entrega",
              "extra_attr_value": "",
              "presentation": {}
            },
            currency_type_id: e["currency_type_id"] ?? "",
            quantity: quantity.toInt(),
            unit_value: price,
            affectation_igv_type_id:
                e["purchase_affectation_igv_type_id"] ?? "",
            total_base_igv: price * quantity,
            percentage_igv: 18,
            total_igv: price * quantity * 18 / 100,
            total_taxes: price * quantity * 18 / 100,
            unit_price: price,
            input_unit_price_value: (price * 82 / 100).toString(),
            total_value: price * quantity * 82 / 100,
            total: price * quantity,
            total_value_without_rounding: price * quantity * 82 / 100,
            total_base_igv_without_rounding: price * quantity * 82 / 100,
            total_igv_without_rounding: price * quantity * 18 / 100,
            total_taxes_without_rounding: price * quantity * 18 / 100,
            total_without_rounding: price * quantity,
            purchase_unit_price: 0,
            purchase_unit_value: 0,
            purchase_has_igv: false,
          );
        }).toList(), // Lista de productos seleccionados
        paymentMethodTypeId: '01', // Ejemplo de tipo de método de pago
        activeTermsCondition:
            false, // Ejemplo de términos y condiciones activos
        actions: {
          "format_pdf": "a4" // Ejemplo de formato de PDF
        }, // Ejemplo de acciones
        payments: [], // Ejemplo de pagos
      );

      // Convierte el objeto de cotización a un mapa JSON
      Map<String, dynamic> cotizacionData = cotizacion.toJson();

      // Llama al servicio para crear la cotización
      final response =
          await _cotizacionService.createCotizacion(cotizacionData);
      if (response.status.hasError) {
        print('Error al crear cotización: ${response.statusText}');
        return;
      }
        print('Respuesta de la API: ${response.body}');

      print('Cotización creada exitosamente');
    } catch (e) {
      print('Error al crear cotización: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
