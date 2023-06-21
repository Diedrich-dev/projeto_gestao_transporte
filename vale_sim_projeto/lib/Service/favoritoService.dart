import 'package:sqflite/sqflite.dart';
import 'package:vale_sim_projeto/Service/conexao.dart';
import 'package:vale_sim_projeto/Model/transporte.dart';
import 'package:vale_sim_projeto/Model/usuario.dart';
import 'package:vale_sim_projeto/Service/data_components.dart';

class FavoritoService {
  late Database db;

  Future<void> adicionarFavorito(Usuario usuario, Transporte transporte) async {
    try {
      db = await Conexao.instance.getConexaoDB;
      await db.insert(
        FAVORITO_TABLE_NAME,
        {
          FAVORITO_COLUMN_USUARIO_ID: usuario.id,
          FAVORITO_COLUMN_TRANSPORTE_ID: transporte.id,
        },
      );
    } catch (ex) {
      throw Exception('Erro ao adicionar transporte favorito');
    }
  }

  Future<List<Transporte>> getTransportesFavoritos(int id) async {
    db = await Conexao.instance.getConexaoDB;
    final dbResult = await db.rawQuery('''
    SELECT $TRANSPORTE_TABLE_NAME.id_transporte, $TRANSPORTE_TABLE_NAME.nome, $TRANSPORTE_TABLE_NAME.linha,
    $TRANSPORTE_TABLE_NAME.renavam, $TRANSPORTE_TABLE_NAME.placa, $TRANSPORTE_TABLE_NAME.capacidade, $TRANSPORTE_TABLE_NAME.numero
    FROM $TRANSPORTE_TABLE_NAME
    JOIN $FAVORITO_TABLE_NAME ON $FAVORITO_TABLE_NAME.$FAVORITO_COLUMN_TRANSPORTE_ID = $TRANSPORTE_TABLE_NAME.$TRANSPORTE_COLUMN_ID
    WHERE $FAVORITO_COLUMN_USUARIO_ID = ?
  ''', [id]);

    return dbResult.map((row) => Transporte.fromMap(row)).toList();
  }

  Future<void> removerFavorito(int usuarioId, int transporteId) async {
    db = await Conexao.instance.getConexaoDB;
    await db.delete(
      FAVORITO_TABLE_NAME,
      where: '$FAVORITO_COLUMN_USUARIO_ID = ? AND $FAVORITO_COLUMN_TRANSPORTE_ID = ?',
      whereArgs: [usuarioId, transporteId],
    );
  }

  Future<bool> verificarFavorito(int usuarioId, int transporteId) async {
    db = await Conexao.instance.getConexaoDB;
    final count = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) FROM $FAVORITO_TABLE_NAME
    WHERE $FAVORITO_COLUMN_USUARIO_ID = ?
    AND $FAVORITO_COLUMN_TRANSPORTE_ID = ?
  ''', [usuarioId, transporteId]));

    return count! > 0;
  }
}
