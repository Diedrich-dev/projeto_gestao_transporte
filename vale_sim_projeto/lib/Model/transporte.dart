class Transporte {
  int? id;
  String? nome;
  String? numero;
  String? renavam;
  String? placa;
  String? capacidade;
  String? linha;
  String? foto;
  bool favorito;

  Transporte({
    this.id,
    this.nome,
    this.numero,
    this.renavam,
    this.placa,
    this.capacidade,
    this.linha,
    this.foto,
    this.favorito = false,
  });

  factory Transporte.fromMap(Map<String, dynamic> map) {
    return Transporte(
      id: map['id_transporte'],
      nome: map['nome'],
      numero: map['numero'],
      renavam: map['renavam'],
      placa: map['placa'],
      capacidade: map['capacidade'],
      linha: map['linha'],
      favorito: map['favorito'] == 1,
      foto: map['foto'],
    );
  }
}
