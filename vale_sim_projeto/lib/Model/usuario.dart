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
}
