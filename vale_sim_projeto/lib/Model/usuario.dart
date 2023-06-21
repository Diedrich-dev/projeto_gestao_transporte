import 'package:vale_sim_projeto/Model/transporte.dart';

class Usuario {
  int? id;
  String? nome;
  String? sobrenome;
  String? senha;
  String? email;
  List<Transporte> transportesFavoritos;

  Usuario({
    this.id,
    this.nome,
    this.sobrenome,
    this.senha,
    this.email,
    this.transportesFavoritos = const [],
  });

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id_usuario'],
      nome: map['nome'],
      sobrenome: map['sobrenome'],
      senha: map['senha'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_usuario': id,
      'nome': nome,
      'sobrenome': sobrenome,
      'senha': senha,
      'email': email,
    };
  }
}
