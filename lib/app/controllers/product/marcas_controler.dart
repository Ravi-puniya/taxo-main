import 'package:get/get.dart';
import 'package:facturadorpro/api/services/marcas_service.dart';
import 'package:facturadorpro/api/models/marcas.dart';

class MarcasController extends GetxController {
  final MarcasService _marcaService = Get.find(); // Corregido el nombre del servicio

  RxList<Marcas> marcas = <Marcas>[].obs; // Corregido el nombre de la lista de marcas

  @override
  void onInit() {
    super.onInit();
    listarMarcas(); // Llama al método al iniciar el controlador
  }

  void listarMarcas() async { // Corregido el nombre del método
    print('Obteniendo Marcas...');
   
    try {
      var response = await _marcaService.listarMarcas(); // Corregido el nombre del método del servicio
      if (response.status.isOk) {
        List<dynamic> marcasData = response.body['data'];
        marcas.assignAll(marcasData.map((marca) {
          // Obtén la URL completa de la imagen utilizando el dominio
          String domain = _marcaService.getDomain();
          String imageUrl = '$domain/${marca['image']}';
          // Crea una nueva instancia de Categoria con la URL completa de la imagen
          return Marcas.fromJson({...marca, 'image': imageUrl});
        }).toList());
        print('Categorías obtenidas exitosamente.');
      } else {
        print('Error al obtener las marcas: ${response.statusText}'); // Corregido el mensaje de impresión
      }
    } catch (e) {
      print('Error al obtener las marcas: $e'); // Corregido el mensaje de impresión
    }
  }

  Future<void> agregarMarcas(String nombre) async { // Corregido el nombre del método
    try {
      var response = await _marcaService.agregarMarcas(nombre); // Corregido el nombre del método del servicio
      if (response.status.isOk) {
        // Actualiza la lista de marcas después de agregar una nueva marca
        listarMarcas(); // Corregido el nombre del método
        // Aquí puedes manejar la respuesta si es necesario
        print(response.body['msg']); // Corregido el mensaje de impresión
      } else {
        print('Error al agregar la marca: ${response.statusText}'); // Corregido el mensaje de impresión
      }
    } catch (e) {
      print('Error al agregar la marca: $e'); // Corregido el mensaje de impresión
    }
  }
}
