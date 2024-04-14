import 'package:get/get.dart';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/api/models/cotizacion.dart';

class CotizacionService extends GetConnect {
  final GetStorage storage = GetStorage();

  String getDomain() {
    return storage.read('domain') ?? '';
  }

  void updateBaseUrlAndHeaders() {
    String? domain = storage.read('domain');
    String? token = storage.read('token');

    allowAutoSignedCert = true;
    httpClient.baseUrl = "$domain/api";

    if (token != null) {
      httpClient.addRequestModifier<void>((request) {
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-Type'] = 'application/json; charset=utf-8';
        return request;
      });
    }

    httpClient.addResponseModifier((request, response) {
      if ([500, 400, 405].contains(response.statusCode)) {
        displayErrorMessage();
      }
      if (response.statusCode == 404) {
        displayErrorMessage(message: "La ruta no fue encontrada");
      }
      return response;
    });
  }

  @override
  void onInit() {
    updateBaseUrlAndHeaders();
    super.onInit();
  }

  Future<Response> filterClients() async {
    print('Realizando solicitud para obtener clientes');
    // Antes de realizar la solicitud, actualiza la URL base y los encabezados
    updateBaseUrlAndHeaders();
    return await get("/persons/customers/records");
  }

  
  // Future<Response> filteritems() async {
  //   print('Realizando solicitud para obtener productos');
  //   // Antes de realizar la solicitud, actualiza la URL base y los encabezados
  //   updateBaseUrlAndHeaders();
  //   return await get("/items");
  // }

  Future<List<Map<String, dynamic>>> filterItems() async {
    print('Realizando solicitud para obtener productos');
    updateBaseUrlAndHeaders();
    final response = await get("/items");
    if (response.status.hasError) {
      return [];
    } else {
      final data = response.body['data']['items'];
      return List<Map<String, dynamic>>.from(data);
    }
  }

// Future<Response> createCotizacion(Map<String, dynamic> data) async {
//   // Antes de realizar la solicitud, actualiza la URL base y los encabezados
//   updateBaseUrlAndHeaders();
  
//   // Obtenemos la URL completa concatenando la baseUrl con la ruta "/quotations"
//   String url = "${httpClient.baseUrl}/quotations";
  
//   // Imprimimos la URL
//   print("URL de la solicitud de creación de cotización: $url");

//   // Realizamos la solicitud POST y devolvemos la respuesta
//   return await post("/quotations", data);
// }

Future<Response> createCotizacion(Map<String, dynamic> data) async {
  // Antes de realizar la solicitud, actualiza la URL base y los encabezados
  updateBaseUrlAndHeaders();
  // String url = "${httpClient.baseUrl}/quotations";
  // Imprime los datos que se enviarán en la solicitud
  printLongString('Datos de la cotización: '+jsonEncode(data));
  //   // Imprimimos la URL
  // print("URL de la solicitud de creación de cotización: $url");
  // Realizamos la solicitud POST y devolvemos la respuesta
  return await post("/quotations", data);
}

void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
}
//sacar  listado sale_affectation_igv_type

  Future<Response> initParamsProduct() async {
    return await get("/app/items/tables");
  }
}