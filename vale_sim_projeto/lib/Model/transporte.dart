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
      id: map['id_transporte'] as int,
      nome: map['nome'] as String,
      numero: map['numero'] as String,
      renavam: map['renavam'] as String,
      placa: map['placa'] as String,
      capacidade: map['capacidade'] as String,
      linha: map['linha'] as String,
      favorito: map['favorito'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_transporte': id,
      'nome': nome,
      'numero': numero,
      'renavam': renavam,
      'placa': placa,
      'capacidade': capacidade,
      'linha': linha,
      'favorito': favorito == true ? 1 : 0,
    };
  }
}
