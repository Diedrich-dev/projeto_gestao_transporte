import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vale_sim_projeto/Service/data_components.dart';

import '../Model/transporte.dart';
import 'conexao.dart';

class TransporteService {

  Future<bool> create(Transporte transporte) async {
    try {
      final Database db = await Conexao.getConexaoDB();
      transporte.id = await db.rawInsert(''' insert into
      $TRANSPORTE_TABLE_NAME(
        $TRANSPORTE_COLUMN_NOME,
        $TRANSPORTE_COLUMN_RENAVAM,
        $TRANSPORTE_COLUMN_PLACA,
        $TRANSPORTE_COLUMN_CAPACIDADE,
        $TRANSPORTE_COLUMN_LINHA
        values(
          '${transporte.nome}', '${transporte.renavam}', '${transporte.placa}', '${transporte.capacidade}', '${transporte.linha}'
        )''');
      queryAllRows();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(TRANSPORTE_TABLE_NAME);
  }

  Future<List<Transporte>> getAllTransporte() async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult =
        await db.rawQuery('SELECT * FROM $TRANSPORTE_TABLE_NAME');

    List<Transporte> transportes = [];
    for (var row in dbResult) {
      Transporte transporte = Transporte();
      transporte.id = row['id_Transporte'];
      transporte.nome = row['nome'];
      transporte.renavam = row['renavam'];
      transporte.placa = row['placa'];
      transporte.capacidade = row['capacidade'];
      transporte.linha = row['linha'];
      transportes.add(transporte);
    }
    return transportes;
  }

  Future<void> atualizarTransporte(Transporte transporte) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $TRANSPORTE_TABLE_NAME set $TRANSPORTE_COLUMN_NOME = ?, $TRANSPORTE_COLUMN_RENAVAM = ?, $TRANSPORTE_COLUMN_PLACA = ?,  $TRANSPORTE_COLUMN_CAPACIDADE = ?, $TRANSPORTE_COLUMN_LINHA = ?, where id = ?',
          [
            transporte.nome,
            transporte.renavam,
            transporte.placa,
            transporte.capacidade,
            transporte.linha
          ]);
    });
  }

  Future<void> deleteTransportes(Transporte transporte) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $TRANSPORTE_TABLE_NAME WHERE id = ?', [transporte.id]);
    });
  }

  Future<List<Transporte>> pesquisarTransporte(String filtro) async {
    List<Transporte> transportes = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $TRANSPORTE_TABLE_NAME WHERE $TRANSPORTE_COLUMN_NOME LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      Transporte transporte = Transporte();
      transporte.id = row['id_Transporte'];
      transporte.nome = row['nome'];
      transporte.renavam = row['renavam'];
      transporte.placa = row['placa'];
      transporte.capacidade = row['capacidade'];
      transporte.linha = row['linha'];

      transportes.add(transporte);
    }
    return transportes;
  }

  Future<Transporte> pesquisarTransportePorId(int id) async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $TRANSPORTE_TABLE_NAME WHERE $TRANSPORTE_COLUMN_ID = ?',
        [id] // Utilize o parâmetro "id" fornecido na consulta
        );

    if (dbResult.isNotEmpty) {
      Map row = dbResult.first;

      Transporte transporte = Transporte();
      transporte.id = row['id_Transporte'];
      transporte.nome = row['nome'];
      transporte.renavam = row['renavam'];
      transporte.placa = row['placa'];
      transporte.capacidade = row['capacidade'];
      transporte.linha = row['linha'];

      return transporte;
    } else {
      throw Exception(
          'Transporte não encontrado'); // Throw an exception to indicate that the transportation was not found
    }
  }
}
