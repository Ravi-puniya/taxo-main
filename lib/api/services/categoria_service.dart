import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/api/models/categoria.dart';

class CategoriaService extends GetConnect {
  final GetStorage storage = GetStorage();

  // Método para obtener el dominio almacenado en GetStorage
  String getDomain() {
    return storage.read('domain') ?? ''; // Devuelve el dominio o una cadena vacía si no está definido
  }

  // Método para actualizar la URL base y los encabezados de autorización
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
    // Llama a updateBaseUrlAndHeaders() en la inicialización del servicio
    updateBaseUrlAndHeaders();
    super.onInit();
  }

  // Método para obtener la lista de categorías
  Future<Response> listarCategorias() async {
    print('Realizando solicitud para obtener categorías...');
    // Antes de realizar la solicitud, actualiza la URL base y los encabezados
    updateBaseUrlAndHeaders();
    return await get("/categories-records");
  }

  // Método para agregar una nueva categoría
  Future<Response> agregarCategoria(String nombre) async {
    // Antes de realizar la solicitud, actualiza la URL base y los encabezados
    updateBaseUrlAndHeaders();
    Map<String, dynamic> body = {"name": nombre};
    return await post("/categories", body);
  }
}
