class Restaurante {
  final String nome;
  final String images;
  final String nota;
  final String status;

  Restaurante({this.nome, this.images, this.nota, this.status});

  factory Restaurante.fromJson(dynamic json) {
    return Restaurante(
        nome: json['name'] as String,
        nota: json['rating'] as String,
        status: json['open_now_text'] as String,
        images: json['photo'][0]['url'] as String);
  }

  static List<Restaurante> restaurantesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Restaurante.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Restaurante {name: $nome, images: $images nota: $nota, aberto: $status}';
  }
}
