import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vale_sim_projeto/Model/transporte.dart';
import 'package:vale_sim_projeto/Service/data_components.dart';
import 'package:vale_sim_projeto/Service/favoritoService.dart';

import '../Model/usuario.dart';
import 'conexao.dart';

class UsuarioService {
  late Database db;

  Future<bool> create(Usuario usuario) async {
    try {
      db = await Conexao.instance.getConexaoDB;
      usuario.id = await db.rawInsert(''' insert into
      $USUARIO_TABLE_NAME(
        $USUARIO_COLUMN_NOME,
        $USUARIO_COLUMN_SOBRENOME,
        $USUARIO_COLUMN_EMAIL,
        $USUARIO_COLUMN_SENHA
        values(
          '${usuario.nome}', '${usuario.sobrenome}', '${usuario.email}', '${usuario.senha}'
        )''');
      queryAllRows();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    db = await Conexao.instance.getConexaoDB;
    return await db.query(USUARIO_TABLE_NAME);
  }

  Future<List<Usuario>> getAllUsuario() async {
    db = await Conexao.instance.getConexaoDB;
    List<Map> dbResult = await db.rawQuery('SELECT * FROM $USUARIO_TABLE_NAME');

    List<Usuario> usuarios = [];
    for (var row in dbResult) {
      Usuario usuario = Usuario();
      usuario.id = row['id_usuario'];
      usuario.nome = row['nome'];
      usuario.sobrenome = row['sobrenome'];
      usuario.email = row['email'];
      usuario.senha = row['senha'];
      usuarios.add(usuario);
    }
    return usuarios;
  }

  // Future<void> atualizarUsuario(Usuario usuario) async {
  //   db = await Conexao.instance.getConexaoDB;
  //   await db.transaction((txn) async {
  //     await txn.rawUpdate(
  //         'update $USUARIO_TABLE_NAME set $USUARIO_COLUMN_NOME = ?, $USUARIO_COLUMN_SOBRENOME = ?, $USUARIO_COLUMN_EMAIL = ?, $USUARIO_COLUMN_SENHA = ?, where id = ?',
  //         [usuario.nome, usuario.sobrenome, usuario.email, usuario.senha]);
  //   });
  // }

  Future<void> atualizarUsuario(Usuario usuario) async {
    db = await Conexao.instance.getConexaoDB;
    await db.transaction((txn) async {
      await txn.update(
        USUARIO_TABLE_NAME,
        usuario.toMap(),
        where: '$USUARIO_COLUMN_ID = ?',
        whereArgs: [usuario.id],
      );
    });
  }

  Future<void> deleteUsuarios(Usuario usuario) async {
    db = await Conexao.instance.getConexaoDB;
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $USUARIO_TABLE_NAME WHERE id = ?', [usuario.id]);
    });
  }

  Future<List<Usuario>> pesquisarUsuario(String filtro) async {
    List<Usuario> usuarios = [];
    db = await Conexao.instance.getConexaoDB;
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $USUARIO_TABLE_NAME WHERE $USUARIO_COLUMN_NOME LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      Usuario usuario = Usuario();
      usuario.id = row['id_usuario'];
      usuario.nome = row['nome'];
      usuario.sobrenome = row['sobrenome'];
      usuario.email = row['email'];
      usuario.senha = row['senha'];

      usuarios.add(usuario);
    }
    return usuarios;
  }

  Future<bool> getUsuarioLogin(email, senha) async {
    db = await Conexao.instance.getConexaoDB;
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $USUARIO_TABLE_NAME WHERE $USUARIO_COLUMN_EMAIL = "${email}" and $USUARIO_COLUMN_SENHA = "${senha}"');

    if (dbResult.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getPerfilLogado(email) async {
    db = await Conexao.instance.getConexaoDB;
    String nome = '';
    List<Map> dbResult = await db.rawQuery(
        'SELECT * from $USUARIO_TABLE_NAME where $USUARIO_COLUMN_EMAIL = $email ');

    for (var row in dbResult) {
      nome = row['nome'];
    }
    return nome;
  }

  Future<Usuario> getUsuarioLogado(String email) async {
    db = await Conexao.instance.getConexaoDB;
    final usuarioResult = await db.query('usuario', where: 'email = ?', whereArgs: [email]);

    if (usuarioResult.isNotEmpty) {
      final usuario = Usuario.fromMap(usuarioResult.first);

      if (usuario.id != null) {
        // Busca os transportes favoritos do usuário
        List<Transporte> dbTransportesFavoritosResult = await FavoritoService().getTransportesFavoritos(usuario.id as int);

        // Converte os resultados em objetos Transporte e atribui ao usuário
        usuario.transportesFavoritos =
            dbTransportesFavoritosResult.map((row) => Transporte.fromMap(row as Map<String, dynamic>)).toList();
      }
      return usuario;
    } else {
      throw Exception('Usuário não encontrado');
    }
  }



}
