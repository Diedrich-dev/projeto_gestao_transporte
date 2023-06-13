import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vale_sim_projeto/Service/data_components.dart';

import '../Model/usuario.dart';
import 'conexao.dart';

class UsuarioService {
  Future<bool> create(Usuario usuario) async {
    try{
      final Database db = await Conexao.getConexaoDB();
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

  Future <List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(USUARIO_TABLE_NAME);
  }

  Future<List<Usuario>> getAllUsuario() async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery('SELECT * FROM $USUARIO_TABLE_NAME');
  
    List<Usuario> usuarios = [];
    for (var row in dbResult){
      Usuario usuario = Usuario();
      usuario.id = row['id_usuario'];
      usuario.nome = row['nome'];
      usuario.sobrenome = row['sobrenome'];
      usuario.email = row ['email'];
      usuario.senha = row ['senha'];
      usuarios.add(usuario);
    }
    return usuarios;
  }

  Future<void> atualizarUsuario(Usuario usuario) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
      'update $USUARIO_TABLE_NAME set $USUARIO_COLUMN_NOME = ?, $USUARIO_COLUMN_SOBRENOME = ?, $USUARIO_COLUMN_EMAIL = ?, $USUARIO_COLUMN_SENHA = ?, where id = ?',
      [usuario.nome, usuario.sobrenome, usuario.email, usuario.senha]);
    });
  }

  Future<void> deleteUsuarios(Usuario usuario) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
        'DELETE FROM $USUARIO_TABLE_NAME WHERE id = ?', [usuario.id]
      );
    });
  }

  Future<List<Usuario>> pesquisarUsuario(String filtro) async {
    List<Usuario> usuarios = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
      'SELECT * FROM $USUARIO_TABLE_NAME WHERE $USUARIO_COLUMN_NOME LIKE ?',
      ['%$filtro%']
    );
    for (var row in dbResult){
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
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
      'SELECT * FROM $USUARIO_TABLE_NAME WHERE $USUARIO_COLUMN_EMAIL = "${email}" and $USUARIO_COLUMN_SENHA = "${senha}"'
    );

    if(dbResult.isEmpty){
      return true;
    }else{
      return false;
    }
  }
}