class Marcas {
  final int id;
  final String name;
  final String? image; // Propiedad opcional para la imagen

  Marcas({required this.id, required this.name, this.image});

  factory Marcas.fromJson(Map<String, dynamic> json) {
    return Marcas(
      id: json['id'],
      name: json['name'],
      image: json['image'], // Asigna el valor de image directamente
    );
  }
}
