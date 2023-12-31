import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vale_sim_projeto/Service/data_components.dart';

import '../Model/transporte.dart';
import 'conexao.dart';

class TransporteService {
  late Database db;

  Future<bool> create(Transporte transporte) async {
    try {
      db = await Conexao.instance.getConexaoDB;
      transporte.id = await db.rawInsert(''' insert into
      $TRANSPORTE_TABLE_NAME(
        $TRANSPORTE_COLUMN_NOME,
        $TRANSPORTE_COLUMN_RENAVAM,
        $TRANSPORTE_COLUMN_PLACA,
        $TRANSPORTE_COLUMN_CAPACIDADE,
        $TRANSPORTE_COLUMN_NUMERO,
        $TRANSPORTE_COLUMN_FAVORITO,
        $TRANSPORTE_COLUMN_LINHA)
        values(
          '${transporte.nome}', '${transporte.renavam}', '${transporte.placa}', '${transporte.capacidade}', '${transporte.numero}', '${0}','${transporte.linha}'
        )''');
      queryAllRows();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    db = await Conexao.instance.getConexaoDB;
    return await db.query(TRANSPORTE_TABLE_NAME);
  }

  Future<List<Transporte>> getAllTransporte() async {
    db = await Conexao.instance.getConexaoDB;
    List<Map> dbResult =
        await db.rawQuery('SELECT * FROM $TRANSPORTE_TABLE_NAME');

    List<Transporte> transportes = [];
    for (var row in dbResult) {
      Transporte transporte = Transporte();
      transporte.id = row['id_transporte'];
      transporte.nome = row['nome'];
      transporte.renavam = row['renavam'];
      transporte.placa = row['placa'];
      transporte.capacidade = row['capacidade'];
      transporte.linha = row['linha'];
      transporte.numero = row['numero'];
      transporte.favorito = row['favorito'] == 1 ? true : false;
      transportes.add(transporte);
    }
    return transportes;
  }

  Future<void> atualizarTransporte(Transporte transporte) async {
    db = await Conexao.instance.getConexaoDB;
    await db.transaction((txn) async {
      await txn.update(
        TRANSPORTE_TABLE_NAME,
        transporte.toMap(),
        where: '$TRANSPORTE_COLUMN_ID = ?',
        whereArgs: [transporte.id],
      );
    });
  }

  Future<void> deleteTransportes(Transporte transporte) async {
    db = await Conexao.instance.getConexaoDB;

    await db.transaction((txn) async {
      await txn.rawDelete(
          'DELETE FROM $FAVORITO_TABLE_NAME WHERE $FAVORITO_COLUMN_TRANSPORTE_ID = ?',
          [transporte.id]
      );

      await txn.rawDelete(
          'DELETE FROM $TRANSPORTE_TABLE_NAME WHERE $TRANSPORTE_COLUMN_ID = ?',
          [transporte.id]
      );
    });
  }

  Future<List<Transporte>> pesquisarTransporte(String filtro) async {
    List<Transporte> transportes = [];
    db = await Conexao.instance.getConexaoDB;
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $TRANSPORTE_TABLE_NAME WHERE $TRANSPORTE_COLUMN_NOME LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      Transporte transporte = Transporte();
      transporte.id = row['id_transporte'];
      transporte.nome = row['nome'];
      transporte.renavam = row['renavam'];
      transporte.placa = row['placa'];
      transporte.numero = row['numero'];
      transporte.favorito = row['favorito'] == 1 ? true : false;
      transporte.capacidade = row['capacidade'];
      transporte.linha = row['linha'];

      transportes.add(transporte);
    }
    return transportes;
  }

  Future<Transporte> pesquisarTransportePorId(int id) async {
    db = await Conexao.instance.getConexaoDB;
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $TRANSPORTE_TABLE_NAME WHERE $TRANSPORTE_COLUMN_ID = ?',
        [id]
        );

    if (dbResult.isNotEmpty) {
      Map row = dbResult.first;

      Transporte transporte = Transporte();
      transporte.id = row['id_transporte'];
      transporte.nome = row['nome'];
      transporte.renavam = row['renavam'];
      transporte.numero = row['numero'];
      transporte.placa = row['placa'];
      transporte.favorito = row['favorito'] == 1 ? true : false;
      transporte.capacidade = row['capacidade'];
      transporte.linha = row['linha'];

      return transporte;
    } else {
      throw Exception(
          'Transporte não encontrado');
    }
  }
}
