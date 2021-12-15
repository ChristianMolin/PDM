class Restaurante {
  final String nome;
  final String images;
  final String nota;
  final String status;

  Restaurante(
      {required this.nome,
      required this.images,
      required this.nota,
      required this.status});

  factory Restaurante.fromJson(dynamic json) {
    return Restaurante(
        nome: json['name'] ?? "Não encontrado",
        nota: json['rating'] ?? "Sem nota",
        status: json['open_now_text'] ?? "Não encontrado",
        images: json['url'] ??
            "https://static.vecteezy.com/ti/vetor-gratis/p3/2293510-ponto-de-interrogacao-sinal-de-neon-vetor.jpg");
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
