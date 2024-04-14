class Categoria {
  final int id;
  final String name;
  final String? image; // Propiedad opcional para la imagen

  Categoria({required this.id, required this.name, this.image});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      name: json['name'],
      image: json['image'], // Asigna el valor de image directamente
    );
  }
}
