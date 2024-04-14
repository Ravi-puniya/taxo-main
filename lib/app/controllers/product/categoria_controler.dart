import 'package:get/get.dart';
import 'package:facturadorpro/api/services/categoria_service.dart';
import 'package:facturadorpro/api/models/categoria.dart'; // Agrega esta línea

class CategoriaController extends GetxController {
  final CategoriaService _categoriaService = Get.find();

  RxList<Categoria> categorias = <Categoria>[].obs;

  @override
  void onInit() {
    super.onInit();
    listarCategorias(); // Llama al método al iniciar el controlador
  }

  void listarCategorias() async {
    print('Obteniendo categorías...');
   
    try {
      var response = await _categoriaService.listarCategorias();
      if (response.status.isOk) {
        List<dynamic> categoriasData = response.body['data'];
        categorias.assignAll(categoriasData.map((categoria) {
          // Obtén la URL completa de la imagen utilizando el dominio
          String domain = _categoriaService.getDomain();
          String imageUrl = '$domain/${categoria['image']}';
          // Crea una nueva instancia de Categoria con la URL completa de la imagen
          return Categoria.fromJson({...categoria, 'image': imageUrl});
        }).toList());
        print('Categorías obtenidas exitosamente.');
      } else {
        print('Error al obtener las categorías: ${response.statusText}');
      }
    } catch (e) {
      print('Error al obtener las categorías: $e');
    }
  }

  Future<void> agregarCategoria(String nombre) async {
    try {
      var response = await _categoriaService.agregarCategoria(nombre);
      if (response.status.isOk) {
        // Actualiza la lista de categorías después de agregar una nueva categoría
        listarCategorias();
        // Aquí puedes manejar la respuesta si es necesario
        print(response.body['msg']);
      } else {
        print('Error al agregar la categoría: ${response.statusText}');
      }
    } catch (e) {
      print('Error al agregar la categoría: $e');
    }
  }
}
